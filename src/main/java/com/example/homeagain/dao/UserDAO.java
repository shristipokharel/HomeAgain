package com.example.homeagain.dao;

import com.example.homeagain.model.User;
import com.example.homeagain.model.Role;
import com.example.homeagain.utils.DBConnection;
import com.example.homeagain.utils.PasswordUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    // Create a new user
    public boolean createUser(User user) {
        String userQuery = "INSERT INTO users (username, password, salt, email, full_name, phone_number, is_active) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String roleQuery = "INSERT INTO roles (name, description) VALUES (?, 'User')";
        
        try (Connection conn = DBConnection.getConnection()) {
            // Start transaction
            conn.setAutoCommit(false);
            
            try {
                // First create the user
                PreparedStatement userStmt = conn.prepareStatement(userQuery);
                userStmt.setString(1, user.getUsername());
                userStmt.setString(2, user.getPassword());
                userStmt.setString(3, user.getSalt());
                userStmt.setString(4, user.getEmail());
                userStmt.setString(5, user.getFullName());
                userStmt.setString(6, user.getPhoneNumber());
                userStmt.setBoolean(7, user.isActive());
                
                int userRowsAffected = userStmt.executeUpdate();
                
                if (userRowsAffected > 0) {
                    // Then create the role
                    PreparedStatement roleStmt = conn.prepareStatement(roleQuery);
                    roleStmt.setString(1, user.getUsername());
                    roleStmt.executeUpdate();
                    
                    // Commit transaction
                    conn.commit();
                    return true;
                }
                
                // If user creation failed, rollback
                conn.rollback();
                return false;
                
            } catch (SQLException e) {
                // If any error occurs, rollback
                conn.rollback();
                e.printStackTrace();
                return false;
            } finally {
                // Reset auto-commit
                conn.setAutoCommit(true);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Find user by ID
    public User getUserById(int id) {
        String query = "SELECT * FROM users WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    // Authenticate user
    public User authenticateUser(String username, String password) {
        // First get the user by username
        User user = getUserByUsername(username);
        
        if (user != null) {
            // Verify the password
            boolean isValid = PasswordUtils.verifyPassword(password, user.getPassword(), user.getSalt());
            if (isValid) {
                return user;
            }
        }
        
        return null;
    }
    
    
    // Find user by username
    public User getUserByUsername(String username) {
        String query = "SELECT * FROM users WHERE username = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Find user by email
    public User getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractUserFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Get all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                User user = extractUserFromResultSet(rs);
                users.add(user);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return users;
    }
    
    // Update user
    public boolean updateUser(User user) {
        String query = "UPDATE users SET username = ?, password = ?, salt = ?, email = ?, full_name = ?, phone_number = ?, is_active = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getSalt());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getFullName());
            stmt.setString(6, user.getPhoneNumber());
            stmt.setBoolean(7, user.isActive());
            stmt.setInt(8, user.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete user
    public boolean deleteUser(int id) {
        String query = "DELETE FROM users WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    // Helper method to extract user from ResultSet
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User(
            rs.getInt("id"),
            rs.getString("username"),
            rs.getString("password"),
            rs.getString("email"),
            rs.getString("full_name"),
            rs.getString("phone_number"),
            rs.getBoolean("is_active"),
            rs.getTimestamp("created_at")
        );
        user.setSalt(rs.getString("salt"));
        return user;
    }
} 