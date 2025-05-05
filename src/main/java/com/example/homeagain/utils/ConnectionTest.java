package com.example.homeagain.utils;

import java.sql.Connection;
import java.sql.SQLException;

public class ConnectionTest {
    public static void main(String[] args) {
        System.out.println("Testing database connection...");
        
        try {
            // Get a connection
            Connection conn = DBConnection.getConnection();
            
            // If we get here, connection was successful
            System.out.println("✅ Database connection successful!");
            System.out.println("Connected to: " + conn.getMetaData().getURL());
            System.out.println("Database product: " + conn.getMetaData().getDatabaseProductName());
            System.out.println("Database version: " + conn.getMetaData().getDatabaseProductVersion());
            
            // Close the connection
            DBConnection.closeConnection(conn);
        } catch (SQLException e) {
            // If we get here, connection failed
            System.out.println("❌ Database connection failed!");
            System.out.println("Error message: " + e.getMessage());
            
            // Print some troubleshooting tips
            System.out.println("\nTroubleshooting tips:");
            System.out.println("1. Make sure your MySQL server is running");
            System.out.println("2. Check if database 'homeagain' exists");
            System.out.println("3. Verify username and password in DBConnection.java");
            System.out.println("4. Confirm port number (default is 3306)");
            System.out.println("5. Make sure MySQL Connector JAR is in your classpath");
        }
    }
} 