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
    <style>
        /* Copy all styles from dashboard.jsp here for consistency */
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
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --radius-sm: 0.375rem;
            --radius: 0.5rem;
            --radius-lg: 0.75rem;
            --radius-xl: 1rem;
            --radius-full: 9999px;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Inter', system-ui, -apple-system, sans-serif; }
        body { min-height: 100vh; display: flex; flex-direction: column; background-color: var(--background-color); color: var(--text-color); line-height: 1.6; }
        header { display: flex; justify-content: space-between; align-items: center; padding: 1rem 2rem; background-color: var(--white); border-bottom: 1px solid var(--border-color); box-shadow: var(--shadow-sm); position: sticky; top: 0; z-index: 1000; backdrop-filter: blur(8px); -webkit-backdrop-filter: blur(8px); }
        .logo-container { display: flex; align-items: center; gap: 0.75rem; }
        .logo { width: 80px; height: auto; transition: transform 0.3s ease; filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1)); }
        .logo:hover { transform: scale(1.05) rotate(5deg); }
        nav { display: flex; gap: 2rem; align-items: center; }
        nav a { text-decoration: none; color: var(--secondary-color); font-weight: 500; padding: 0.5rem 0; position: relative; transition: all 0.3s ease; }
        nav a::after { content: ''; position: absolute; bottom: 0; left: 0; width: 0; height: 2px; background: linear-gradient(to right, var(--primary-color), var(--primary-dark)); transition: width 0.3s ease; }
        nav a:hover { color: var(--primary-color); }
        nav a:hover::after { width: 100%; }
        .user-actions { display: flex; align-items: center; gap: 1rem; }
        .profile-icon-button { background: none; border: none; cursor: pointer; padding: 0.5rem; border-radius: 50%; transition: all 0.3s ease; display: flex; align-items: center; justify-content: center; }
        .profile-icon-button:hover { background-color: var(--background-color); }
        .profile-icon { font-size: 1.5rem; background: var(--primary-light); color: var(--primary-color); padding: 0.5rem; border-radius: 50%; display: flex; align-items: center; justify-content: center; width: 40px; height: 40px; transition: all 0.3s ease; }
        .sign-out-button { background-color: var(--primary-color); color: white; border: none; border-radius: var(--radius); padding: 0.5rem 1rem; font-size: 0.9rem; font-weight: 500; cursor: pointer; transition: all 0.3s ease; }
        .sign-out-button:hover { background-color: var(--primary-dark); transform: translateY(-1px); }
        main { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 2rem; }
        .profile-container { background: var(--white); border-radius: var(--radius-lg); box-shadow: var(--shadow); padding: 2rem 3rem; max-width: 500px; width: 100%; margin: 2rem auto; }
        .profile-title { font-size: 2rem; font-weight: 700; margin-bottom: 1.5rem; text-align: center; background: linear-gradient(to right, var(--primary-color), var(--primary-dark)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
        .profile-details { margin-bottom: 2rem; }
        .profile-details label { display: block; font-weight: 600; color: var(--text-light); margin-bottom: 0.25rem; }
        .profile-details p { font-size: 1.1rem; color: var(--text-color); margin-bottom: 1rem; }
        .edit-profile-btn { background-color: var(--primary-color); color: white; border: none; border-radius: var(--radius); padding: 0.5rem 1.5rem; font-size: 1rem; font-weight: 500; cursor: pointer; transition: all 0.3s ease; display: block; margin: 0 auto; }
        .edit-profile-btn:hover { background-color: var(--primary-dark); }
        footer { margin-top: auto; background-color: var(--white); border-top: 1px solid var(--border-color); padding: 2rem 2rem 1rem; position: relative; }
        .footer-content { display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 4rem; margin: 0; padding: 0; }
        .footer-logo { margin: 0; padding: 0; display: inline-block; }
        .footer-logo img { width: 80px; height: auto; transition: transform 0.3s ease; }
        .footer-section { flex: 1; min-width: 150px; }
        .footer-section h3 { margin-bottom: 0.75rem; color: var(--text-color); font-size: 1rem; }
        .footer-section p { margin: 0.5rem 0; color: var(--text-light); font-size: 0.9rem; cursor: pointer; }
        .footer-section p:hover { color: var(--primary-color); }
        .social-icons { display: flex; gap: 0.75rem; margin-top: 0.75rem; }
        .social-link img { width: 20px; height: 20px; }
        .footer-bottom { text-align: center; padding: 1rem 0 0; margin-top: 2rem; border-top: 1px solid var(--border-color); }
        .footer-bottom p { margin: 0.25rem 0; color: var(--text-light); font-size: 0.9rem; }
        @media (max-width: 768px) { header { flex-direction: column; padding: 1rem; } nav { margin: 1rem 0; width: 100%; justify-content: center; flex-wrap: wrap; } .profile-title { font-size: 1.5rem; } .footer-content { flex-direction: column; gap: 2rem; } .footer-section { width: 100%; margin-left: 0; } }
        .items-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
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
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .no-image {
            color: var(--text-light);
            font-size: 1.2rem;
        }
        .item-details {
            padding: 1.5rem;
        }
        .item-details h3 {
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }
        .item-type {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: var(--radius);
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }
        .item-type.lost {
            background-color: #fee2e2;
            color: #dc2626;
        }
        .item-type.found {
            background-color: #dcfce7;
            color: #16a34a;
        }
        .item-status {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: var(--radius);
            font-size: 0.9rem;
            font-weight: 500;
            margin-left: 0.5rem;
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
        }
        .no-items-message {
            text-align: center;
            padding: 2rem;
            color: var(--text-light);
            font-size: 1.2rem;
        }
        @media (max-width: 768px) {
            .items-grid {
                grid-template-columns: 1fr;
            }
        }
        /* Add new styles for edit functionality */
        .success-message {
            background-color: #dcfce7;
            color: #16a34a;
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
            text-align: center;
            font-weight: 500;
        }

        .item-actions {
            margin-top: 1rem;
            display: flex;
            gap: 0.5rem;
        }

        .edit-btn {
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

        .edit-btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-1px);
        }

        .delete-btn {
            background-color: #dc2626;
            color: white;
            border: none;
            border-radius: var(--radius);
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-left: 0.5rem;
        }

        .delete-btn:hover {
            background-color: #b91c1c;
            transform: translateY(-1px);
        }

        .error-message {
            background-color: #fee2e2;
            color: #dc2626;
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1rem;
            text-align: center;
            font-weight: 500;
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
            border-radius: var(--radius-lg);
            max-width: 400px;
            width: 90%;
            text-align: center;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--text-color);
        }

        .modal-text {
            color: var(--text-light);
            margin-bottom: 1.5rem;
        }

        .modal-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .confirm-delete-btn {
            background-color: #dc2626;
            color: white;
        }

        .confirm-delete-btn:hover {
            background-color: #b91c1c;
        }

        .cancel-delete-btn {
            background-color: var(--text-light);
            color: white;
        }

        .cancel-delete-btn:hover {
            background-color: var(--secondary-color);
        }
    </style>
