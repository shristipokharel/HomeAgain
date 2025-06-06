<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Items - HomeAgain Admin</title>
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
        body {
            background-color: var(--background-color);
            color: var(--text-color);
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
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
        .sidebar-header h2 {
            color: var(--primary-color);
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }
        .sidebar-header p {
            color: var(--text-light);
            font-size: 0.875rem;
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
        .sidebar-link i {
            margin-right: 0.75rem;
            width: 20px;
            text-align: center;
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
            margin-left: 350px;
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
        .items-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }
        .items-table th, .items-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            text-align: left;
        }
        .items-table th {
            background: var(--background-color);
            color: var(--text-light);
            font-size: 0.95rem;
            font-weight: 600;
        }
        .items-table tr:last-child td {
            border-bottom: none;
        }
        .status-approved {
            color: #22c55e;
            font-weight: 600;
        }
        .status-pending {
            color: #eab308;
            font-weight: 600;
        }
        .status-rejected {
            color: #ef4444;
            font-weight: 600;
        }
        .empty-state {
            text-align: center;
            padding: 3rem;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            margin-top: 2rem;
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
        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }
        .btn-edit {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            cursor: pointer;
            font-size: 0.875rem;
            transition: background-color 0.2s;
        }
        .btn-edit:hover {
            background-color: var(--primary-dark);
        }
        .btn-delete {
            background-color: #ef4444;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            cursor: pointer;
            font-size: 0.875rem;
            transition: background-color 0.2s;
        }
        .btn-delete:hover {
            background-color: #dc2626;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: var(--white);
            padding: 2rem;
            border-radius: var(--radius);
            max-width: 400px;
            width: 90%;
        }
        .modal-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        .modal-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 1.5rem;
            justify-content: flex-end;
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
            <a href="${pageContext.request.contextPath}/admin/items" class="sidebar-link${pageContext.request.servletPath == '/admin/items' ? ' active' : ''}"><span>Pending Items</span></a>
            <a href="${pageContext.request.contextPath}/admin/all-items" class="sidebar-link${pageContext.request.servletPath == '/admin/all-items' ? ' active' : ''}"><span>All Items</span></a>
            <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link${pageContext.request.servletPath == '/admin/users' ? ' active' : ''}"><span>Manage Users</span></a>
            <a href="${pageContext.request.contextPath}/admin/contacts" class="sidebar-link${pageContext.request.servletPath == '/admin/contacts' ? ' active' : ''}"><span>Contact Messages</span></a>
        </div>
        <div class="content-area">
            <div class="page-header">
                <h1 class="page-title">All Items</h1>
            </div>
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            <c:if test="${empty allItems}">
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <h3>No Items</h3>
                    <p>There are no items to display at the moment.</p>
                </div>
            </c:if>
            <c:if test="${not empty allItems}">
                <table class="items-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>User ID</th>
                            <th>Category</th>
                            <th>Location</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${allItems}" var="item">
                            <tr>
                                <td>${item.id}</td>
                                <td>${item.title}</td>
                                <td>${item.postType}</td>
                                <td class="status-${item.status}">${item.status}</td>
                                <td>${item.userId}</td>
                                <td>${item.categoryId}</td>
                                <td>${item.location}</td>
                                <td>${item.postedAt}</td>
                                <td>
                                    <div class="action-buttons">
                                        <button onclick="location.href='${pageContext.request.contextPath}/admin/edit-item?id=${item.id}'" class="btn-edit">Edit</button>
                                        <button onclick="showDeleteConfirmation(${item.id}, '${item.title}')" class="btn-delete">Delete</button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h2 class="modal-title">Delete Item</h2>
            <p>Are you sure you want to delete "<span id="deleteItemTitle"></span>"?</p>
            <p>This action cannot be undone.</p>
            <div class="modal-buttons">
                <button onclick="hideDeleteConfirmation()" class="btn-edit">Cancel</button>
                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/delete-item" method="POST" style="display: inline;">
                    <input type="hidden" id="deleteItemId" name="id" value="">
                    <button type="submit" class="btn-delete">Delete</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function showDeleteConfirmation(itemId, itemTitle) {
            document.getElementById('deleteModal').style.display = 'flex';
            document.getElementById('deleteItemId').value = itemId;
            document.getElementById('deleteItemTitle').textContent = itemTitle;
        }

        function hideDeleteConfirmation() {
            document.getElementById('deleteModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            var modal = document.getElementById('deleteModal');
            if (event.target == modal) {
                hideDeleteConfirmation();
            }
        }
    </script>
</body>
</html> 