<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Login - Home Again</title>
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
    
    /* Cookie Consent Dialog */
    .cookie-consent {
      position: fixed;
      bottom: 2rem;
      left: 50%;
      transform: translateX(-50%);
      width: 90%;
      max-width: 600px;
      background: var(--white);
      padding: 1.5rem;
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow-lg);
      z-index: 1000;
      display: none;
    }
    
    .cookie-consent.show {
      display: block;
      animation: fadeIn 0.3s ease;
    }
    
    .cookie-consent p {
      margin-bottom: 1rem;
      color: var(--text-color);
    }
    
    .cookie-buttons {
      display: flex;
      gap: 1rem;
      justify-content: flex-end;
    }
    
    .cookie-btn {
      padding: 0.5rem 1rem;
      border-radius: var(--radius);
      cursor: pointer;
      font-weight: 500;
      transition: all 0.3s ease;
    }
    
    .cookie-accept {
      background: var(--primary-color);
      color: var(--white);
      border: none;
    }
    
    .cookie-accept:hover {
      background: var(--primary-dark);
    }
    
    .cookie-reject {
      background: transparent;
      color: var(--primary-color);
      border: 1px solid var(--primary-color);
    }
    
    .cookie-reject:hover {
      background: var(--background-color);
    }
    
    @keyframes fadeIn {
      from { opacity: 0; transform: translateX(-50%) translateY(20px); }
      to { opacity: 1; transform: translateX(-50%) translateY(0); }
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

    .auth-page {
      background-color: var(--background-color);
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

    .profile-dropdown {
      position: relative;
      display: inline-block;
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

    .profile-icon-button:hover .profile-icon {
      transform: scale(1.1);
      background: var(--primary-color);
      color: var(--white);
    }

    .dropdown-content {
      display: none;
      position: absolute;
      right: 0;
      background-color: var(--white);
      min-width: 180px;
      box-shadow: var(--shadow-lg);
      border-radius: var(--radius);
      z-index: 1000;
      margin-top: 0.5rem;
      border: 1px solid var(--border-color);
      padding: 0.5rem 0;
    }

    .profile-dropdown:hover .dropdown-content {
      display: block;
    }

    .dropdown-item {
      display: flex;
      align-items: center;
      gap: 0.75rem;
      padding: 0.75rem 1rem;
      text-decoration: none;
      color: var(--text-color);
      transition: all 0.3s ease;
      font-size: 0.9rem;
      width: 100%;
      background: none;
      border: none;
      cursor: pointer;
      text-align: left;
    }

    .dropdown-item:hover {
      background-color: var(--background-color);
      color: var(--primary-color);
    }

    /* Main Content Styles */
    main {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 2rem;
    }

    .auth-container {
      width: 100%;
      max-width: 480px;
      margin: 2rem auto;
    }

    .auth-card {
      background: white;
      border-radius: 1rem;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      width: 100%;
      padding: 2.5rem;
      position: relative;
      overflow: hidden;
    }

    .auth-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 4px;
      background: linear-gradient(90deg, var(--primary-color), var(--primary-light));
    }

    .auth-header {
      text-align: center;
      margin-bottom: 2rem;
    }

    .auth-header h2 {
      color: var(--primary-color);
      font-size: 2rem;
      margin-bottom: 0.5rem;
    }

    .auth-header p {
      color: #666;
      font-size: 1rem;
    }

    .auth-form {
      display: flex;
      flex-direction: column;
      gap: 1.5rem;
    }

    .form-group {
      display: flex;
      flex-direction: column;
      gap: 0.5rem;
    }

    .form-group label {
      color: #444;
      font-weight: 500;
      font-size: 0.9rem;
    }

    .form-group input {
      width: 100%;
      padding: 0.75rem 1rem;
      border: 1px solid #ddd;
      border-radius: 0.5rem;
      font-size: 1rem;
      transition: all 0.3s ease;
    }

    .form-group input:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
      outline: none;
    }

    .form-group select {
      width: 100%;
      padding: 0.75rem 1rem;
      border: 1px solid #ddd;
      border-radius: 0.5rem;
      font-size: 1rem;
      transition: all 0.3s ease;
    }

    .form-group select:focus {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
      outline: none;
    }

    .form-options {
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    .checkbox-container {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      cursor: pointer;
    }

    .checkbox-container input[type="checkbox"] {
      width: 1.2rem;
      height: 1.2rem;
      border: 2px solid #ddd;
      border-radius: 0.25rem;
      cursor: pointer;
    }

    .checkbox-label {
      font-size: 0.9rem;
      color: #666;
    }

    .forgot-password {
      color: var(--primary-color);
      text-decoration: none;
      font-size: 0.9rem;
    }

    .forgot-password:hover {
      text-decoration: underline;
    }

    .auth-button {
      background: var(--primary-color);
      color: white;
      border: none;
      border-radius: 0.5rem;
      padding: 1rem;
      font-size: 1rem;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
      margin-top: 1rem;
    }

    .auth-button:hover {
      background: var(--primary-dark);
      transform: translateY(-1px);
    }

    .auth-redirect {
      text-align: center;
      margin-top: 1.5rem;
      color: #666;
      font-size: 0.9rem;
    }

    .auth-redirect a {
      color: var(--primary-color);
      text-decoration: none;
      font-weight: 500;
    }

    .auth-redirect a:hover {
      text-decoration: underline;
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

    .alert {
      padding: 1rem;
      margin-bottom: 1.5rem;
      border-radius: 0.5rem;
      font-size: 0.9rem;
    }

    .alert-danger {
      background-color: #fee2e2;
      border: 1px solid #fecaca;
      color: #b91c1c;
    }

    .alert-success {
      background-color: #dcfce7;
      border: 1px solid #bbf7d0;
      color: #15803d;
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

      .auth-container {
        padding: 1rem;
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
  <script>
    document.addEventListener('DOMContentLoaded', function() {
      if (!localStorage.getItem('cookieConsent')) {
        const cookieDialog = document.createElement('div');
        cookieDialog.className = 'cookie-consent';
        cookieDialog.innerHTML = `
          <p>We use cookies to enhance your experience on our website. By clicking "Accept", you agree to our use of cookies.</p>
          <div class="cookie-buttons">
            <button class="cookie-btn cookie-reject">Reject</button>
            <button class="cookie-btn cookie-accept">Accept</button>
          </div>
        `;
        document.body.appendChild(cookieDialog);
        setTimeout(() => cookieDialog.classList.add('show'), 100);
        
        cookieDialog.querySelector('.cookie-accept').addEventListener('click', function() {
          localStorage.setItem('cookieConsent', 'accepted');
          cookieDialog.classList.remove('show');
          setTimeout(() => cookieDialog.remove(), 300);
        });
        
        cookieDialog.querySelector('.cookie-reject').addEventListener('click', function() {
          localStorage.setItem('cookieConsent', 'rejected');
          cookieDialog.classList.remove('show');
          setTimeout(() => cookieDialog.remove(), 300);
        });
      }
    });
  </script>
</head>
<body class="auth-page">
  <header>
    <div class="logo-container">
      <img src="<%=request.getContextPath()%>/images/logo.png" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'80\' height=\'80\' viewBox=\'0 0 24 24\' fill=\'none\' stroke=\'%234f46e5\' stroke-width=\'2\' stroke-linecap=\'round\' stroke-linejoin=\'round\'><path d=\'M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z\'></path><polyline points=\'9 22 9 12 15 12 15 22\'></polyline></svg>'">
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
      <div class="profile-dropdown">
        <button class="profile-icon-button">
          <span class="profile-icon">👤</span>
        </button>
        <div class="dropdown-content">
          <a href="<%=request.getContextPath()%>/profile" class="dropdown-item">
            <span class="dropdown-icon">👤</span>
            My Profile
          </a>
          <a href="<%=request.getContextPath()%>/logout" class="dropdown-item">
            <span class="dropdown-icon">🚪</span>
            Sign Out
          </a>
        </div>
      </div>
    </div>
  </header>

  <main>
    <div class="auth-container">
      <div class="auth-card">
        <div class="auth-header">
          <h2>Welcome Back</h2>
          <p>Sign in to your account to continue</p>
        </div>
        
        <% if(request.getAttribute("errorMessage") != null) { %>
          <div class="alert alert-danger">
            <%= request.getAttribute("errorMessage") %>
          </div>
        <% } %>
        
        <% if(request.getAttribute("successMessage") != null) { %>
          <div class="alert alert-success">
            <%= request.getAttribute("successMessage") %>
          </div>
        <% } %>
        
        <form class="auth-form" action="<%= request.getContextPath() %>/login" method="post">
          <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required placeholder="Enter your username">
          </div>
          
          <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="Enter your password">
          </div>
          
          <div class="form-group">
            <label for="role">Login as:</label>
            <select id="role" name="role">
              <option value="user">User</option>
              <option value="admin">Administrator</option>
            </select>
          </div>
          
          <div class="form-options">
            <div class="checkbox-container">
              <input type="checkbox" id="remember" name="remember">
              <label for="remember" class="checkbox-label">Remember me</label>
            </div>
            <a href="<%=request.getContextPath()%>/forgot-password" class="forgot-password">Forgot password?</a>
          </div>

          <button type="submit" class="auth-button">Sign In</button>
          
          <div class="auth-redirect">
            Don't have an account? <a href="<%=request.getContextPath()%>/register">Sign up</a>
          </div>
          
<%--          <div class="auth-redirect" style="margin-top: 0.5rem;">--%>
<%--            <a href="<%=request.getContextPath()%>/admin/login" style="font-size: 0.8rem; color: #999;">Admin Login</a>--%>
<%--          </div>--%>
        </form>
      </div>
    </div>
  </main>

  <footer>
    <div class="footer-content">
      <div class="footer-logo">
        <img src="<%=request.getContextPath()%>/images/logo.png" alt="Home Again Logo" class="logo" onerror="this.onerror=null; this.src='data:image/svg+xml;charset=UTF-8,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'80\' height=\'80\' viewBox=\'0 0 24 24\' fill=\'none\' stroke=\'%234f46e5\' stroke-width=\'2\' stroke-linecap=\'round\' stroke-linejoin=\'round\'><path d=\'M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z\'></path><polyline points=\'9 22 9 12 15 12 15 22\'></polyline></svg>'">
      </div>
      <div class="footer-section">
        <h3>Site</h3>
        <p>Lost</p>
        <p>Report Lost</p>
        <p>Found</p>
        <p>Report Found</p>
      </div>
      <div class="footer-section">
        <h3>Help</h3>
        <p>Customer Support</p>
        <p>Terms & Conditions</p>
        <p>Privacy Policy</p>
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
      <p> 2024 Home again</p>
      <p>All Right Reserved</p>
    </div>
  </footer>
</body>
</html>