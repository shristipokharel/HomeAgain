package com.example.homeagain.dao;

import com.example.homeagain.model.Admin;
import com.example.homeagain.model.Role;
import com.example.homeagain.utils.DBConnection;
import com.example.homeagain.utils.PasswordUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    
    public boolean createAdmin(Admin admin) {
        String adminQuery = "INSERT INTO admins (username, password, email, full_name) VALUES (?, ?, ?, ?)";
        String roleQuery = "INSERT INTO roles (name, description) VALUES (?, 'Admin')";
        
        try (Connection conn = DBConnection.getConnection()) {
            // Start transaction
            conn.setAutoCommit(false);
            
            try {
                // First create the admin
                PreparedStatement adminStmt = conn.prepareStatement(adminQuery);
                adminStmt.setString(1, admin.getUsername());
                adminStmt.setString(2, admin.getPassword());
                adminStmt.setString(3, admin.getEmail());
                adminStmt.setString(4, admin.getFullName());
                
                int adminRowsAffected = adminStmt.executeUpdate();
                
                if (adminRowsAffected > 0) {
                    // Then create the role
                    PreparedStatement roleStmt = conn.prepareStatement(roleQuery);
                    roleStmt.setString(1, admin.getUsername());
                    roleStmt.executeUpdate();
                    
                    // Commit transaction
                    conn.commit();
                    return true;
                }
                
                // If admin creation failed, rollback
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
    
    public Admin getAdminById(int id) {
        String query = "SELECT * FROM admins WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractAdminFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public Admin authenticateAdmin(String username, String password) {
    Admin admin = getAdminByUsername(username);

    if (admin != null) {
        String salt = getAdminSalt(admin.getId());
        boolean isValid = PasswordUtils.verifyPassword(password, admin.getPassword(), salt);
        if (isValid) {
            return admin;
        }
    }
    return null;
}

public Admin getAdminByUsername(String username) {
        String query = "SELECT * FROM admins WHERE username = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractAdminFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    public List<Admin> getAllAdmins() {
        List<Admin> admins = new ArrayList<>();
        String query = "SELECT * FROM admins";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Admin admin = extractAdminFromResultSet(rs);
                admins.add(admin);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return admins;
    }
    
    public boolean updateAdmin(Admin admin) {
        String query = "UPDATE admins SET username = ?, password = ?, email = ?, full_name = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, admin.getUsername());
            stmt.setString(2, admin.getPassword());
            stmt.setString(3, admin.getEmail());
            stmt.setString(4, admin.getFullName());
            stmt.setInt(5, admin.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteAdmin(int id) {
        String query = "DELETE FROM admins WHERE id = ?";
        
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
    

    
    private String getAdminSalt(int adminId) {
        String query = "SELECT salt FROM admins WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, adminId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getString("salt");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Admin extractAdminFromResultSet(ResultSet rs) throws SQLException {
        return new Admin(
            rs.getInt("id"),
            rs.getString("username"),
            rs.getString("password"),
            rs.getString("email"),
            rs.getString("full_name"),
            rs.getTimestamp("created_at")
        );
    }
} 