package com.example.homeagain.utils;

import com.example.homeagain.dao.AdminDAO;
import com.example.homeagain.model.Admin;

import java.sql.Timestamp;
import java.util.Scanner;

/**
 * Command-line utility to create admin users.
 * Run this directly from the terminal to add a new admin to the database.
 * 
 * Usage: java -cp [classpath] com.example.homeagain.utils.AdminCreationTool
 */
public class AdminCreationTool {
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("===== HomeAgain Admin Creation Tool =====");
        System.out.println("This utility will help you create a new administrator account.");
        System.out.println("The information will be stored securely in the database.");
        System.out.println("Press Ctrl+C at any time to cancel the operation.");
        System.out.println("==========================================");
        
        // Get username
        System.out.print("Enter admin username: ");
        String username = scanner.nextLine().trim();
        
        // Validate username
        if (username.isEmpty()) {
            System.out.println("Error: Username cannot be empty");
            scanner.close();
            return;
        }
        
        // Check if username already exists
        AdminDAO adminDAO = new AdminDAO();
        Admin existingAdmin = adminDAO.getAdminByUsername(username);
        if (existingAdmin != null) {
            System.out.println("Error: Username already exists. Please choose a different username.");
            scanner.close();
            return;
        }
        
        // Get password
        System.out.print("Enter password: ");
        String password = scanner.nextLine().trim();
        
        // Validate password
        if (password.isEmpty()) {
            System.out.println("Error: Password cannot be empty");
            scanner.close();
            return;
        }
        
        // Confirm password
        System.out.print("Confirm password: ");
        String confirmPassword = scanner.nextLine().trim();
        
        if (!password.equals(confirmPassword)) {
            System.out.println("Error: Passwords do not match");
            scanner.close();
            return;
        }
        
        // Get email
        System.out.print("Enter email: ");
        String email = scanner.nextLine().trim();
        
        // Validate email
        if (email.isEmpty() || !email.contains("@")) {
            System.out.println("Error: Invalid email format");
            scanner.close();
            return;
        }
        
        // Get full name
        System.out.print("Enter full name: ");
        String fullName = scanner.nextLine().trim();
        
        // Validate full name
        if (fullName.isEmpty()) {
            System.out.println("Error: Full name cannot be empty");
            scanner.close();
            return;
        }
        
        // Final confirmation
        System.out.println("\nPlease review the information:");
        System.out.println("Username: " + username);
        System.out.println("Email: " + email);
        System.out.println("Full Name: " + fullName);
        System.out.print("\nCreate this admin account? (y/n): ");
        
        String confirmation = scanner.nextLine().trim().toLowerCase();
        
        if (confirmation.equals("y") || confirmation.equals("yes")) {
            // Generate salt and hash the password
            String salt = PasswordUtils.generateSalt();
            String hashedPassword = PasswordUtils.hashPassword(password, salt);
            
            // Create admin object
            Admin newAdmin = new Admin(0, username, hashedPassword, email, fullName, new Timestamp(System.currentTimeMillis()));
            
            try {
                boolean created = createAdminWithSalt(newAdmin, salt);
                
                if (created) {
                    System.out.println("\nAdmin account created successfully!");
                    System.out.println("The administrator can now log in through the admin login page.");
                } else {
                    System.out.println("\nError: Failed to create admin account. Please check database connection.");
                }
            } catch (Exception e) {
                System.out.println("\nError occurred: " + e.getMessage());
                e.printStackTrace();
            }
        } else {
            System.out.println("Operation cancelled. No admin account was created.");
        }
        
        scanner.close();
    }
    
    /**
     * Creates an admin account with the provided salt
     */
    private static boolean createAdminWithSalt(Admin admin, String salt) {
        // First create the admin
        AdminDAO adminDAO = new AdminDAO();
        boolean adminCreated = adminDAO.createAdmin(admin);
        
        if (!adminCreated) {
            return false;
        }
        
        // Now store the salt
        try {
            return storeSaltForAdmin(admin.getUsername(), salt);
        } catch (Exception e) {
            System.out.println("Warning: Admin created but failed to store salt: " + e.getMessage());
            return true; // Admin was still created
        }
    }
    
    /**
     * Stores the salt for the specified admin
     */
    private static boolean storeSaltForAdmin(String username, String salt) {
        String query = "UPDATE admins SET salt = ? WHERE username = ?";
        
        try (java.sql.Connection conn = DBConnection.getConnection();
             java.sql.PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, salt);
            stmt.setString(2, username);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}