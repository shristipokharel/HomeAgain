import React from 'react';
import { Container, Typography, Paper } from '@mui/material';

const FoundItems = () => {
  return (
    <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
      <Typography variant="h4" gutterBottom sx={{ fontWeight: 700, color: '#1976d2' }}>
        Found Items
      </Typography>
      <Paper className="custom-card" sx={{ p: 3 }}>
        <Typography variant="body1">
          Found items functionality coming soon...
        </Typography>
      </Paper>
    </Container>
  );
};

export default FoundItems; 