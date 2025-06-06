package com.example.homeagain.dao;

import com.example.homeagain.model.Category;
import com.example.homeagain.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class CategoryDAO {
    private static final Logger LOGGER = Logger.getLogger(CategoryDAO.class.getName());
    
    // Create a new category
    public boolean createCategory(Category category) {
        String query = "INSERT INTO categories (name, description) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    category.setId(rs.getInt(1));
                    return true;
                }
            }
            return false;
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error creating category", e);
            return false;
        }
    }
    
    // Find category by ID
    public Category getCategoryById(int id) {
        String query = "SELECT * FROM categories WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractCategoryFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting category by ID: " + id, e);
        }
        
        return null;
    }
    
    // Find category by name
    public Category getCategoryByName(String name) {
        String query = "SELECT * FROM categories WHERE name = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return extractCategoryFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    // Get all categories
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT * FROM categories ORDER BY name";
        
        try (Connection conn = DBConnection.getConnection()) {
            LOGGER.info("Fetching all categories from database");
            
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(query)) {
                
                while (rs.next()) {
                    Category category = extractCategoryFromResultSet(rs);
                    categories.add(category);
                    LOGGER.info("Found category: ID=" + category.getId() + ", Name=" + category.getName());
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error fetching categories", e);
        }
        
        return categories;
    }
    
    // Insert default categories if none exist
    public void insertDefaultCategories() {
        List<Category> defaultCategories = new ArrayList<>();
        defaultCategories.add(new Category("Electronics", "Mobile phones, laptops, tablets, etc."));
        defaultCategories.add(new Category("Documents", "ID cards, passports, certificates, etc."));
        defaultCategories.add(new Category("Jewelry", "Rings, necklaces, watches, etc."));
        defaultCategories.add(new Category("Clothing", "Clothes, shoes, bags, etc."));
        defaultCategories.add(new Category("Others", "Miscellaneous items"));

        try (Connection conn = DBConnection.getConnection()) {
            // Check if categories table is empty
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM categories")) {
                
                rs.next();
                if (rs.getInt(1) == 0) {
                    LOGGER.info("No categories found. Inserting default categories...");
                    
                    String query = "INSERT INTO categories (name, description) VALUES (?, ?)";
                    try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                        for (Category category : defaultCategories) {
                            pstmt.setString(1, category.getName());
                            pstmt.setString(2, category.getDescription());
                            pstmt.executeUpdate();
                            LOGGER.info("Inserted category: " + category.getName());
                        }
                    }
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting default categories", e);
        }
    }
    
    // Update category
    public boolean updateCategory(Category category) {
        String query = "UPDATE categories SET name = ?, description = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, category.getName());
            stmt.setString(2, category.getDescription());
            stmt.setInt(3, category.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete category
    public boolean deleteCategory(int id) {
        String query = "DELETE FROM categories WHERE id = ?";
        
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
    
    // Helper method to extract category from ResultSet
    private Category extractCategoryFromResultSet(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String name = rs.getString("name");
        String description = rs.getString("description");
        return new Category(id, name, description);
    }
} 