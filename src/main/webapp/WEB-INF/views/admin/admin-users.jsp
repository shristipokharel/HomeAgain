<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - HomeAgain Admin</title>
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
        .content-area {
            flex: 1;
            padding: 2rem;
            margin-left: 350px;
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
        .sidebar-link i {
            margin-right: 0.75rem;
            width: 20px;
            text-align: center;
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
        .users-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }
        .users-table th, .users-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            text-align: left;
        }
        .users-table th {
            background: var(--background-color);
            color: var(--text-light);
            font-size: 0.95rem;
            font-weight: 600;
        }
        .users-table tr:last-child td {
            border-bottom: none;
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
        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: var(--radius);
            font-size: 0.875rem;
            font-weight: 500;
        }
        .status-active {
            background-color: #dcfce7;
            color: #16a34a;
        }
        .status-inactive {
            background-color: #fee2e2;
            color: #dc2626;
        }
        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }
        .btn-toggle {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            cursor: pointer;
            font-size: 0.875rem;
            transition: background-color 0.2s;
        }
        .btn-toggle:hover {
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
        .success-message {
            background-color: #dcfce7;
            color: #16a34a;
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
        }
        .error-message {
            background-color: #fee2e2;
            color: #dc2626;
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
            <a href="${pageContext.request.contextPath}/admin/items" class="sidebar-link${pageContext.request.servletPath == '/admin/items' ? ' active' : ''}">Pending Items</a>
            <a href="${pageContext.request.contextPath}/admin/all-items" class="sidebar-link${pageContext.request.servletPath == '/admin/all-items' ? ' active' : ''}">All Items</a>
            <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link${pageContext.request.servletPath == '/admin/users' ? ' active' : ''}">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/contacts" class="sidebar-link${pageContext.request.servletPath == '/admin/contacts' ? ' active' : ''}">Contact Messages</a>
        </div>
        <div class="content-area">
            <div class="page-header">
                <h1 class="page-title">Manage Users</h1>
            </div>
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            <c:if test="${param.success eq 'true'}">
                <div class="success-message">
                    ${not empty param.message ? param.message : 'Operation completed successfully'}
                </div>
            </c:if>
            <c:if test="${param.error eq 'true'}">
                <div class="error-message">
                    ${not empty param.message ? param.message : 'Operation failed. Please try again.'}
                </div>
            </c:if>
            <c:if test="${param.deleteSuccess eq 'true'}">
                <div class="success-message">User deleted successfully</div>
            </c:if>
            <c:if test="${param.deleteError eq 'true'}">
                <div class="error-message">Failed to delete user. Please try again.</div>
            </c:if>
            <c:if test="${empty allUsers}">
                <div class="empty-state">
                    <i class="fas fa-users"></i>
                    <h3>No Users</h3>
                    <p>There are no users to display at the moment.</p>
                </div>
            </c:if>
            <c:if test="${not empty allUsers}">
                <table class="users-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Full Name</th>
                            <th>Phone Number</th>
                            <th>Status</th>
                            <th>Created At</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${allUsers}" var="user">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.username}</td>
                                <td>${user.email}</td>
                                <td>${user.fullName}</td>
                                <td>${user.phoneNumber}</td>
                                <td>
                                    <span class="status-badge ${user.active ? 'status-active' : 'status-inactive'}">
                                        ${user.active ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td>${user.createdAt}</td>
                                <td>
                                    <div class="action-buttons">
                                        <form action="${pageContext.request.contextPath}/admin/toggle-user-status" method="post" style="display: inline;">
                                            <input type="hidden" name="userId" value="${user.id}">
                                            <input type="hidden" name="active" value="${!user.active}">
                                            <button type="submit" class="btn-toggle">
                                                ${user.active ? 'Deactivate' : 'Activate'}
                                            </button>
                                        </form>
                                        <button onclick="showDeleteConfirmation('${user.id}', '${user.username}')" class="btn-delete">Delete</button>
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
            <h2 class="modal-title">Delete User</h2>
            <p>Are you sure you want to delete user "<span id="deleteUserName"></span>"?</p>
            <p>This action cannot be undone. All items posted by this user will also be deleted.</p>
            <div class="modal-buttons">
                <button onclick="hideDeleteConfirmation()" class="btn-toggle">Cancel</button>
                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/delete-user" method="POST" style="display: inline;">
                    <input type="hidden" id="deleteUserId" name="id" value="">
                    <button type="submit" class="btn-delete">Delete</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function showDeleteConfirmation(userId, username) {
            document.getElementById('deleteModal').style.display = 'flex';
            document.getElementById('deleteUserId').value = userId;
            document.getElementById('deleteUserName').textContent = username;
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