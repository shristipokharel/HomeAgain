<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - HomeAgain</title>
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

        /* Contact Page Specific Styles */
        .page-title {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
            text-align: center;
        }

        .page-description {
            text-align: center;
            color: var(--text-light);
            max-width: 800px;
            margin: 0 auto 3rem;
        }

        .contact-layout {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }

        @media (max-width: 968px) {
            .contact-layout {
                grid-template-columns: 1fr;
            }
        }

        .contact-form-container {
            background-color: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 2rem;
        }

        .contact-form-container h2 {
            font-size: 1.5rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: var(--text-color);
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
            min-height: 150px;
            resize: vertical;
        }

        .button-primary {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: var(--radius);
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            width: 100%;
        }

        .button-primary:hover {
            background-color: var(--primary-dark);
            transform: translateY(-1px);
        }

        .contact-info {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            border-radius: var(--radius);
            padding: 2rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .contact-info h2 {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .contact-methods {
            margin-bottom: 2rem;
        }

        .contact-method {
            display: flex;
            align-items: flex-start;
            margin-bottom: 1.5rem;
        }

        .contact-icon {
            width: 24px;
            height: 24px;
            margin-right: 1rem;
            flex-shrink: 0;
        }

        .contact-details {
            flex: 1;
        }

        .contact-details h3 {
            font-size: 1.1rem;
            margin-bottom: 0.25rem;
        }

        .contact-details p {
            margin: 0;
            opacity: 0.9;
            font-size: 0.95rem;
        }

        .office-hours {
            margin-top: auto;
        }

        .office-hours h3 {
            font-size: 1.1rem;
            margin-bottom: 0.75rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding-bottom: 0.5rem;
        }

        .hours-list {
            list-style: none;
        }

        .hours-list li {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .map-container {
            margin-top: 3rem;
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            height: 400px;
        }

        .map-container iframe {
            width: 100%;
            height: 100%;
            border: 0;
        }

        /* Success Message */
        .success-message {
            background-color: var(--success);
            color: white;
            padding: 1rem;
            border-radius: var(--radius);
            margin-bottom: 1.5rem;
            text-align: center;
            box-shadow: var(--shadow);
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
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
            <img src="<%=request.getContextPath()%>/images/logo.jpg" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'80\' height=\'80\' viewBox=\'0 0 80 80\' fill=\'none\'><rect width=\'80\' height=\'80\' rx=\'16\' fill=\'%234f46e5\'/><path d=\'M40 15L15 32V65H30V45H50V65H65V32L40 15Z\' fill=\'white\'/><circle cx=\'40\' cy=\'32\' r=\'8\' fill=\'%23818cf8\'/><path d=\'M44 52H36V65H44V52Z\' fill=\'%23818cf8\'/></svg>'">
        </div>
        <nav>
            <a href="<%=request.getContextPath()%>/">Home</a>
            <a href="<%=request.getContextPath()%>/lost">Lost</a>
            <a href="<%=request.getContextPath()%>/report-lost">Report Lost</a>
            <a href="<%=request.getContextPath()%>/found">Found</a>
            <a href="<%=request.getContextPath()%>/report-found">Report Found</a>
            <a href="<%=request.getContextPath()%>/about">About Us</a>
            <a href="<%=request.getContextPath()%>/contact" class="active">Contact</a>
        </nav>
        <div class="user-actions">
            <button class="profile-icon-button" onclick="location.href='<%=request.getContextPath()%>/profile'">
                <span class="profile-icon">👤</span>
            </button>
            <button class="sign-out-button" onclick="showSignOutConfirmation()">Sign Out</button>
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

    <main>
        <div class="container">
            <h1 class="page-title">Contact Us</h1>
            <p class="page-description">Have a question or need assistance? We're here to help! Reach out to us using any of the contact methods below or fill out the form.</p>
            
            <div class="contact-layout">
                <div class="contact-form-container">
                    <h2>Send us a message</h2>
                    
                    <% if (session.getAttribute("contactMessage") != null) { %>
                    <div class="success-message">
                        <%= session.getAttribute("contactMessage") %>
                        <% session.removeAttribute("contactMessage"); %>
                    </div>
                    <% } %>
                    
                    <form action="<%=request.getContextPath()%>/contact" method="POST">
                        <div class="form-group">
                            <label for="name">Your Name*</label>
                            <input type="text" id="name" name="name" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="email">Email Address*</label>
                            <input type="email" id="email" name="email" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="subject">Subject*</label>
                            <input type="text" id="subject" name="subject" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="message">Message*</label>
                            <textarea id="message" name="message" class="form-control" required></textarea>
                        </div>
                        <button type="submit" class="button-primary">Send Message</button>
                    </form>
                </div>
                
                <div class="contact-info">
                    <div>
                        <h2>Get in Touch</h2>
                        <div class="contact-methods">
                            <div class="contact-method">
                                <svg class="contact-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                                </svg>
                                <div class="contact-details">
                                    <h3>Phone</h3>
                                    <p>+987 654 321</p>
                                    <p>+123 456 789</p>
                                </div>
                            </div>
                            <div class="contact-method">
                                <svg class="contact-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                                    <polyline points="22,6 12,13 2,6"></polyline>
                                </svg>
                                <div class="contact-details">
                                    <h3>Email</h3>
                                    <p>info@homeagain.com</p>
                                    <p>support@homeagain.com</p>
                                </div>
                            </div>
                            <div class="contact-method">
                                <svg class="contact-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                    <circle cx="12" cy="10" r="3"></circle>
                                </svg>
                                <div class="contact-details">
                                    <h3>Address</h3>
                                    <p>123 Lost & Found Street</p>
                                    <p>Kathmandu, Nepal</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="office-hours">
                        <h3>Office Hours</h3>
                        <ul class="hours-list">
                            <li>
                                <span>Monday - Friday</span>
                                <span>9:00 AM - 6:00 PM</span>
                            </li>
                            <li>
                                <span>Saturday</span>
                                <span>10:00 AM - 4:00 PM</span>
                            </li>
                            <li>
                                <span>Sunday</span>
                                <span>Closed</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <div class="map-container">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14130.857353934142!2d85.31015971041057!3d27.709664680673434!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb19a7f987b1eb%3A0x85fbdd0d514b7f6e!2sKathmandu%2044600!5e0!3m2!1sen!2snp!4v1648226954532!5m2!1sen!2snp" allowfullscreen="" loading="lazy"></iframe>
            </div>
        </div>
    </main>

    <footer>
        <div class="footer-content">
            <div class="footer-logo">
                <img src="<%=request.getContextPath()%>/images/logo.jpg" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'80\' height=\'80\' viewBox=\'0 0 80 80\' fill=\'none\'><rect width=\'80\' height=\'80\' rx=\'16\' fill=\'%234f46e5\'/><path d=\'M40 15L15 32V65H30V45H50V65H65V32L40 15Z\' fill=\'white\'/><circle cx=\'40\' cy=\'32\' r=\'8\' fill=\'%23818cf8\'/><path d=\'M44 52H36V65H44V52Z\' fill=\'%23818cf8\'/></svg>'">
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
                <p onclick="location.href='<%=request.getContextPath()%>/about'">About Us</p>
                <p onclick="location.href='<%=request.getContextPath()%>/contact'">Contact Us</p>
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