<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report Found Item - HomeAgain</title>
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

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            font-family: 'Inter', sans-serif;
            font-size: 1rem;
            transition: var(--transition);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .custom-file-upload {
            display: block;
            position: relative;
            border: 1px dashed var(--border-color);
            border-radius: var(--radius);
            padding: 2rem 1rem;
            text-align: center;
            cursor: pointer;
            background-color: rgba(229, 231, 235, 0.2);
            transition: var(--transition);
        }

        .custom-file-upload:hover {
            background-color: rgba(79, 70, 229, 0.05);
            border-color: var(--primary-color);
        }

        .custom-file-upload span {
            display: block;
            margin-top: 0.5rem;
            color: var(--text-light);
            font-size: 0.875rem;
        }

        input[type="file"] {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
        }

        .button {
            padding: 0.75rem 1.5rem;
            border-radius: var(--radius);
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            border: none;
        }

        .button-secondary {
            background-color: var(--background-color);
            color: var(--text-color);
            border: 1px solid var(--border-color);
        }

        .button-secondary:hover {
            background-color: #e5e7eb;
        }

        .button-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .button-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-1px);
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
            <img src="<%=request.getContextPath()%>/images/logo.png" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'80\' height=\'80\' viewBox=\'0 0 24 24\' fill=\'none\' stroke=\'%234f46e5\' stroke-width=\'2\' stroke-linecap=\'round\' stroke-linejoin=\'round\'><path d=\'M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z\'></path><polyline points=\'9 22 9 12 15 12 15 22\'></polyline></svg>'">
        </div>
        <nav>
            <a href="<%=request.getContextPath()%>/">Home</a>
            <a href="<%=request.getContextPath()%>/lost">Lost</a>
            <a href="<%=request.getContextPath()%>/report-lost">Report Lost</a>
            <a href="<%=request.getContextPath()%>/found">Found</a>
            <a href="<%=request.getContextPath()%>/report-found" class="active">Report Found</a>
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
            <h1>Report a Found Item</h1>
            <p class="page-description">Please provide as much detail as possible about the item you found to help us reunite it with its owner.</p>
            
            <form action="<%=request.getContextPath()%>/report-found" method="POST" enctype="multipart/form-data">
                <div class="form-container">
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="itemName">Item Name/Title*</label>
                            <input type="text" id="itemName" name="itemName" class="form-control" placeholder="e.g. Black iPhone 13 Pro" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="category">Category*</label>
                            <select id="category" name="category" class="form-control" required>
                                <option value="">Select a category</option>
                                <option value="1">Electronics</option>
                                <option value="2">Jewelry & Watches</option>
                                <option value="3">Documents & IDs</option>
                                <option value="4">Clothing & Accessories</option>
                                <option value="5">Bags & Luggage</option>
                                <option value="6">Keys</option>
                                <option value="7">Pets</option>
                                <option value="8">Other</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="dateFound">Date Found*</label>
                            <input type="date" id="dateFound" name="dateFound" class="form-control" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="timeFound">Approximate Time Found</label>
                            <input type="time" id="timeFound" name="timeFound" class="form-control">
                        </div>
                        
                        <div class="form-group full-width">
                            <label for="location">Location Found*</label>
                            <input type="text" id="location" name="location" class="form-control" placeholder="e.g. Central Park, near the fountain" required>
                        </div>
                        
                        <div class="form-group full-width">
                            <label for="description">Description*</label>
                            <textarea id="description" name="description" class="form-control" placeholder="Please provide a detailed description of the item, including any identifying marks or features..." required></textarea>
                        </div>
                        
                        <div class="form-group">
                            <label for="contactNumber">Contact Phone*</label>
                            <input type="tel" id="contactNumber" name="contactNumber" class="form-control" placeholder="Your phone number" required>
                        </div>
                        
                        <div class="form-group full-width">
                            <label for="itemImage">Upload Image (if available)</label>
                            <div class="custom-file-upload">
                                <input type="file" id="itemImage" name="itemImage" accept="image/*">
                                <i class="fas fa-cloud-upload-alt"></i>
                                <span>Drag & drop an image here, or click to select</span>
                                <span>Supported formats: JPG, PNG, GIF (Max 5MB)</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="button-group">
                        <button type="button" class="button button-secondary" onclick="history.back()">Cancel</button>
                        <button type="submit" class="button button-primary">Submit Report</button>
                    </div>
                </div>
            </form>
        </div>
    </main>

    <footer>
        <div class="footer-content">
            <div class="footer-logo">
                <img src="<%=request.getContextPath()%>/images/logo.png" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'80\' height=\'80\' viewBox=\'0 0 24 24\' fill=\'none\' stroke=\'%234f46e5\' stroke-width=\'2\' stroke-linecap=\'round\' stroke-linejoin=\'round\'><path d=\'M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z\'></path><polyline points=\'9 22 9 12 15 12 15 22\'></polyline></svg>'">
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
        // Simple preview for file upload
        document.getElementById('itemImage').addEventListener('change', function(e) {
            const fileName = e.target.files[0]?.name;
            if (fileName) {
                const fileUpload = e.target.parentElement;
                fileUpload.innerHTML = `<input type="file" id="itemImage" name="itemImage" accept="image/*">
                                       <i class="fas fa-check"></i>
                                       <span>Selected: ${fileName}</span>
                                       <span>Click to change file</span>`;
                
                // Re-add event listener to new input
                document.getElementById('itemImage').addEventListener('change', arguments.callee);
            }
        });
    </script>
</body>
</html>
