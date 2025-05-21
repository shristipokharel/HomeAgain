<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report Lost Item - HomeAgain</title>
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
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --radius-sm: 0.375rem;
            --radius: 0.5rem;
            --radius-lg: 0.75rem;
            --radius-xl: 1rem;
            --radius-full: 9999px;
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
        }

        /* Header Styles */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            background-color: var(--white);
            border-bottom: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 1000;
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
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
            filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
        }

        .logo:hover {
            transform: scale(1.05) rotate(5deg);
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
            background: linear-gradient(to right, var(--primary-color), var(--primary-dark));
            transition: width 0.3s ease;
        }

        nav a:hover, nav a.active {
            color: var(--primary-color);
        }

        nav a:hover::after, nav a.active::after {
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
            display: flex;
            align-items: center;
            justify-content: center;
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
            transition: all 0.3s ease;
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
            transform: translateY(-1px);
        }

        /* Main Content */
        main {
            flex: 1;
            padding: 2rem 0;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        h1 {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: var(--primary-color);
        }

        .page-description {
            color: var(--text-light);
            margin-bottom: 2rem;
            max-width: 800px;
        }

        /* Form Styles */
        .form-container {
            background-color: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        @media (max-width: 768px) {
            .form-group.full-width {
                grid-column: span 1;
            }
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text-color);
        }

        .form-input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            font-size: 1rem;
            transition: var(--transition);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px var(--primary-light);
        }

        .form-select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            font-size: 1rem;
            background-color: var(--white);
            cursor: pointer;
        }

        .form-textarea {
            min-height: 120px;
            resize: vertical;
        }

        .submit-button {
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: var(--radius);
            padding: 1rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            width: 100%;
            margin-top: 1rem;
        }

        .submit-button:hover {
            background-color: var(--primary-dark);
            transform: translateY(-1px);
        }

        .error-message {
            color: var(--danger);
            margin-top: 0.5rem;
            font-size: 0.875rem;
        }

        .success-message {
            color: var(--success);
            margin-top: 0.5rem;
            font-size: 0.875rem;
        }

        /* Map Container */
        .map-container {
            width: 100%;
            height: 300px;
            background-color: #e5e7eb;
            border-radius: var(--radius);
            margin-bottom: 1rem;
            position: relative;
            overflow: hidden;
        }

        .map-container iframe {
            width: 100%;
            height: 100%;
            border: 0;
        }

        /* Footer Styles */
        footer {
            margin-top: auto;
            background-color: var(--white);
            border-top: 1px solid var(--border-color);
            padding: 2rem 2rem 1rem;
            position: relative;
        }

        .footer-content {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 4rem;
            margin: 0;
            padding: 0;
        }

        .footer-logo {
            margin: 0;
            padding: 0;
            display: inline-block;
        }

        .footer-logo img {
            width: 80px;
            height: auto;
            transition: transform 0.3s ease;
        }

        .footer-section {
            flex: 1;
            min-width: 150px;
        }

        .footer-section h3 {
            margin-bottom: 0.75rem;
            color: var(--text-color);
            font-size: 1rem;
        }

        .footer-section p {
            margin: 0.5rem 0;
            color: var(--text-light);
            font-size: 0.9rem;
            cursor: pointer;
        }

        .footer-section p:hover {
            color: var(--primary-color);
        }

        .social-icons {
            display: flex;
            gap: 0.75rem;
            margin-top: 0.75rem;
        }

        .social-link img {
            width: 20px;
            height: 20px;
        }

        .footer-bottom {
            text-align: center;
            padding: 1rem 0 0;
            margin-top: 2rem;
            border-top: 1px solid var(--border-color);
        }

        .footer-bottom p {
            margin: 0.25rem 0;
            color: var(--text-light);
            font-size: 0.9rem;
        }

        /* Responsive styles */
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

            .footer-content {
                flex-direction: column;
                gap: 2rem;
            }

            .footer-section {
                width: 100%;
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <!-- Check if user is logged in -->
    <% 
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String username = (String) session.getAttribute("username");
    %>

    <header>
        <div class="logo-container">
            <img src="<%=request.getContextPath()%>/images/logo.jpg" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'80\' height=\'80\' viewBox=\'0 0 24 24\' fill=\'none\' stroke=\'%234f46e5\' stroke-width=\'2\' stroke-linecap=\'round\' stroke-linejoin=\'round\'><path d=\'M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z\'></path><polyline points=\'9 22 9 12 15 12 15 22\'></polyline></svg>'">
        </div>
        <nav>
            <a href="<%=request.getContextPath()%>/">Home</a>
            <a href="<%=request.getContextPath()%>/lost">Lost</a>
            <a href="<%=request.getContextPath()%>/report-lost" class="active">Report Lost</a>
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
        <div class="container">
            <h1>Report Lost Item</h1>
            <p class="page-description">Please provide detailed information about your lost item to help us find it.</p>

            <div class="form-container">
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message"><%= request.getAttribute("error") %></div>
                <% } %>
                <% if (request.getAttribute("message") != null) { %>
                    <div class="success-message"><%= request.getAttribute("message") %></div>
                <% } %>

                <form action="${pageContext.request.contextPath}/report-lost" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="form-label" for="itemName">Item Name *</label>
                        <input type="text" id="itemName" name="itemName" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="category">Category *</label>
                        <select id="category" name="category" class="form-select" required>
                            <option value="">Select a category</option>
                            <c:forEach items="${categories}" var="category">
                                <option value="${category.id}">${category.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="dateLost">Date Lost *</label>
                        <input type="date" id="dateLost" name="dateLost" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="timeLost">Time Lost (if known)</label>
                        <input type="time" id="timeLost" name="timeLost" class="form-input">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="location">Location Lost *</label>
                        <input type="text" id="location" name="location" class="form-input" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="description">Description *</label>
                        <textarea id="description" name="description" class="form-input form-textarea" required
                                placeholder="Please provide a detailed description of the item, including any distinguishing features..."></textarea>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="itemImage">Item Image</label>
                        <input type="file" id="itemImage" name="itemImage" class="form-input" accept="image/*">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="reward">Reward (if any)</label>
                        <input type="number" id="reward" name="reward" class="form-input" min="0">
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="contactNumber">Contact Number *</label>
                        <input type="tel" id="contactNumber" name="contactNumber" class="form-input" required>
                    </div>

                    <button type="submit" class="submit-button">Submit Report</button>
                </form>
            </div>
        </div>
    </main>

    <footer>
        <div class="footer-content">
            <div class="footer-logo">
                <img src="<%=request.getContextPath()%>/images/logo.jpg" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'80\' height=\'80\' viewBox=\'0 0 24 24\' fill=\'none\' stroke=\'%234f46e5\' stroke-width=\'2\' stroke-linecap=\'round\' stroke-linejoin=\'round\'><path d=\'M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z\'></path><polyline points=\'9 22 9 12 15 12 15 22\'></polyline></svg>'">
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
                    <a href="#" class="social-link">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="#1877f2">
                            <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path>
                        </svg>
                    </a>
                    <a href="#" class="social-link">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="#1da1f2">
                            <path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"></path>
                        </svg>
                    </a>
                    <a href="#" class="social-link">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="#e4405f">
                            <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                            <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z" stroke="white" stroke-width="1" fill="white"></path>
                            <line x1="17.5" y1="6.5" x2="17.51" y2="6.5" stroke="white" stroke-width="2" stroke-linecap="round"></line>
                        </svg>
                    </a>
                    <a href="#" class="social-link">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="#333">
                            <path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path>
                        </svg>
                    </a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© Copyright 2024 Home again</p>
            <p>All Right Reserved</p>
        </div>
    </footer>

    <script>
        // Set default date to today
        document.getElementById('dateLost').valueAsDate = new Date();
        
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const requiredFields = ['itemName', 'category', 'dateLost', 'location', 'description', 'contactNumber'];
            let isValid = true;
            
            requiredFields.forEach(field => {
                const input = document.getElementById(field);
                if (!input.value.trim()) {
                    isValid = false;
                    input.style.borderColor = 'var(--danger)';
                } else {
                    input.style.borderColor = 'var(--border-color)';
                }
            });
            
            if (!isValid) {
                e.preventDefault();
                alert('Please fill in all required fields');
            }
        });
    </script>
</body>
</html>
