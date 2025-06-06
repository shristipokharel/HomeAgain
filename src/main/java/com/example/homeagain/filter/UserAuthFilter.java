package com.example.homeagain.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter to protect user resources from unauthorized access.
 * This filter checks if the user is logged in before allowing access to user-specific pages.
 */
@WebFilter(urlPatterns = {"/dashboard", "/profile", "/items/*", "/categories/*", "/lost"})
public class UserAuthFilter implements Filter {

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
        
        // Check if user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        // Get the requested URL
        String requestURI = httpRequest.getRequestURI();
        
        // Allow access to unified login page
        if (requestURI.endsWith("/login")) {
            chain.doFilter(request, response);
            return;
        }
        // If not logged in, redirect to login page
        if (!isLoggedIn) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        } else {
            // User is logged in, allow access
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Cleanup code, if needed
    }
}