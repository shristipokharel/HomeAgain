package com.example.homeagain.controller;

import com.example.homeagain.dao.CategoryDAO;
import com.example.homeagain.dao.ItemDAO;
import com.example.homeagain.model.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/report-found")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 5 * 1024 * 1024,   // 5 MB
        maxRequestSize = 10 * 1024 * 1024 // 10 MB
)
public class ReportFoundServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(ReportFoundServlet.class.getName());
    private ItemDAO itemDAO;
    private CategoryDAO categoryDAO;
    
    @Override
    public void init() throws ServletException {
        itemDAO = new ItemDAO();
        categoryDAO = new CategoryDAO();
        // Insert default categories if none exist
        categoryDAO.insertDefaultCategories();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Load categories for the dropdown
        request.setAttribute("categories", categoryDAO.getAllCategories());
        
        // Forward to report found page
        request.getRequestDispatcher("/WEB-INF/views/ReportFound.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("DEBUG: Entered doPost in ReportFoundServlet");
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get form data
        String itemName = request.getParameter("itemName");
        String category = request.getParameter("category");
        String dateFoundStr = request.getParameter("dateFound");
        String timeFoundStr = request.getParameter("timeFound");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String contactNumber = request.getParameter("contactNumber");

        LOGGER.info("Received found item report: " + itemName + " in category " + category);

        // Validate required fields
        if (itemName == null || itemName.trim().isEmpty() ||
                category == null || category.trim().isEmpty() ||
                dateFoundStr == null || dateFoundStr.trim().isEmpty() ||
                location == null || location.trim().isEmpty() ||
                description == null || description.trim().isEmpty() ||
                contactNumber == null || contactNumber.trim().isEmpty()) {

            LOGGER.warning("Missing required fields in found item report");
            request.setAttribute("error", "Please fill all required fields");
            request.getRequestDispatcher("/WEB-INF/views/ReportFound.jsp").forward(request, response);
            return;
        }

        try {
            // Handle file upload
            String imagePath = null;
            Part filePart = request.getPart("itemImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    // Create uploads directory if it doesn't exist
                    String uploadPath = getServletContext().getRealPath("/uploads");
                    Files.createDirectories(Paths.get(uploadPath));
                    
                    // Save the file
                    String fullPath = uploadPath + "/" + fileName;
                    filePart.write(fullPath);
                    imagePath = "uploads/" + fileName;
                }
            }

            // Create Item object
            Item item = new Item();
            item.setTitle(itemName);
            item.setDescription(description);
            item.setCategoryId(Integer.parseInt(category));
            item.setImageUrl(imagePath);
            item.setLocation(location);
            item.setPostType("found"); // Set type as found
            item.setStatus("pending"); // Initial status is pending
            item.setUserId((Integer) session.getAttribute("userId")); // Get user ID from session
            item.setPostedAt(new Timestamp(System.currentTimeMillis()));

            LOGGER.info("Creating found item with title: " + itemName + " for user: " + item.getUserId());

            // Save to database
            boolean success = itemDAO.createItem(item);

            if (success) {
                LOGGER.info("Found item created successfully with ID: " + item.getId());
                request.setAttribute("message", "Your found item has been reported successfully!");
                response.sendRedirect(request.getContextPath() + "/found");
            } else {
                LOGGER.warning("Failed to create found item");
                request.setAttribute("error", "Failed to save the found item report. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/ReportFound.jsp").forward(request, response);
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing found item report", e);
            request.setAttribute("error", "Error processing your request: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/ReportFound.jsp").forward(request, response);
        }
    }

    // Helper method to extract file name from HTTP header content-disposition
    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        for (String content : partHeader.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
