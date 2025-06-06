<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Item - HomeAgain Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
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
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --radius: 0.5rem;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }
        body {
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
        }
        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }
        .sidebar {
            width: 280px;
            background: var(--white);
            padding: 2rem;
            box-shadow: var(--shadow);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }
        .sidebar-header {
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border-color);
        }
        .sidebar-link {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            color: var(--text-color);
            text-decoration: none;
            border-radius: var(--radius);
            margin-bottom: 0.5rem;
            transition: all 0.2s;
        }
        .sidebar-link:hover {
            background: var(--primary-light);
            color: var(--white);
        }
        .sidebar-link.active {
            background: var(--primary-color);
            color: var(--white);
        }
        .content-area {
            flex: 1;
            padding: 2rem;
            margin-left: 280px;
        }
        .edit-form {
            background: var(--white);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            max-width: 800px;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--text-color);
            font-weight: 500;
        }
        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            font-size: 1rem;
            transition: border-color 0.2s;
        }
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
        }
        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--radius);
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        .btn-primary:hover {
            background-color: var(--primary-dark);
        }
        .btn-secondary {
            background-color: var(--text-light);
            color: white;
        }
        .btn-secondary:hover {
            background-color: var(--secondary-color);
        }
        .error-message {
            background-color: #fee2e2;
            color: #dc2626;
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
        }
        .success-message {
            background-color: #dcfce7;
            color: #16a34a;
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <% 
    if (session.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    %>
    <div class="dashboard-container">
        <div class="sidebar">
            <div class="sidebar-header">
                <h4>Admin Menu</h4>
            </div>
            <a href="${pageContext.request.contextPath}/admin/items" class="sidebar-link">Pending Items</a>
            <a href="${pageContext.request.contextPath}/admin/all-items" class="sidebar-link active">All Items</a>
            <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/contacts" class="sidebar-link">Contact Messages</a>
        </div>
        <div class="content-area">
            <div class="edit-form">
                <h2 style="margin-bottom: 1.5rem;">Edit Item</h2>
                
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/edit-item" method="post">
                    <input type="hidden" name="id" value="${item.id}">
                    
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" id="title" name="title" class="form-control" value="${item.title}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" class="form-control" rows="4" required>${item.description}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="location">Location</label>
                        <input type="text" id="location" name="location" class="form-control" value="${item.location}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status" class="form-control" required>
                            <option value="pending" ${item.status == 'pending' ? 'selected' : ''}>Pending</option>
                            <option value="approved" ${item.status == 'approved' ? 'selected' : ''}>Approved</option>
                            <option value="rejected" ${item.status == 'rejected' ? 'selected' : ''}>Rejected</option>
                        </select>
                    </div>
                    
                    <div style="display: flex; gap: 1rem; justify-content: flex-end;">
                        <a href="${pageContext.request.contextPath}/admin/all-items" class="btn btn-secondary">Cancel</a>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html> 