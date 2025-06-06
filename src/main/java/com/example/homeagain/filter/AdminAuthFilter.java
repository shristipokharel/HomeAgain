package com.example.homeagain.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter to protect admin resources from unauthorized access.
 * This filter checks if the user has admin privileges before allowing access to admin pages.
 */
@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code, if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Get the current session (don't create a new one if none exists)
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is logged in as admin
        boolean isLoggedInAsAdmin = (session != null && session.getAttribute("admin") != null);
        
        // Get the requested URL
        String requestURI = httpRequest.getRequestURI();
        
        // Allow access to unified login page
        if (requestURI.endsWith("/login")) {
            chain.doFilter(request, response);
            return;
        }
        
        // If not logged in as admin, redirect to unified login page
        if (!isLoggedInAsAdmin) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        } else {
            // User is logged in as admin, allow access
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Cleanup code, if needed
    }
}