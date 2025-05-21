<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Home Again - Find & Recover</title>
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
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Inter', system-ui, -apple-system, sans-serif;
    }

    html, body {
      margin: 0;
      padding: 0;
      width: 100%;
      box-sizing: border-box;
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
      color: var(--text-color);
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

    /* Main Content Styles */
    main {
      flex: 1;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 2rem;
    }

    .hero {
      text-align: center;
      width: 100%;
      min-height: 500px;
      height: auto;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 3rem 2rem;
      position: relative;
      color: var(--white);
      background: url('<%=request.getContextPath()%>/images/lost-and-found-full.jpg') center/cover no-repeat;
      border-radius: 0;
      box-shadow: none;
      overflow: hidden;
      margin-top: 0;
    }
    .hero::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(20, 20, 30, 0.65);
      z-index: 1;
    }
    .hero h1, .hero p, .button-group {
      position: relative;
      z-index: 2;
      color: var(--white);
      font-weight: bold;
    }
    .hero h1 {
      font-size: 3rem;
      font-weight: 700;
      color: var(--white);
      margin-bottom: 1.5rem;
      line-height: 1.2;
    }

    .hero p {
      font-size: 1.2rem;
      color: var(--white);
      margin-bottom: 2.5rem;
    }

    .button-group {
      position: relative;
      z-index: 2;
      display: flex;
      gap: 1rem;
      justify-content: center;
    }

    .primary-button {
      background-color: var(--primary-color);
      color: white;
      border: none;
      border-radius: var(--radius);
      padding: 0.75rem 2rem;
      font-size: 1rem;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .primary-button:hover {
      background-color: var(--primary-dark);
      transform: translateY(-2px);
      box-shadow: var(--shadow);
    }

    .dashboard-image-container {
      display: none;
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

      .hero h1 {
        font-size: 2.5rem;
      }

      .button-group {
        flex-direction: column;
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

    .how-it-works {
      background: var(--white);
      padding: 3rem 1rem 2rem 1rem;
      text-align: center;
      margin: 0 auto 2rem auto;
      max-width: 1200px;
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow);
    }
    .how-it-works h2 {
      color: var(--text-color);
      font-size: 2rem;
      margin-bottom: 2rem;
    }
    .steps {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 2rem;
    }
    .step {
      background: var(--background-color);
      border-radius: var(--radius);
      box-shadow: var(--shadow-sm);
      padding: 2rem 1.5rem;
      width: 220px;
      display: flex;
      flex-direction: column;
      align-items: center;
      transition: box-shadow 0.3s;
    }
    .step:hover {
      box-shadow: var(--shadow-lg);
    }
    .step-icon {
      font-size: 2.5rem;
      margin-bottom: 1rem;
    }
    .step h3 {
      color: var(--text-color);
      margin-bottom: 0.5rem;
    }
    .step p {
      color: var(--text-light);
      font-size: 1rem;
    }

    .features {
      background: var(--background-color);
      padding: 3rem 1rem 2rem 1rem;
      text-align: center;
      margin: 0 auto 2rem auto;
      max-width: 1200px;
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow);
    }
    .features h2 {
      color: var(--text-color);
      font-size: 2rem;
      margin-bottom: 2rem;
    }
    .feature-cards {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 2rem;
    }
    .feature-card {
      background: var(--white);
      border-radius: var(--radius);
      box-shadow: var(--shadow-sm);
      padding: 2rem 1.5rem;
      width: 220px;
      display: flex;
      flex-direction: column;
      align-items: center;
      transition: box-shadow 0.3s;
    }
    .feature-card:hover {
      box-shadow: var(--shadow-lg);
    }
    .feature-icon {
      font-size: 2.5rem;
      margin-bottom: 1rem;
    }
    .feature-card h3 {
      color: var(--text-color);
      margin-bottom: 0.5rem;
    }
    .feature-card p {
      color: var(--text-light);
      font-size: 1rem;
    }
    @media (max-width: 900px) {
      .steps, .feature-cards {
        flex-direction: column;
        gap: 1.5rem;
        align-items: center;
      }
    }
  </style>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
    <div class="hero">
      <h1>Find & Recover With Ease</h1>
      <p>Experience effortless recovery with our dedicated lost and found services.</p>
      <div class="button-group">
        <button onclick="location.href='<%=request.getContextPath()%>/lost'" class="primary-button">Lost</button>
        <button onclick="location.href='<%=request.getContextPath()%>/found'" class="primary-button">Found</button>
      </div>
    </div>
  </main>

  <!-- How It Works Section -->
  <section class="how-it-works">
    <h2>How It Works</h2>
    <div class="steps">
      <div class="step">
        <div class="step-icon"><i class="fas fa-search"></i></div>
        <h3>1. Search</h3>
        <p>Look for your lost or found item in our extensive database.</p>
      </div>
      <div class="step">
        <div class="step-icon"><i class="fas fa-file-alt"></i></div>
        <h3>2. Report</h3>
        <p>Submit a report for a lost or found item with easy-to-use forms.</p>
      </div>
      <div class="step">
        <div class="step-icon"><i class="fas fa-handshake"></i></div>
        <h3>3. Connect</h3>
        <p>Get in touch with the finder or owner to arrange recovery.</p>
      </div>
      <div class="step">
        <div class="step-icon"><i class="fas fa-home"></i></div>
        <h3>4. Reunite</h3>
        <p>Bring lost items back to their rightful owners quickly and safely.</p>
      </div>
    </div>
  </section>

  <!-- Features Section -->
  <section class="features">
    <h2>Why Choose HomeAgain?</h2>
    <div class="feature-cards">
      <div class="feature-card">
        <div class="feature-icon"><i class="fas fa-lock"></i></div>
        <h3>Secure & Private</h3>
        <p>Your data and privacy are always protected on our platform.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon"><i class="fas fa-bolt"></i></div>
        <h3>Fast Recovery</h3>
        <p>Quickly report and recover lost items with our streamlined process.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon"><i class="fas fa-users"></i></div>
        <h3>Community Driven</h3>
        <p>Join a supportive community dedicated to helping each other.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon"><i class="fas fa-life-ring"></i></div>
        <h3>24/7 Support</h3>
        <p>Our team is always here to help you, day or night.</p>
      </div>
    </div>
  </section>

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
</body>
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
</html>