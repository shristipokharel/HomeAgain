<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - HomeAgain</title>
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

        /* About Page Specific Styles */
        .about-hero {
            background: linear-gradient(to right, var(--primary-color), var(--primary-dark));
            color: white;
            padding: 4rem 2rem;
            border-radius: var(--radius-lg);
            margin-bottom: 3rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .about-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><circle cx="50" cy="50" r="40" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="2"/></svg>') repeat;
            opacity: 0.3;
        }

        .about-hero h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            position: relative;
            color: white;
        }

        .about-hero p {
            font-size: 1.25rem;
            max-width: 800px;
            margin: 0 auto;
            position: relative;
        }

        .card {
            background-color: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 2rem;
            margin-bottom: 2rem;
            transition: var(--transition);
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .about-section {
            margin-bottom: 3rem;
        }

        .about-section h2 {
            font-size: 1.8rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 0.5rem;
        }

        .about-section h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 3px;
            background: linear-gradient(to right, var(--primary-color), var(--primary-light));
            border-radius: var(--radius-full);
        }

        .about-section p {
            color: var(--text-color);
            margin-bottom: 1rem;
        }

        .value-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .value-card {
            background-color: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 1.5rem;
            transition: var(--transition);
            border-top: 3px solid var(--primary-color);
        }

        .value-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
        }

        .value-card h3 {
            color: var(--primary-color);
            margin-bottom: 0.75rem;
            font-size: 1.25rem;
        }

        .value-card p {
            color: var(--text-light);
            font-size: 0.95rem;
        }

        .team-section {
            margin-bottom: 3rem;
        }

        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 2rem;
        }

        .team-member {
            text-align: center;
        }

        .team-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto 1rem;
            box-shadow: var(--shadow);
            border: 3px solid var(--white);
        }

        .team-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .team-member h3 {
            color: var(--text-color);
            margin-bottom: 0.25rem;
        }

        .team-member p {
            color: var(--text-light);
            font-size: 0.875rem;
        }

        .stats-section {
            background: linear-gradient(to right, var(--primary-light), var(--primary-color));
            border-radius: var(--radius-lg);
            padding: 3rem 2rem;
            margin-bottom: 3rem;
            color: white;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 2rem;
            text-align: center;
        }

        .stat-item h3 {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }

        .stat-item p {
            font-size: 1rem;
            opacity: 0.9;
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

            .about-hero h1 {
                font-size: 2rem;
            }

            .about-hero p {
                font-size: 1rem;
            }

            .value-cards, .team-grid, .stats-grid {
                grid-template-columns: 1fr;
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
            <img src="<%=request.getContextPath()%>/images/logo.png" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'80\' height=\'80\' viewBox=\'0 0 80 80\' fill=\'none\'><rect width=\'80\' height=\'80\' rx=\'16\' fill=\'%234f46e5\'/><path d=\'M40 15L15 32V65H30V45H50V65H65V32L40 15Z\' fill=\'white\'/><circle cx=\'40\' cy=\'32\' r=\'8\' fill=\'%23818cf8\'/><path d=\'M44 52H36V65H44V52Z\' fill=\'%23818cf8\'/></svg>'">
        </div>
        <nav>
            <a href="<%=request.getContextPath()%>/">Home</a>
            <a href="<%=request.getContextPath()%>/lost">Lost</a>
            <a href="<%=request.getContextPath()%>/report-lost">Report Lost</a>
            <a href="<%=request.getContextPath()%>/found">Found</a>
            <a href="<%=request.getContextPath()%>/report-found">Report Found</a>
            <a href="<%=request.getContextPath()%>/about" class="active">About Us</a>
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
            <div class="about-hero">
                <h1>Reuniting People with Their Cherished Items</h1>
                <p>HomeAgain is dedicated to creating a supportive community where lost belongings find their way back home.</p>
            </div>

            <div class="about-section">
                <h2>Our Story</h2>
                <div class="card">
                    <p>HomeAgain was founded in 2020 with a simple mission: to help people recover their lost items and to provide a platform for good samaritans to return found belongings.</p>
                    <p>What started as a small community initiative has grown into a comprehensive lost and found platform serving thousands of users. We understand that lost items are often more than just objects - they can hold sentimental value, important information, or be essential for daily life.</p>
                    <p>Our platform brings together technology and community spirit to create a space where people can easily report lost items, list found belongings, and connect with each other to recover what matters most to them.</p>
                </div>
            </div>

            <div class="about-section">
                <h2>Our Values</h2>
                <div class="value-cards">
                    <div class="value-card">
                        <h3>Community Trust</h3>
                        <p>We foster a trusted environment where users can safely connect with others who have found or lost items.</p>
                    </div>
                    <div class="value-card">
                        <h3>Accessibility</h3>
                        <p>Our platform is designed to be user-friendly and accessible to everyone, regardless of technical ability.</p>
                    </div>
                    <div class="value-card">
                        <h3>Privacy & Security</h3>
                        <p>We prioritize the protection of user data and provide secure channels for communication.</p>
                    </div>
                    <div class="value-card">
                        <h3>Empathy</h3>
                        <p>We understand the emotional impact of losing valued possessions and approach every situation with compassion.</p>
                    </div>
                </div>
            </div>

            <div class="stats-section">
                <div class="stats-grid">
                    <div class="stat-item">
                        <h3>10,000+</h3>
                        <p>Items Recovered</p>
                    </div>
                    <div class="stat-item">
                        <h3>15,000+</h3>
                        <p>Active Users</p>
                    </div>
                    <div class="stat-item">
                        <h3>95%</h3>
                        <p>Satisfaction Rate</p>
                    </div>
                    <div class="stat-item">
                        <h3>24/7</h3>
                        <p>Platform Availability</p>
                    </div>
                </div>
            </div>

            <div class="about-section">
                <h2>Meet Our Team</h2>
                <div class="team-grid">
                    <div class="team-member">
                        <div class="team-avatar">
                            <img src="https://randomuser.me/api/portraits/women/43.jpg" alt="Sarah Johnson">
                        </div>
                        <h3>Sarah Johnson</h3>
                        <p>Founder & CEO</p>
                    </div>
                    <div class="team-member">
                        <div class="team-avatar">
                            <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Michael Chen">
                        </div>
                        <h3>Michael Chen</h3>
                        <p>Chief Technology Officer</p>
                    </div>
                    <div class="team-member">
                        <div class="team-avatar">
                            <img src="https://randomuser.me/api/portraits/women/65.jpg" alt="Amara Patel">
                        </div>
                        <h3>Amara Patel</h3>
                        <p>Head of Customer Support</p>
                    </div>
                    <div class="team-member">
                        <div class="team-avatar">
                            <img src="https://randomuser.me/api/portraits/men/75.jpg" alt="David Rodriguez">
                        </div>
                        <h3>David Rodriguez</h3>
                        <p>Marketing Director</p>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <div class="footer-content">
            <div class="footer-logo">
                <img src="<%=request.getContextPath()%>/images/logo.png" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'80\' height=\'80\' viewBox=\'0 0 80 80\' fill=\'none\'><rect width=\'80\' height=\'80\' rx=\'16\' fill=\'%234f46e5\'/><path d=\'M40 15L15 32V65H30V45H50V65H65V32L40 15Z\' fill=\'white\'/><circle cx=\'40\' cy=\'32\' r=\'8\' fill=\'%23818cf8\'/><path d=\'M44 52H36V65H44V52Z\' fill=\'%23818cf8\'/></svg>'">
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
</body>
</html> 