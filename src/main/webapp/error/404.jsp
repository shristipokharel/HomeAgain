<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>
    <div class="container">
        <div class="error-container">
            <div class="error-code error-code-404">404</div>
            <div class="error-message">Page Not Found</div>
            <p class="lead">The page you are looking for does not exist or has been moved.</p>
            <a href="<%= request.getContextPath() %>/login" class="btn btn-primary mt-4">Return to Login</a>
        </div>
    </div>
</body>
</html> 