package com.example.homeagain.service;

import com.example.homeagain.dao.AdminDAO;
import com.example.homeagain.model.Admin;

public class AdminService {
    private final AdminDAO adminDAO;

    public AdminService(AdminDAO adminDAO) {
        this.adminDAO = adminDAO;
    }

    public boolean createAdmin(Admin admin) {
        return adminDAO.createAdmin(admin);
    }

    public Admin getAdminById(int id) {
        return adminDAO.getAdminById(id);
    }

    public Admin getAdminByUsername(String username) {
        return adminDAO.getAdminByUsername(username);
    }


    public boolean updateAdmin(Admin admin) {
        return adminDAO.updateAdmin(admin);
    }

    public boolean deleteAdmin(int id) {
        return adminDAO.deleteAdmin(id);
    }

    public Admin authenticateAdmin(String username, String password) {
        return adminDAO.authenticateAdmin(username, password);
    }
    
}