</head>
<body>
<header>
    <div class="logo-container">
        <img src="<%=request.getContextPath()%>/images/logo.png" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; width=&quot;80&quot; height=&quot;80&quot; viewBox=&quot;0 0 24 24&quot; fill=&quot;none&quot; stroke=&quot;%234f46e5&quot; stroke-width=&quot;2&quot; stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot;&gt;&lt;path d=&quot;M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z&quot;&gt;&lt;/path&gt;&lt;polyline points=&quot;9 22 9 12 15 12 15 22&quot;&gt;&lt;/polyline&gt;&lt;/svg&gt;'">
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
    <div class="profile-container">
        <div class="profile-title">My Profile</div>
        <div class="profile-details">
            <label>Full Name</label>
            <p><%=user.getFullName()%></p>
            <label>Username</label>
            <p><%=user.getUsername()%></p>
            <label>Email</label>
            <p><%=user.getEmail()%></p>
            <label>Phone Number</label>
            <p><%=user.getPhoneNumber()%></p>
        </div>
        <!-- Optionally, add an Edit Profile button here -->
        <!-- <button class="edit-profile-btn">Edit Profile</button> -->
    </div>

    <div class="profile-container">
        <div class="profile-title">My Posted Items</div>
        <% if (request.getParameter("success") != null) { %>
            <div class="success-message">
                Item updated successfully!
            </div>
        <% } %>
        <% if (request.getParameter("deleteSuccess") != null) { %>
            <div class="success-message">
                Item deleted successfully!
            </div>
        <% } %>
        <% if (request.getParameter("deleteError") != null) { %>
            <div class="error-message">
                Failed to delete item. Please try again.
            </div>
        <% } %>
        <% if (userItems != null && !userItems.isEmpty()) { %>
            <div class="items-grid">
                <% for (Item item : userItems) { %>
                    <div class="item-card">
                        <div class="item-image">
                            <% if (item.getImageUrl() != null && !item.getImageUrl().isEmpty()) { %>
                                <img src="<%=item.getImageUrl()%>" alt="<%=item.getTitle()%>">
                            <% } else { %>
                                <div class="no-image">No Image</div>
                            <% } %>
                        </div>
                        <div class="item-details">
                            <h3><%=item.getTitle()%></h3>
                            <p class="item-type <%=item.getPostType()%>"><%=item.getPostType()%></p>
                            <p class="item-status <%=item.getStatus()%>"><%=item.getStatus()%></p>
                            <p class="item-location">📍 <%=item.getLocation()%></p>
                            <p class="item-description"><%=item.getDescription()%></p>
                            <p class="item-date">Posted: <%=item.getPostedAt()%></p>
                            <div class="item-actions">
                                <button onclick="location.href='<%=request.getContextPath()%>/edit-item?id=<%=item.getId()%>'" class="edit-btn">Edit Item</button>
                                <button onclick="showDeleteConfirmation(<%=item.getId()%>, '<%=item.getTitle()%>')" class="delete-btn">Delete</button>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="no-items-message">
                <p>No items posted by the user</p>
            </div>
        <% } %>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h2 class="modal-title">Delete Item</h2>
            <p class="modal-text">Are you sure you want to delete "<span id="deleteItemTitle"></span>"? This action cannot be undone.</p>
            <div class="modal-buttons">
                <button onclick="hideDeleteConfirmation()" class="cancel-btn cancel-delete-btn">Cancel</button>
                <form id="deleteForm" action="<%=request.getContextPath()%>/delete-item" method="POST" style="display: inline;">
                    <input type="hidden" id="deleteItemId" name="id" value="">
                    <button type="submit" class="save-btn confirm-delete-btn">Delete</button>
                </form>
            </div>
        </div>
    </div>
</main>
<footer>
    <div class="footer-content">
        <div class="footer-logo">
            <img src="<%=request.getContextPath()%>/images/logo.png" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,&lt;svg xmlns=&quot;http://www.w3.org/2000/svg&quot; width=&quot;80&quot; height=&quot;80&quot; viewBox=&quot;0 0 24 24&quot; fill=&quot;none&quot; stroke=&quot;%234f46e5&quot; stroke-width=&quot;2&quot; stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot;&gt;&lt;path d=&quot;M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z&quot;&gt;&lt;/path&gt;&lt;polyline points=&quot;9 22 9 12 15 12 15 22&quot;&gt;&lt;/polyline&gt;&lt;/svg&gt;'">
        </div>
        <div class="footer-section">
            <h3>Site</h3>
            <p onclick="location.href='<%=request.getContextPath()%>/lost'">Lost</p>
            <p onclick="location.href='<%=request.getContextPath()%>/report-lost'">Report Lost</p>
            <p onclick="location.href='<%=request.getContextPath()%>/found'">Found</p>
            <p onclick="location.href='<%=request.getContextPath()%>/report-found'">Report Found</p>
        </div>
        <div class="footer-section">
            <h3>Help</h3>
            <p onclick="location.href='<%=request.getContextPath()%>/support'">Customer Support</p>
            <p onclick="location.href='<%=request.getContextPath()%>/terms'">Terms & Conditions</p>
            <p onclick="location.href='<%=request.getContextPath()%>/privacy'">Privacy Policy</p>
        </div>
        <div class="footer-section">
            <h3>Contact</h3>
            <p>Tel: +987654321</p>
            <p>Email: Homeagain@gmail.com</p>
            <div class="social-icons">
                <!-- Social icons as in dashboard.jsp -->
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <p>© Copyright 2024 Home again</p>
        <p>All Right Reserved</p>
    </div>
</footer>
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