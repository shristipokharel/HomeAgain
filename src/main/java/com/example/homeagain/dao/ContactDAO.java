package com.example.homeagain.dao;

import com.example.homeagain.model.Contact;
import com.example.homeagain.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class ContactDAO {
    private static final Logger LOGGER = Logger.getLogger(ContactDAO.class.getName());

    public boolean createContact(Contact contact) {
        String query = "INSERT INTO contacts (name, email, subject, message, user_id) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, contact.getName());
            stmt.setString(2, contact.getEmail());
            stmt.setString(3, contact.getSubject());
            stmt.setString(4, contact.getMessage());
            stmt.setObject(5, contact.getUserId());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        contact.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating contact message", e);
            return false;
        }
    }

    public List<Contact> getAllContacts() {
        List<Contact> contacts = new ArrayList<>();
        String query = "SELECT * FROM contacts ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Contact contact = extractContactFromResultSet(rs);
                contacts.add(contact);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching all contacts", e);
        }
        
        return contacts;
    }

    public Contact getContactById(int id) {
        String query = "SELECT * FROM contacts WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractContactFromResultSet(rs);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching contact by ID", e);
        }
        
        return null;
    }

    public List<Contact> getContactsByUserId(int userId) {
        List<Contact> contacts = new ArrayList<>();
        String query = "SELECT * FROM contacts WHERE user_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Contact contact = extractContactFromResultSet(rs);
                contacts.add(contact);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching contacts by user ID", e);
        }
        
        return contacts;
    }

    public boolean deleteContact(int id) {
        String query = "DELETE FROM contacts WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting contact", e);
            return false;
        }
    }

    private Contact extractContactFromResultSet(ResultSet rs) throws SQLException {
        Contact contact = new Contact();
        contact.setId(rs.getInt("id"));
        contact.setName(rs.getString("name"));
        contact.setEmail(rs.getString("email"));
        contact.setSubject(rs.getString("subject"));
        contact.setMessage(rs.getString("message"));
        contact.setUserId(rs.getObject("user_id", Integer.class));
        contact.setCreatedAt(rs.getTimestamp("created_at"));
        return contact;
    }
} 