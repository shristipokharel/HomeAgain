<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.homeagain.model.Item" %>
<%
    Item item = (Item) request.getAttribute("item");
    if (item == null) {
        response.sendRedirect(request.getContextPath() + "/profile");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Edit Item - Home Again</title>
    <style>
        /* Copy all root variables and basic styles from profile.jsp */
        :root {
            --primary-color: #4f46e5;
            --primary-dark: #4338ca;
            --primary-light: #818cf8;
            --secondary-color: #475569;
            --text-color: #1e293b;
            --text-light: #64748b;
            --background-color: #f8fafc;
            --white: #ffffff;
            --border-color: #e2e8f0;
            --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --radius-sm: 0.375rem;
            --radius: 0.5rem;
            --radius-lg: 0.75rem;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', system-ui, -apple-system, sans-serif; }
        body { min-height: 100vh; display: flex; flex-direction: column; background-color: var(--background-color); color: var(--text-color); line-height: 1.6; }

        .edit-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: var(--white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow);
        }

        .edit-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 2rem;
            text-align: center;
            color: var(--text-color);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--text-color);
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-color);
        }

        .form-group textarea {
            min-height: 150px;
            resize: vertical;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
        }

        .save-btn,
        .cancel-btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--radius);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .save-btn {
            background-color: var(--primary-color);
            color: white;
        }

        .save-btn:hover {
            background-color: var(--primary-dark);
        }

        .cancel-btn {
            background-color: var(--text-light);
            color: white;
        }

        .cancel-btn:hover {
            background-color: var(--secondary-color);
        }

        .error-message {
            background-color: #fee2e2;
            color: #dc2626;
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
            display: none;
        }

        .readonly-field {
            background-color: var(--background-color);
            padding: 0.75rem;
            border-radius: var(--radius);
            color: var(--text-light);
            font-size: 0.9rem;
            word-break: break-all;
        }

        @media (max-width: 768px) {
            .edit-container {
                margin: 1rem;
                padding: 1.5rem;
            }

            .button-group {
                flex-direction: column;
            }

            .button-group button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="edit-container">
        <h1 class="edit-title">Edit Item</h1>
        
        <div id="errorMessage" class="error-message" style="display: <%= request.getParameter("error") != null ? "block" : "none" %>">
            Failed to update the item. Please try again.
        </div>

        <form action="<%=request.getContextPath()%>/edit-item" method="POST">
            <input type="hidden" name="id" value="<%=item.getId()%>">
            
            <div class="form-group">
                <label for="title">Title</label>
                <input type="text" id="title" name="title" value="<%=item.getTitle()%>" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" required><%=item.getDescription()%></textarea>
            </div>

            <div class="form-group">
                <label for="location">Location</label>
                <input type="text" id="location" name="location" value="<%=item.getLocation()%>" required>
            </div>

            <% if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) { %>
            <div class="form-group">
                <label>Image URL</label>
                <div class="readonly-field"><%=item.getImageUrl()%></div>
            </div>
            <% } %>

            <div class="button-group">
                <button type="button" class="cancel-btn" onclick="location.href='<%=request.getContextPath()%>/profile'">Cancel</button>
                <button type="submit" class="save-btn">Save Changes</button>
            </div>
        </form>
    </div>
</body>
</html> 