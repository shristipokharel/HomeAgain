import React from 'react';
import {
  Container,
  Typography,
  Grid,
  Paper,
  Box,
} from '@mui/material';
import { useAuth } from '../contexts/AuthContext';

const Dashboard = () => {
  const { user } = useAuth();

  return (
    <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
      <Typography variant="h4" gutterBottom sx={{ fontWeight: 700, color: '#1976d2' }}>
        Welcome, {user?.username}!
      </Typography>

      <Grid container spacing={3}>
        <Grid item xs={12} md={6}>
          <Paper className="custom-card" sx={{ p: 3 }}>
            <Typography variant="h6" gutterBottom>
              Lost Items
            </Typography>
            <Typography variant="body1">
              View and manage your lost items.
            </Typography>
          </Paper>
        </Grid>

        <Grid item xs={12} md={6}>
          <Paper className="custom-card" sx={{ p: 3 }}>
            <Typography variant="h6" gutterBottom>
              Found Items
            </Typography>
            <Typography variant="body1">
              View and manage items you've found.
            </Typography>
          </Paper>
        </Grid>

        <Grid item xs={12}>
          <Paper className="custom-card" sx={{ p: 3 }}>
            <Typography variant="h6" gutterBottom>
              Recent Activity
            </Typography>
            <Typography variant="body1">
              No recent activity to display.
            </Typography>
          </Paper>
        </Grid>
      </Grid>
    </Container>
  );
};

export default Dashboard; 