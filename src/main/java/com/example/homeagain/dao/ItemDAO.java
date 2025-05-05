package com.example.homeagain.dao;

import com.example.homeagain.model.Item;
import com.example.homeagain.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class ItemDAO {
    private static final Logger LOGGER = Logger.getLogger(ItemDAO.class.getName());
    
    // Test method to verify database setup
    public boolean testDatabaseSetup() {
        try (Connection conn = DBConnection.getConnection()) {
            LOGGER.info("Testing database setup...");
            
            // Check if items table exists
            try (Statement stmt = conn.createStatement()) {
                ResultSet rs = stmt.executeQuery("SHOW TABLES LIKE 'items'");
                if (!rs.next()) {
                    LOGGER.severe("Items table does not exist!");
                    return false;
                }
                LOGGER.info("Items table exists");
                
                // Check table structure
                rs = stmt.executeQuery("DESCRIBE items");
                while (rs.next()) {
                    LOGGER.info("Column: " + rs.getString("Field") + " - Type: " + rs.getString("Type"));
                }
                
                // Check if we can insert a test item
                String testQuery = "INSERT INTO items (title, description, category_id, location, post_type, status, user_id, posted_at) " +
                                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(testQuery)) {
                    pstmt.setString(1, "Test Item");
                    pstmt.setString(2, "Test Description");
                    pstmt.setInt(3, 1); // Assuming category 1 exists
                    pstmt.setString(4, "Test Location");
                    pstmt.setString(5, "lost");
                    pstmt.setString(6, "pending");
                    pstmt.setInt(7, 1); // Assuming user 1 exists
                    pstmt.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
                    
                    int result = pstmt.executeUpdate();
                    LOGGER.info("Test insert result: " + result + " rows affected");
                    return result > 0;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database setup test failed", e);
            return false;
        }
    }
    
    // Create a new item
    public boolean createItem(Item item) {
        String query = "INSERT INTO items (title, description, category_id, image_url, location, post_type, status, user_id, posted_at) " +
                      "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection()) {
            LOGGER.info("Database connection established for creating item");
            
            try (PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setString(1, item.getTitle());
                stmt.setString(2, item.getDescription());
                stmt.setInt(3, item.getCategoryId());
                stmt.setString(4, item.getImageUrl());
                stmt.setString(5, item.getLocation());
                stmt.setString(6, item.getPostType());
                stmt.setString(7, item.getStatus());
                stmt.setInt(8, item.getUserId());
                stmt.setTimestamp(9, item.getPostedAt());
                
                LOGGER.info("Executing SQL: " + query);
                LOGGER.info("Parameters: title=" + item.getTitle() + 
                          ", category_id=" + item.getCategoryId() + 
                          ", user_id=" + item.getUserId());
                
                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    try (ResultSet rs = stmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            item.setId(rs.getInt(1));
                            LOGGER.info("Item created successfully with ID: " + item.getId());
                            return true;
                        }
                    }
                }
                LOGGER.warning("No rows affected when creating item");
                return false;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating item in database", e);
            e.printStackTrace();
            return false;
        }
    }
    
    // Find item by ID
    public Item getItemById(int id) {
        String query = "SELECT * FROM items WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractItemFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Get all items
    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        String query = "SELECT * FROM items";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            
            while (rs.next()) {
                Item item = extractItemFromResultSet(rs);
                items.add(item);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return items;
    }
    
    // Get items by user ID
    public List<Item> getItemsByUserId(int userId) {
        String query = "SELECT * FROM items WHERE user_id = ? ORDER BY posted_at DESC";
        List<Item> items = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                items.add(extractItemFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return items;
    }
    
    // Get items by status
    public List<Item> getItemsByStatus(String status) {
        List<Item> items = new ArrayList<>();
        String query = "SELECT * FROM items WHERE status = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            LOGGER.info("Fetching items with status: " + status);
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Item item = extractItemFromResultSet(rs);
                items.add(item);
                LOGGER.info("Found item: " + item.getTitle() + " (ID: " + item.getId() + ")");
            }
            
            LOGGER.info("Total items found: " + items.size());
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching items by status", e);
            e.printStackTrace();
        }
        
        return items;
    }
    
    // Get items by post type (lost or found)
    public List<Item> getItemsByPostType(String postType) {
        List<Item> items = new ArrayList<>();
        String query = "SELECT * FROM items WHERE post_type = ? AND status = 'approved'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, postType);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Item item = extractItemFromResultSet(rs);
                items.add(item);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return items;
    }
    
    // Get items by category
    public List<Item> getItemsByCategory(int categoryId) {
        List<Item> items = new ArrayList<>();
        String query = "SELECT * FROM items WHERE category_id = ? AND status = 'approved'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Item item = extractItemFromResultSet(rs);
                items.add(item);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return items;
    }
    
    // Get items by post type and status
    public List<Item> getItemsByTypeAndStatus(String postType, String status) {
        List<Item> items = new ArrayList<>();
        String query = "SELECT * FROM items WHERE post_type = ? AND status = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            LOGGER.info("Fetching items with type: " + postType + " and status: " + status);
            stmt.setString(1, postType);
            stmt.setString(2, status);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Item item = extractItemFromResultSet(rs);
                items.add(item);
                LOGGER.info("Found item: " + item.getTitle() + " (ID: " + item.getId() + ")");
            }
            
            LOGGER.info("Total items found: " + items.size());
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching items by type and status", e);
            e.printStackTrace();
        }
        
        return items;
    }
    
    // Get items by type
    public List<Item> getItemsByType(String type) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE type = ? ORDER BY posted_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, type);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Item item = new Item();
                item.setId(rs.getInt("id"));
                item.setTitle(rs.getString("title"));
                item.setDescription(rs.getString("description"));
                item.setLocation(rs.getString("location"));
                item.setType(rs.getString("type"));
                item.setStatus(rs.getString("status"));
                item.setImageUrl(rs.getString("image_url"));
                item.setUserId(rs.getInt("user_id"));
                item.setPostedAt(rs.getTimestamp("posted_at"));
                item.setCategoryId(rs.getInt("category_id"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return items;
    }
    
    // Update item
    public boolean updateItem(Item item) {
        String query = "UPDATE items SET title = ?, description = ?, category_id = ?, image_url = ?, " +
                      "location = ?, post_type = ?, status = ?, rejection_reason = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, item.getTitle());
            stmt.setString(2, item.getDescription());
            stmt.setInt(3, item.getCategoryId());
            stmt.setString(4, item.getImageUrl());
            stmt.setString(5, item.getLocation());
            stmt.setString(6, item.getPostType());
            stmt.setString(7, item.getStatus());
            stmt.setString(8, item.getRejectionReason());
            stmt.setInt(9, item.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Approve or reject item
    public boolean updateItemStatus(int itemId, String status, String rejectionReason) {
        String query = "UPDATE items SET status = ?, rejection_reason = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, status);
            stmt.setString(2, rejectionReason);
            stmt.setInt(3, itemId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete item
    public boolean deleteItem(int id) {
        String query = "DELETE FROM items WHERE id = ?";
        
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

    // Delete all items from a specific user
    public boolean deleteItemsByUserId(int userId) {
        String query = "DELETE FROM items WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            return true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Helper method to extract item from ResultSet
    private Item extractItemFromResultSet(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setId(rs.getInt("id"));
        item.setTitle(rs.getString("title"));
        item.setDescription(rs.getString("description"));
        item.setCategoryId(rs.getInt("category_id"));
        item.setImageUrl(rs.getString("image_url"));
        item.setLocation(rs.getString("location"));
        item.setPostType(rs.getString("post_type"));
        item.setStatus(rs.getString("status"));
        item.setRejectionReason(rs.getString("rejection_reason"));
        item.setUserId(rs.getInt("user_id"));
        item.setPostedAt(rs.getTimestamp("posted_at"));
        return item;
    }
} 