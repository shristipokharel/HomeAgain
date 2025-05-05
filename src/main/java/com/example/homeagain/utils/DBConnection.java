package com.example.homeagain.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Utility class for managing database connections
 */
public class DBConnection {
    private static final Logger LOGGER = Logger.getLogger(DBConnection.class.getName());
    
    // Database connection parameters
    private static final String URL = "jdbc:mysql://localhost:3306/homeagain?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USERNAME = "root"; 
    private static final String PASSWORD = ""; 

    /**
     * Static block to register the JDBC driver
     */
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            LOGGER.info("MySQL JDBC Driver registered successfully");
            
            // Test the connection on startup
            if (testConnection()) {
                LOGGER.info("Initial database connection test successful");
            } else {
                LOGGER.severe("Initial database connection test failed");
            }
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Failed to register MySQL driver", e);
            throw new RuntimeException("Failed to register MySQL driver: " + e.getMessage());
        }
    }

    /**
     * Get a connection to the database
     * 
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Set connection properties for better reliability
            Properties properties = new Properties();
            properties.setProperty("user", USERNAME);
            properties.setProperty("password", PASSWORD);
            properties.setProperty("autoReconnect", "true");
            properties.setProperty("useSSL", "false");
            properties.setProperty("allowPublicKeyRetrieval", "true");
            properties.setProperty("serverTimezone", "UTC");
            
            // Create connection with extended properties
            Connection conn = DriverManager.getConnection(URL, properties);
            
            // Print connection info for debugging
            LOGGER.info("Database connection established successfully");
            
            return conn;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Failed to connect to database", e);
            throw new SQLException("Failed to connect to database: " + e.getMessage(), e);
        }
    }

    /**
     * Close a database connection safely
     * 
     * @param connection Connection to close
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                LOGGER.info("Database connection closed successfully");
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Error closing database connection", e);
            }
        }
    }

    /**
     * Test the database connection
     * 
     * @return true if connection is successful, false otherwise
     */
    public static boolean testConnection() {
        Connection conn = null;
        try {
            conn = getConnection();
            LOGGER.info("Database test connection successful");
            return true;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database test connection failed", e);
            return false;
        } finally {
            closeConnection(conn);
        }
    }
} 