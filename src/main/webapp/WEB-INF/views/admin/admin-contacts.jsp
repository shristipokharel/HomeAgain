<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Messages - HomeAgain Admin</title>
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

        .contacts-table {
            width: 100%;
            border-collapse: collapse;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .contacts-table th,
        .contacts-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        .contacts-table th {
            background: var(--background-color);
            font-weight: 600;
            color: var(--text-light);
        }

        .contacts-table tr:last-child td {
            border-bottom: none;
        }

        .message-cell {
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .date-cell {
            white-space: nowrap;
        }

        .action-cell {
            text-align: right;
        }

        .btn-view {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            cursor: pointer;
            font-size: 0.875rem;
            margin-right: 0.5rem;
        }

        .btn-delete {
            background: #ef4444;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            cursor: pointer;
            font-size: 0.875rem;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-content {
            background: var(--white);
            padding: 2rem;
            border-radius: var(--radius);
            max-width: 600px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .modal-title {
            font-size: 1.25rem;
            font-weight: 600;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--text-light);
        }

        .modal-body {
            margin-bottom: 1.5rem;
        }

        .modal-field {
            margin-bottom: 1rem;
        }

        .modal-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            display: block;
        }

        .modal-value {
            color: var(--text-color);
        }

        .success-message {
            background: #dcfce7;
            color: #16a34a;
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
        }

        .error-message {
            background: #fee2e2;
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
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/items" class="sidebar-link">Pending Items</a>
            <a href="${pageContext.request.contextPath}/admin/all-items" class="sidebar-link">All Items</a>
            <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link">Manage Users</a>
            <a href="${pageContext.request.contextPath}/admin/contacts" class="sidebar-link active">Contact Messages</a>
        </div>

        <div class="content-area">
            <div class="page-header">
                <h1 class="page-title">Contact Messages</h1>
            </div>

            <c:if test="${param.deleted eq 'true'}">
                <div class="success-message">Message deleted successfully</div>
            </c:if>

            <c:if test="${empty contacts}">
                <div class="empty-state">
                    <p>No contact messages to display.</p>
                </div>
            </c:if>

            <c:if test="${not empty contacts}">
                <table class="contacts-table">
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Subject</th>
                            <th>Message</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${contacts}" var="contact">
                            <tr>
                                <td class="date-cell">${contact.createdAt}</td>
                                <td>${contact.name}</td>
                                <td>${contact.email}</td>
                                <td>${contact.subject}</td>
                                <td class="message-cell">${contact.message}</td>
                                <td class="action-cell">
                                    <button onclick="viewMessage(${contact.id})" class="btn-view">View</button>
                                    <button onclick="deleteMessage(${contact.id})" class="btn-delete">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>

    <!-- View Message Modal -->
    <div id="viewModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Message Details</h2>
                <button onclick="closeViewModal()" class="modal-close">&times;</button>
            </div>
            <div class="modal-body">
                <div class="modal-field">
                    <span class="modal-label">Date:</span>
                    <span id="modalDate" class="modal-value"></span>
                </div>
                <div class="modal-field">
                    <span class="modal-label">Name:</span>
                    <span id="modalName" class="modal-value"></span>
                </div>
                <div class="modal-field">
                    <span class="modal-label">Email:</span>
                    <span id="modalEmail" class="modal-value"></span>
                </div>
                <div class="modal-field">
                    <span class="modal-label">Subject:</span>
                    <span id="modalSubject" class="modal-value"></span>
                </div>
                <div class="modal-field">
                    <span class="modal-label">Message:</span>
                    <p id="modalMessage" class="modal-value"></p>
                </div>
            </div>
        </div>
    </div>

    <script>
        function viewMessage(id) {
            // In a real implementation, you would fetch the message details from the server
            // For now, we'll just show the modal with the data from the table
            const row = event.target.closest('tr');
            const cells = row.cells;
            
            document.getElementById('modalDate').textContent = cells[0].textContent;
            document.getElementById('modalName').textContent = cells[1].textContent;
            document.getElementById('modalEmail').textContent = cells[2].textContent;
            document.getElementById('modalSubject').textContent = cells[3].textContent;
            document.getElementById('modalMessage').textContent = cells[4].textContent;
            
            document.getElementById('viewModal').style.display = 'flex';
        }

        function closeViewModal() {
            document.getElementById('viewModal').style.display = 'none';
        }

        function deleteMessage(id) {
            if (confirm('Are you sure you want to delete this message?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/admin/contacts';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                
                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = id;
                
                form.appendChild(actionInput);
                form.appendChild(idInput);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('viewModal');
            if (event.target == modal) {
                closeViewModal();
            }
        }
    </script>
</body>
</html> 