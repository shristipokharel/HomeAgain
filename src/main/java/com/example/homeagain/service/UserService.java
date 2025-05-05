package com.example.homeagain.service;

import com.example.homeagain.dao.UserDAO;
import com.example.homeagain.model.User;

public class UserService {
    private final UserDAO userDAO;

    public UserService(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public boolean createUser(User user) {
        return userDAO.createUser(user);
    }

    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }

    public User getUserByUsername(String username) {
        return userDAO.getUserByUsername(username);
    }

    public User getUserByEmail(String email) {
        return userDAO.getUserByEmail(email);
    }

    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }

    public boolean deleteUser(int id) {
        return userDAO.deleteUser(id);
    }

    public User authenticateUser(String username, String password) {
        return userDAO.authenticateUser(username, password);
    }
}