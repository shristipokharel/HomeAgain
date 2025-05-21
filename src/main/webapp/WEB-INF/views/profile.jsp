<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.homeagain.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.homeagain.model.Item" %>
<%
    User user = (User) request.getAttribute("user");
    List<Item> userItems = (List<Item>) request.getAttribute("userItems");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Profile - Home Again</title>
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
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background-color: var(--white);
            border-bottom: 1px solid var(--border-color);
            box-shadow: var(--shadow);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo-container {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .logo {
            width: 80px;
            height: auto;
            transition: transform 0.3s ease;
        }

        .logo:hover {
            transform: scale(1.05);
        }

        nav {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        nav a {
            text-decoration: none;
            color: var(--secondary-color);
            font-weight: 500;
            padding: 0.5rem 0;
            position: relative;
            transition: all 0.3s ease;
        }

        nav a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary-color);
            transition: width 0.3s ease;
        }

        nav a:hover {
            color: var(--primary-color);
        }

        nav a:hover::after {
            width: 100%;
        }

        .user-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .profile-icon-button {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 50%;
            transition: all 0.3s ease;
        }

        .profile-icon-button:hover {
            background-color: var(--background-color);
        }

        .profile-icon {
            font-size: 1.5rem;
            background: var(--primary-light);
            color: var(--primary-color);
            padding: 0.5rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
        }

        .sign-out-button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: var(--radius);
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .sign-out-button:hover {
            background-color: var(--primary-dark);
        }

        main {
            flex: 1;
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        .profile-header {
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 2rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 2rem;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            background: var(--primary-light);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: var(--primary-color);
        }

        .profile-info {
            flex: 1;
        }

        .profile-name {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .profile-stats {
            display: flex;
            gap: 2rem;
            margin-top: 1rem;
        }

        .stat-item {
            text-align: center;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary-color);
        }

        .stat-label {
            font-size: 0.9rem;
            color: var(--text-light);
        }

        .profile-section {
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .section-title i {
            color: var(--primary-color);
        }

        .profile-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .detail-item {
            padding: 1rem;
            background: var(--background-color);
            border-radius: var(--radius);
        }

        .detail-label {
            font-size: 0.9rem;
            color: var(--text-light);
            margin-bottom: 0.25rem;
        }

        .detail-value {
            font-size: 1.1rem;
            color: var(--text-color);
            font-weight: 500;
        }

        .items-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .item-card {
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .item-card:hover {
            transform: translateY(-5px);
        }

        .item-image {
            width: 100%;
            height: 200px;
            background: var(--background-color);
            position: relative;
            overflow: hidden;
        }

        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .item-card:hover .item-image img {
            transform: scale(1.05);
        }

        .no-image {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-light);
            font-size: 1.2rem;
            background: var(--background-color);
        }

        .item-details {
            padding: 1.5rem;
        }

        .item-details h3 {
            font-size: 1.2rem;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .item-meta {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
            flex-wrap: wrap;
        }

        .item-type, .item-status {
            padding: 0.25rem 0.75rem;
            border-radius: var(--radius);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .item-type.lost {
            background-color: #fee2e2;
            color: #dc2626;
        }

        .item-type.found {
            background-color: #dcfce7;
            color: #16a34a;
        }

        .item-status.pending {
            background-color: #fef3c7;
            color: #d97706;
        }

        .item-status.approved {
            background-color: #dcfce7;
            color: #16a34a;
        }

        .item-status.rejected {
            background-color: #fee2e2;
            color: #dc2626;
        }

        .item-location {
            color: var(--text-light);
            margin: 0.5rem 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .item-description {
            color: var(--text-color);
            margin: 0.5rem 0;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .item-date {
            color: var(--text-light);
            font-size: 0.9rem;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .item-actions {
            margin-top: 1rem;
            display: flex;
            gap: 0.5rem;
        }

        .edit-btn, .delete-btn {
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .edit-btn {
            background-color: var(--primary-color);
            color: white;
        }

        .edit-btn:hover {
            background-color: var(--primary-dark);
        }

        .delete-btn {
            background-color: #dc2626;
            color: white;
        }

        .delete-btn:hover {
            background-color: #b91c1c;
        }

        .no-items-message {
            text-align: center;
            padding: 3rem;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
        }

        .no-items-message i {
            font-size: 3rem;
            color: var(--text-light);
            margin-bottom: 1rem;
        }

        .no-items-message h3 {
            font-size: 1.5rem;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }

        .no-items-message p {
            color: var(--text-light);
        }

        .success-message, .error-message {
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
            text-align: center;
            font-weight: 500;
        }

        .success-message {
            background-color: #dcfce7;
            color: #16a34a;
        }

        .error-message {
            background-color: #fee2e2;
            color: #dc2626;
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
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: var(--white);
            padding: 2rem;
            border-radius: var(--radius);
            max-width: 500px;
            width: 90%;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 1rem;
        }

        .modal-text {
            color: var(--text-color);
            margin-bottom: 1.5rem;
        }

        .modal-buttons {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }

        .cancel-btn, .save-btn {
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
        }

        .cancel-btn {
            background-color: var(--background-color);
            color: var(--text-color);
        }

        .cancel-btn:hover {
            background-color: var(--border-color);
        }

        .save-btn {
            background-color: var(--primary-color);
            color: white;
        }

        .save-btn:hover {
            background-color: var(--primary-dark);
        }

        @media (max-width: 768px) {
            header {
                flex-direction: column;
                padding: 1rem;
            }

            nav {
                margin: 1rem 0;
                width: 100%;
                justify-content: center;
                flex-wrap: wrap;
            }

            .profile-header {
                flex-direction: column;
                text-align: center;
                padding: 1.5rem;
            }

            .profile-stats {
                justify-content: center;
            }

            .profile-details {
                grid-template-columns: 1fr;
            }

            .items-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="logo-container">
            <img src="<%=request.getContextPath()%>/images/logo.jpg" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; width=&quot;80&quot; height=&quot;80&quot; viewBox=&quot;0 0 24 24&quot; fill=&quot;none&quot; stroke=&quot;%234f46e5&quot; stroke-width=&quot;2&quot; stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot;&gt;&lt;path d=&quot;M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z&quot;&gt;&lt;/path&gt;&lt;polyline points=&quot;9 22 9 12 15 12 15 22&quot;&gt;&lt;/polyline&gt;&lt;/svg&gt;'">
        </div>
        <nav>
            <a href="<%=request.getContextPath()%>/">Home</a>
            <a href="<%=request.getContextPath()%>/lost">Lost</a>
            <a href="<%=request.getContextPath()%>/report-lost">Report Lost</a>
            <a href="<%=request.getContextPath()%>/found">Found</a>
            <a href="<%=request.getContextPath()%>/report-found">Report Found</a>
            <a href="<%=request.getContextPath()%>/about">About Us</a>
            <a href="<%=request.getContextPath()%>/contact">Contact</a>
        </nav>
        <div class="user-actions">
            <button class="profile-icon-button" onclick="location.href='<%=request.getContextPath()%>/profile'">
                <span class="profile-icon">👤</span>
            </button>
            <button class="sign-out-button" onclick="location.href='<%=request.getContextPath()%>/logout'">Sign Out</button>
        </div>
    </header>

    <main>
        <div class="profile-header">
            <div class="profile-avatar">
                <%= user.getFullName().charAt(0) %>
            </div>
            <div class="profile-info">
                <h1 class="profile-name"><%= user.getFullName() %></h1>
                <p style="color: var(--text-light);">@<%= user.getUsername() %></p>
                <div class="profile-stats">
                    <div class="stat-item">
                        <div class="stat-value"><%= userItems != null ? userItems.size() : 0 %></div>
                        <div class="stat-label">Items Posted</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-value"><%= userItems != null ? userItems.stream().filter(item -> "approved".equals(item.getStatus())).count() : 0 %></div>
                        <div class="stat-label">Approved Items</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="profile-section">
            <h2 class="section-title"><i class="fas fa-user"></i> Profile Information</h2>
            <div class="profile-details">
                <div class="detail-item">
                    <div class="detail-label">Full Name</div>
                    <div class="detail-value"><%= user.getFullName() %></div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Username</div>
                    <div class="detail-value">@<%= user.getUsername() %></div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Email</div>
                    <div class="detail-value"><%= user.getEmail() %></div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Phone Number</div>
                    <div class="detail-value"><%= user.getPhoneNumber() %></div>
                </div>
            </div>
        </div>

        <div class="profile-section">
            <h2 class="section-title"><i class="fas fa-box"></i> My Posted Items</h2>
            
            <% if (request.getParameter("success") != null) { %>
                <div class="success-message">
                    <i class="fas fa-check-circle"></i> Item updated successfully!
                </div>
            <% } %>
            
            <% if (request.getParameter("deleteSuccess") != null) { %>
                <div class="success-message">
                    <i class="fas fa-check-circle"></i> Item deleted successfully!
                </div>
            <% } %>
            
            <% if (request.getParameter("deleteError") != null) { %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> Failed to delete item. Please try again.
                </div>
            <% } %>

            <% if (userItems != null && !userItems.isEmpty()) { %>
                <div class="items-grid">
                    <% for (Item item : userItems) { %>
                        <div class="item-card">
                            <div class="item-image">
                                <% if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) { %>
                                    <img src="<%=request.getContextPath()%>/<%=item.getImageUrl()%>" alt="<%=item.getTitle()%>">
                                <% } else { %>
                                    <div class="no-image">
                                        <i class="fas fa-image"></i>
                                    </div>
                                <% } %>
                            </div>
                            <div class="item-details">
                                <h3><%=item.getTitle()%></h3>
                                <div class="item-meta">
                                    <span class="item-type <%=item.getPostType()%>"><%=item.getPostType()%></span>
                                    <span class="item-status <%=item.getStatus()%>"><%=item.getStatus()%></span>
                                </div>
                                <p class="item-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <%=item.getLocation()%>
                                </p>
                                <p class="item-description"><%=item.getDescription()%></p>
                                <p class="item-date">
                                    <i class="fas fa-clock"></i>
                                    Posted: <%=item.getPostedAt()%>
                                </p>
                                <div class="item-actions">
                                    <button onclick="location.href='<%=request.getContextPath()%>/edit-item?id=<%=item.getId()%>'" class="edit-btn">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button onclick="showDeleteConfirmation(<%=item.getId()%>, '<%=item.getTitle()%>')" class="delete-btn">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } else { %>
                <div class="no-items-message">
                    <i class="fas fa-box-open"></i>
                    <h3>No Items Posted</h3>
                    <p>You haven't posted any items yet.</p>
                </div>
            <% } %>
        </div>
    </main>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h2 class="modal-title">Delete Item</h2>
            <p class="modal-text">Are you sure you want to delete "<span id="deleteItemTitle"></span>"? This action cannot be undone.</p>
            <div class="modal-buttons">
                <button onclick="hideDeleteConfirmation()" class="cancel-btn">Cancel</button>
                <form id="deleteForm" action="<%=request.getContextPath()%>/delete-item" method="POST" style="display: inline;">
                    <input type="hidden" id="deleteItemId" name="id" value="">
                    <button type="submit" class="save-btn">Delete</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function showDeleteConfirmation(itemId, itemTitle) {
            document.getElementById('deleteItemId').value = itemId;
            document.getElementById('deleteItemTitle').textContent = itemTitle;
            document.getElementById('deleteModal').style.display = 'flex';
        }

        function hideDeleteConfirmation() {
            document.getElementById('deleteModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('deleteModal');
            if (event.target == modal) {
                hideDeleteConfirmation();
            }
        }
    </script>
</body>
</html> 