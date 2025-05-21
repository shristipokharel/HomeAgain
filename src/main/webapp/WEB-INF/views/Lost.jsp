<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lost Items - HomeAgain</title>
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
          --warning: #ef4444;
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

        /* Main Content Styles */
        main.container {
          width: 100%;
          max-width: 1200px;
          margin: 2rem auto;
          padding: 0 2rem;
        }

        .page-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 1.5rem;
        }

        .page-header h1 {
          font-size: 2.5rem;
          font-weight: 700;
          color: var(--primary-color);
          margin: 0;
        }

        .report-button {
          background-color: var(--primary-color);
          color: white;
          border: none;
          border-radius: var(--radius-full);
          padding: 0.7rem 1.5rem;
          font-size: 1rem;
          font-weight: 600;
          cursor: pointer;
          text-decoration: none;
          display: inline-flex;
          align-items: center;
          gap: 0.5rem;
          transition: all 0.3s ease;
        }

        .report-button:hover {
          background-color: var(--primary-dark);
          transform: translateY(-2px);
          box-shadow: var(--shadow);
        }

        /* Search Filters */
        .filters {
          display: flex;
          gap: 1rem;
          margin-bottom: 2rem;
        }

        .search-input {
          flex: 1;
          padding: 0.75rem 1.25rem;
          border: 1px solid var(--border-color);
          border-radius: var(--radius);
          font-size: 1rem;
          color: var(--text-color);
          background-color: var(--white);
          transition: all 0.3s ease;
          min-width: 200px;
        }

        .search-input:focus {
          outline: none;
          border-color: var(--primary-color);
          box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .select-filter {
          padding: 0.75rem 1.25rem;
          border: 1px solid var(--border-color);
          border-radius: var(--radius);
          font-size: 1rem;
          color: var(--text-color);
          background-color: var(--white);
          cursor: pointer;
          transition: all 0.3s ease;
          width: 180px;
        }

        .select-filter:focus {
          outline: none;
          border-color: var(--primary-color);
          box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        /* Items Grid */
        .items-grid {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
          gap: 2rem;
        }

        .item-card {
          background: var(--white);
          border-radius: var(--radius-lg);
          overflow: hidden;
          box-shadow: var(--shadow-sm);
          transition: all 0.3s ease;
          cursor: pointer;
          height: 100%;
          display: flex;
          flex-direction: column;
          position: relative;
        }

        .item-card:hover {
          transform: translateY(-5px);
          box-shadow: var(--shadow-lg);
        }

        .item-image {
          width: 100%;
          height: 200px;
          object-fit: cover;
          background-color: #f3f4f6;
        }

        .item-tag {
          position: absolute;
          top: 1rem;
          left: 1rem;
          background-color: var(--warning);
          color: white;
          font-size: 0.875rem;
          font-weight: 600;
          padding: 0.35rem 0.85rem;
          border-radius: var(--radius-full);
          box-shadow: var(--shadow-sm);
        }

        .item-content {
          padding: 1.5rem;
          display: flex;
          flex-direction: column;
          gap: 0.5rem;
          flex: 1;
        }

        .item-title {
          font-size: 1.25rem;
          font-weight: 700;
          color: var(--primary-color);
          margin: 0;
        }

        .item-meta {
          color: var(--text-light);
          font-size: 0.9rem;
        }

        .item-description {
          margin-top: 0.5rem;
          color: var(--text-color);
          font-size: 0.95rem;
          line-height: 1.5;
        }

        /* Item Details Modal */
        .item-modal {
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
            border-radius: var(--radius-lg);
            max-width: 600px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
        }

        .modal-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--text-color);
        }

        .close-modal {
            background: none;
            border: none;
            font-size: 1.5rem;
            color: var(--text-light);
            cursor: pointer;
            padding: 0.5rem;
            transition: color 0.3s ease;
        }

        .close-modal:hover {
            color: var(--text-color);
        }

        .modal-body {
            padding: 1.5rem;
        }

        .modal-image {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: var(--radius);
            margin-bottom: 1.5rem;
        }

        .modal-details {
            display: grid;
            gap: 1rem;
        }

        .detail-row {
            display: flex;
            gap: 1rem;
            align-items: flex-start;
        }

        .detail-label {
            font-weight: 600;
            color: var(--text-color);
            min-width: 100px;
        }

        .detail-value {
            color: var(--text-color);
            flex: 1;
        }

        .contact-button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: var(--radius);
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1.5rem;
            width: 100%;
            justify-content: center;
        }

        .contact-button:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .contact-button i {
            font-size: 1.1rem;
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

          .page-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 1rem;
          }

          .filters {
            flex-direction: column;
          }

          .items-grid {
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

          .modal-content {
            width: 95%;
            margin: 1rem;
          }

          .modal-image {
            height: 200px;
          }

          .detail-row {
            flex-direction: column;
            gap: 0.25rem;
          }

          .detail-label {
            min-width: auto;
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
            <a href="<%=request.getContextPath()%>/lost" class="active">Lost</a>
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

    <main class="container">
        <div class="page-header">
            <h1>Lost Items</h1>
            <a href="<%=request.getContextPath()%>/report-lost" class="report-button">+ Report Lost Item</a>
        </div>
        
        <div class="filters">
            <input type="text" class="search-input" placeholder="Search lost items...">
            <select class="select-filter">
                <option selected>All Categories</option>
                <option>Electronics</option>
                <option>Jewelry</option>
                <option>Documents</option>
                <option>Accessories</option>
                <option>Other</option>
            </select>
            <select class="select-filter">
                <option selected>Recent First</option>
                <option>Oldest First</option>
                <option>Alphabetical</option>
            </select>
        </div>
        
        <div class="items-grid">
            <!-- Dynamic Lost items loop -->
            <c:forEach items="${lostItems}" var="item">
                <div class="item-card" onclick="showItemDetails('${item.id}', '${item.title}', '${item.description}', '${item.location}', '${item.postedAt}', '${item.imageUrl}')">
                    <c:if test="${not empty item.categoryId}">
                        <div class="item-tag">
                            <c:choose>
                                <c:when test="${item.categoryId == 1}">Electronics</c:when>
                                <c:when test="${item.categoryId == 2}">Jewelry & Watches</c:when>
                                <c:when test="${item.categoryId == 3}">Documents & IDs</c:when>
                                <c:when test="${item.categoryId == 4}">Clothing & Accessories</c:when>
                                <c:when test="${item.categoryId == 5}">Bags & Luggage</c:when>
                                <c:when test="${item.categoryId == 6}">Keys</c:when>
                                <c:when test="${item.categoryId == 7}">Pets</c:when>
                                <c:otherwise>Other</c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                    <img src="${not empty item.imageUrl ? item.imageUrl : 'data:image/svg+xml;charset=UTF-8,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22200%22 height=%22200%22 viewBox=%220 0 24 24%22 fill=%22none%22 stroke=%22%23e2e8f0%22 stroke-width=%221%22 stroke-dasharray=%225,5%22%3E%3Crect x=%223%22 y=%223%22 width=%2218%22 height=%2218%22 rx=%222%22 ry=%222%22%3E%3C/rect%3E%3Ccircle cx=%228.5%22 cy=%228.5%22 r=%221.5%22%3E%3C/circle%3E%3Cpolyline points=%2221 15 16 10 5 21%22%3E%3C/polyline%3E%3C/svg%3E'}" 
                         alt="${item.title}" class="item-image">
                    <div class="item-content">
                        <h2 class="item-title">${item.title}</h2>
                        <div class="item-meta">Lost at ${item.location}</div>
                        <p class="item-description">${item.description}</p>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty lostItems}">
                <div style="grid-column: 1/-1; text-align: center; padding: 2rem;">
                    <p style="color: var(--text-light); font-size: 1.1rem;">No approved lost items at the moment.</p>
                </div>
            </c:if>
        </div>
    </main>

    <!-- Item Details Modal -->
    <div id="itemModal" class="item-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Item Details</h2>
                <button class="close-modal" onclick="hideItemDetails()">&times;</button>
            </div>
            <div class="modal-body">
                <img id="modalItemImage" src="" alt="Item Image" class="modal-image">
                <div class="modal-details">
                    <div class="detail-row">
                        <span class="detail-label">Item Name:</span>
                        <span class="detail-value" id="modalItemTitle"></span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Description:</span>
                        <span class="detail-value" id="modalItemDescription"></span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Location:</span>
                        <span class="detail-value" id="modalItemLocation"></span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Date Lost:</span>
                        <span class="detail-value" id="modalItemDate"></span>
                    </div>
                </div>
                <button class="contact-button" onclick="contactItemOwner()">
                    <i class="fas fa-phone"></i> Contact Item Owner
                </button>
            </div>
        </div>
    </div>

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
            <p>© Copyright 2025 Home Again. All rights reserved.</p>
        </div>
    </footer>

    <script>
        function showItemDetails(id, title, description, location, date, imageUrl) {
            const modal = document.getElementById('itemModal');
            const modalImage = document.getElementById('modalItemImage');
            const modalTitle = document.getElementById('modalItemTitle');
            const modalDescription = document.getElementById('modalItemDescription');
            const modalLocation = document.getElementById('modalItemLocation');
            const modalDate = document.getElementById('modalItemDate');

            // Set modal content
            modalImage.src = imageUrl || 'data:image/svg+xml;charset=UTF-8,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22200%22 height=%22200%22 viewBox=%220 0 24 24%22 fill=%22none%22 stroke=%22%23e2e8f0%22 stroke-width=%221%22 stroke-dasharray=%225,5%22%3E%3Crect x=%223%22 y=%223%22 width=%2218%22 height=%2218%22 rx=%222%22 ry=%222%22%3E%3C/rect%3E%3Ccircle cx=%228.5%22 cy=%228.5%22 r=%221.5%22%3E%3C/circle%3E%3Cpolyline points=%2221 15 16 10 5 21%22%3E%3C/polyline%3E%3C/svg%3E';
            modalTitle.textContent = title;
            modalDescription.textContent = description;
            modalLocation.textContent = location;
            modalDate.textContent = new Date(date).toLocaleDateString();

            // Show modal
            modal.style.display = 'flex';
        }

        function hideItemDetails() {
            const modal = document.getElementById('itemModal');
            modal.style.display = 'none';
        }

        function contactItemOwner() {
            // Here you can implement the contact functionality
            // For example, show a contact form or redirect to a contact page
            alert('Contact functionality will be implemented soon!');
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('itemModal');
            if (event.target == modal) {
                hideItemDetails();
            }
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

