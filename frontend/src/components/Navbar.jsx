import React from 'react';
import {
  AppBar,
  Toolbar,
  Typography,
  Button,
  Box,
  Container,
} from '@mui/material';
import { Link as RouterLink, useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';

const Navbar = () => {
  const { user, logout } = useAuth();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <AppBar position="static" className="custom-navbar">
      <Container maxWidth="lg">
        <Toolbar disableGutters>
          <Typography
            variant="h6"
            component={RouterLink}
            to="/"
            sx={{
              flexGrow: 1,
              textDecoration: 'none',
              color: 'inherit',
              fontWeight: 700,
            }}
          >
            HomeAgain
          </Typography>

          <Box sx={{ display: 'flex', gap: 2 }}>
            {user ? (
              <>
                <Button
                  color="inherit"
                  component={RouterLink}
                  to="/dashboard"
                >
                  Dashboard
                </Button>
                <Button
                  color="inherit"
                  component={RouterLink}
                  to="/lost-items"
                >
                  Lost Items
                </Button>
                <Button
                  color="inherit"
                  component={RouterLink}
                  to="/found-items"
                >
                  Found Items
                </Button>
                <Button
                  color="inherit"
                  component={RouterLink}
                  to="/contact"
                >
                  Contact
                </Button>
                <Button
                  color="inherit"
                  onClick={handleLogout}
                  className="custom-button"
                >
                  Logout
                </Button>
              </>
            ) : (
              <>
                <Button
                  color="inherit"
                  component={RouterLink}
                  to="/login"
                  className="custom-button"
                >
                  Login
                </Button>
                <Button
                  color="inherit"
                  component={RouterLink}
                  to="/register"
                  className="custom-button"
                >
                  Register
                </Button>
              </>
            )}
          </Box>
        </Toolbar>
      </Container>
    </AppBar>
  );
};

export default Navbar; 