const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3002;

app.use(cors());
app.use(express.json());

// Mock analytics data
const pageViews = {
  'home': 1245,
  'blog': 873,
  'contact': 432
};

let apiCalls = 0;

// Middleware to count API calls
app.use((req, res, next) => {
  apiCalls++;
  next();
});

// Routes
app.get('/', (req, res) => {
  res.json({ message: 'Analytics Service is running!' });
});

app.get('/api/analytics/page-views', (req, res) => {
  res.json(pageViews);
});

app.get('/api/analytics/api-calls', (req, res) => {
  res.json({ total: apiCalls });
});

app.post('/api/analytics/event', (req, res) => {
  const { event, data } = req.body;
  console.log(`Event tracked: ${event}`, data);
  res.status(201).json({ success: true });
});

app.listen(PORT, () => {
  console.log(`Analytics Service running on port ${PORT}`);
}); 