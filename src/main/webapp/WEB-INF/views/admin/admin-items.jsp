<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Items - HomeAgain Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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

        .admin-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: var(--white);
            padding: 1rem 2rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            border-bottom: 1px solid var(--border-color);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .admin-logo {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
        }

        .admin-badge {
            background: var(--primary-color);
            color: #fff;
            font-size: 0.8rem;
            padding: 0.2rem 0.6rem;
            border-radius: 0.5rem;
            margin-left: 0.5rem;
            font-weight: 500;
        }

        .admin-header-right {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .admin-user {
            color: var(--text-color);
            font-size: 1rem;
        }

        .admin-logout {
            color: #fff;
            background: var(--primary-color);
            padding: 0.5rem 1rem;
            border-radius: 0.4rem;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.2s;
        }

        .admin-logout:hover {
            background: var(--primary-dark);
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

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.875rem;
            font-weight: 600;
            color: var(--text-color);
        }

        .item-card {
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .item-header h4 {
            color: var(--text-color);
            font-size: 1.1rem;
            font-weight: 600;
        }

        .badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .badge-warning {
            background-color: #fef3c7;
            color: #92400e;
        }

        .item-image {
            width: 200px;
            height: 200px;
            object-fit: cover;
            border-radius: var(--radius);
            margin-right: 1.5rem;
        }

        .item-details {
            flex: 1;
        }

        .item-details p {
            margin-bottom: 0.5rem;
            color: var(--text-color);
        }

        .item-details strong {
            color: var(--secondary-color);
        }

        .item-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--border-color);
        }

        .btn {
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
        }

        .btn-approve {
            background-color: #22c55e;
            color: white;
        }

        .btn-approve:hover {
            background-color: #16a34a;
        }

        .btn-reject {
            background-color: #ef4444;
            color: white;
        }

        .btn-reject:hover {
            background-color: #dc2626;
        }

        .rejection-form {
            display: none;
            margin-top: 1rem;
            padding: 1rem;
            background-color: var(--background-color);
            border-radius: var(--radius);
        }

        .rejection-form textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            margin-bottom: 1rem;
            resize: vertical;
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

        .empty-state {
            text-align: center;
            padding: 3rem;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .empty-state i {
            font-size: 3rem;
            color: var(--text-light);
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: var(--text-light);
        }
    </style>
</head>
<body>
    <% 
    if (session.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String adminUsername = (String) session.getAttribute("adminUsername");
    if (adminUsername == null) adminUsername = "Unknown";
    %>

    <header class="admin-header">
        <div class="admin-header-left">
            <a href="${pageContext.request.contextPath}/admin/items" class="admin-logo">HomeAgain <span class="admin-badge">ADMIN</span></a>
        </div>
        <div class="admin-header-right">
            <span class="admin-user">Admin: <strong><%= adminUsername %></strong></span>
            <a href="${pageContext.request.contextPath}/logout" class="admin-logout">Logout</a>
        </div>
    </header>

    <div class="dashboard-container">
        <div class="sidebar">
            <div class="sidebar-header">
                <h4>Admin Menu</h4>
            </div>
            <a href="${pageContext.request.contextPath}/admin/items" class="sidebar-link active">Pending Items</a>
            <a href="${pageContext.request.contextPath}/admin/all-items" class="sidebar-link">All Items</a>
            <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/contacts" class="sidebar-link">Contact Messages</a>
        </div>

        <div class="content-area">
            <div class="page-header">
                <h1 class="page-title">Pending Items</h1>
            </div>

            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="success-message">Operation completed successfully!</div>
            </c:if>

            <c:if test="${empty pendingItems}">
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <h3>No Pending Items</h3>
                    <p>There are no items waiting for approval at the moment.</p>
                </div>
            </c:if>

            <c:forEach items="${pendingItems}" var="item">
                <div class="item-card">
                    <div class="item-header">
                        <h4>${item.title}</h4>
                        <span class="badge badge-warning">Pending</span>
                    </div>
                    
                    <div style="display: flex;">
                        <c:if test="${not empty item.imageUrl}">
                            <img src="${pageContext.request.contextPath}/${item.imageUrl}" 
                                 alt="${item.title}" 
                                 class="item-image">
                        </c:if>
                        
                        <div class="item-details">
                            <p><strong>Location:</strong> ${item.location}</p>
                            <p><strong>Posted by:</strong> User ID ${item.userId}</p>
                            <p><strong>Posted at:</strong> ${item.postedAt}</p>
                            <p><strong>Description:</strong> ${item.description}</p>
                        </div>
                    </div>

                    <div class="item-actions">
                        <form action="${pageContext.request.contextPath}/admin/items" method="post" style="display: inline;">
                            <input type="hidden" name="itemId" value="${item.id}">
                            <input type="hidden" name="action" value="approve">
                            <button type="submit" class="btn btn-approve">Approve</button>
                        </form>
                        
                        <button onclick="showRejectionForm('${item.id}')" class="btn btn-reject">Reject</button>
                    </div>

                    <div id="rejectionForm-${item.id}" class="rejection-form">
                        <form action="${pageContext.request.contextPath}/admin/items" method="post">
                            <input type="hidden" name="itemId" value="${item.id}">
                            <input type="hidden" name="action" value="reject">
                            <textarea name="rejectionReason" placeholder="Enter reason for rejection..." required></textarea>
                            <div class="item-actions">
                                <button type="button" onclick="hideRejectionForm('${item.id}')" class="btn btn-secondary">Cancel</button>
                                <button type="submit" class="btn btn-reject">Confirm Rejection</button>
                            </div>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        function showRejectionForm(itemId) {
            document.getElementById('rejectionForm-' + itemId).style.display = 'block';
        }

        function hideRejectionForm(itemId) {
            document.getElementById('rejectionForm-' + itemId).style.display = 'none';
        }
    </script>
</body>
</html> 