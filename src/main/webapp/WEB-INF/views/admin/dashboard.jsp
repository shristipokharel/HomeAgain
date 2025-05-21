<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - HomeAgain</title>
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
            --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
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
            width: 250px;
            background: var(--white);
            padding: 2rem;
            box-shadow: var(--shadow);
        }

        .sidebar-header {
            margin-bottom: 2rem;
        }

        .sidebar-link {
            display: block;
            padding: 0.75rem 1rem;
            color: var(--text-color);
            text-decoration: none;
            border-radius: var(--radius);
            margin-bottom: 0.5rem;
        }

        .sidebar-link:hover, .sidebar-link.active {
            background: var(--primary-light);
            color: var(--white);
        }

        .content-area {
            flex: 1;
            padding: 2rem;
        }

        .welcome-box {
            background: var(--white);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            margin-bottom: 2rem;
        }

        .badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .badge-success { background: #dcfce7; color: #166534; }
        .badge-warning { background: #fef3c7; color: #92400e; }
        .badge-info { background: #dbeafe; color: #1e40af; }

        .pending-items {
            background: var(--white);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .item-card {
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .item-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: var(--radius);
        }

        .item-details {
            flex: 1;
            margin-left: 1rem;
        }

        .item-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .btn {
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.2s;
        }

        .btn-approve {
            background: #22c55e;
            color: white;
        }

        .btn-reject {
            background: #ef4444;
            color: white;
        }

        .rejection-form {
            margin-top: 1rem;
            display: none;
        }

        .rejection-form.active {
            display: block;
        }

        .error-message {
            background: #fee2e2;
            color: #991b1b;
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
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

        /* Stats Overview Styles */
        .stats-overview {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
            /* Temporary border for debugging */
            border: 5px solid red;
        }

        .stat-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow-sm);
            text-align: center;
        }

        .stat-card .icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            color: var(--primary-color);
        }

        .stat-card h3 {
            font-size: 1.1rem;
            color: var(--text-color);
            margin-bottom: 0.25rem;
        }

        .stat-card .number {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-dark);
        }

        /* Recent Activity Styles */
        .recent-activity {
            background: var(--white);
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            margin-bottom: 2rem;
        }
        .recent-activity h2 {
            color: var(--text-color);
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 1rem;
        }
        .activity-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .activity-item {
            display: flex;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px dashed var(--border-color);
        }
        .activity-item:last-child {
            border-bottom: none;
        }
        .activity-icon {
            font-size: 1.2rem;
            margin-right: 1rem;
            color: var(--primary-color);
        }
        .activity-item p {
            flex-grow: 1;
            margin: 0;
            color: var(--text-color);
        }
        .activity-time {
            font-size: 0.8rem;
            color: var(--text-light);
        }

        /* Custom Confirmation Box Styles */
        .confirmation-overlay {
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

        .confirmation-box {
            background-color: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 90%;
            text-align: center;
            animation: slideIn 0.3s ease-out;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .confirmation-box h3 {
            color: var(--primary-color);
            margin-bottom: 1rem;
            font-size: 1.5rem;
        }

        .confirmation-box p {
            color: var(--text-color);
            margin-bottom: 1.5rem;
        }

        .confirmation-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .confirmation-button {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--radius);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .confirm-button {
            background-color: var(--primary-color);
            color: white;
        }

        .confirm-button:hover {
            background-color: var(--primary-dark);
        }

        .cancel-button {
            background-color: #e5e7eb;
            color: var(--text-color);
        }

        .cancel-button:hover {
            background-color: #d1d5db;
        }
    </style>
</head>
<body>
    <!-- Check if admin is logged in -->
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
            <a href="#" class="admin-logout" onclick="showSignOutConfirmation(); return false;">Logout</a>
        </div>
    </header>

    <!-- Custom Confirmation Box -->
    <div class="confirmation-overlay" id="signOutConfirmation">
        <div class="confirmation-box">
            <h3>Sign Out</h3>
            <p>Are you sure you want to sign out?</p>
            <div class="confirmation-buttons">
                <button class="confirmation-button cancel-button" onclick="hideSignOutConfirmation()">Cancel</button>
                <button class="confirmation-button confirm-button" onclick="confirmSignOut()">Sign Out</button>
            </div>
        </div>
    </div>

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
            <div class="welcome-box">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h2>Admin Dashboard</h2>
                    <div>
                        <span class="badge badge-success">System Status: Online</span>
                    </div>
                </div>
                <p class="lead">Welcome to the HomeAgain Administration Panel. You have full access to manage the system.</p>
            </div>

            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>

            <!-- Stats Overview Section -->
            <div class="stats-overview">
                <div class="stat-card">
                    <div class="icon">📊</div>
                    <h3>Total Users</h3>
                    <p class="number">${totalUsers}</p>
                </div>
                <div class="stat-card">
                    <div class="icon">✅</div>
                    <h3>Active Users</h3>
                    <p class="number">${activeUsers}</p>
                </div>
                <div class="stat-card">
                    <div class="icon">❌</div>
                    <h3>Inactive Users</h3>
                    <p class="number">${inactiveUsers}</p>
                </div>
                <div class="stat-card">
                    <div class="icon">👍</div>
                    <h3>Items Approved</h3>
                    <p class="number">${approvedItems}</p>
                </div>
                <div class="stat-card">
                    <div class="icon">👎</div>
                    <h3>Items Rejected</h3>
                    <p class="number">${rejectedItems}</p>
                </div>
                <div class="stat-card">
                    <div class="icon">📧</div>
                    <h3>Contact Messages</h3>
                    <p class="number">${totalContacts}</p>
                </div>
            </div>

            <!-- Recent Activity Section -->
            <div class="recent-activity">
                <h2>Recent Activity</h2>
                <div class="activity-list">
                    <c:forEach items="${top7RecentActivities}" var="activity">
                        <div class="activity-item">
                            <c:choose>
                                <c:when test="${activity[1] eq 'item' and activity[2] eq 'approved'}">
                                    <span class="activity-icon">✅</span>
                                    <p>Item <strong>'${activity[3]}'</strong> approved.</p>
                                </c:when>
                                <c:when test="${activity[1] eq 'item' and activity[2] eq 'rejected'}">
                                     <span class="activity-icon">👎</span>
                                     <p>Item <strong>'${activity[3]}'</strong> rejected.</p>
                                </c:when>
                                <c:when test="${activity[1] eq 'user' and activity[2] eq 'registered'}">
                                     <span class="activity-icon">⭐</span>
                                     <p>New user <strong>'${activity[3]}'</strong> signed up.</p>
                                </c:when>
                                <c:when test="${activity[1] eq 'contact' and activity[2] eq 'received'}">
                                     <span class="activity-icon">✉️</span>
                                     <p>Contact message received from <strong>'${activity[3]}'</strong>.</p>
                                </c:when>
                                <c:otherwise>
                                    <span class="activity-icon">📋</span>
                                    <p>Unknown activity.</p>
                                </c:otherwise>
                            </c:choose>
                            <span class="activity-time">${activity[0]}</span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty top7RecentActivities}">
                        <p>No recent activity.</p>
                    </c:if>
                </div>
            </div>

            <div class="pending-items">
                <h2>Pending Items for Review</h2>
                <c:if test="${empty pendingItems}">
                    <p>No pending items to review.</p>
                </c:if>
                
                <c:forEach items="${pendingItems}" var="item">
                    <div class="item-card">
                        <div class="item-header">
                            <h4>${item.title}</h4>
                            <span class="badge badge-warning">Pending</span>
                        </div>
                        
                        <div style="display: flex;">
                            <c:if test="${not empty item.imageUrl}">
                                <img src="${pageContext.request.contextPath}${item.imageUrl}" 
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

                        <div id="rejection-form-${item.id}" class="rejection-form">
                            <form action="${pageContext.request.contextPath}/admin/items" method="post">
                                <input type="hidden" name="itemId" value="${item.id}">
                                <input type="hidden" name="action" value="reject">
                                <div style="margin-bottom: 1rem;">
                                    <label for="rejection-reason-${item.id}">Rejection Reason:</label>
                                    <textarea id="rejection-reason-${item.id}" 
                                              name="rejectionReason" 
                                              required 
                                              style="width: 100%; padding: 0.5rem; margin-top: 0.5rem; border: 1px solid var(--border-color); border-radius: var(--radius);"></textarea>
                                </div>
                                <button type="submit" class="btn btn-reject">Confirm Rejection</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <script>
        // Toggle dropdown menu
        document.getElementById('navbarDropdown').addEventListener('click', function(e) {
            e.preventDefault();
            document.getElementById('userDropdown').classList.toggle('show');
        });
        
        // Close dropdown when clicking outside
        window.addEventListener('click', function(e) {
            if (!e.target.matches('.dropdown-toggle')) {
                var dropdowns = document.getElementsByClassName('dropdown-menu');
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        });

        function showRejectionForm(itemId) {
            const form = document.getElementById(`rejection-form-${itemId}`);
            form.classList.toggle('active');
        }

        function showSignOutConfirmation() {
            document.getElementById('signOutConfirmation').style.display = 'flex';
        }

        function hideSignOutConfirmation() {
            document.getElementById('signOutConfirmation').style.display = 'none';
        }

        function confirmSignOut() {
            window.location.href = '<%=request.getContextPath()%>/logout';
        }
    </script>
</body>
</html> 