const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Sample blog data
const blogs = [
  { id: 1, title: 'Kubernetes Basics', content: 'Introduction to K8s concepts' },
  { id: 2, title: 'Microservices Architecture', content: 'Building scalable systems with microservices' }
];

// Routes
app.get('/', (req, res) => {
  res.json({ message: 'Blog API Service is running!' });
});

app.get('/api/blogs', (req, res) => {
  res.json(blogs);
});

app.get('/api/blogs/:id', (req, res) => {
  const blog = blogs.find(b => b.id === parseInt(req.params.id));
  if (!blog) return res.status(404).json({ message: 'Blog not found' });
  res.json(blog);
});

app.post('/api/blogs', (req, res) => {
  const { title, content } = req.body;
  const newBlog = {
    id: blogs.length + 1,
    title,
    content
  };
  blogs.push(newBlog);
  res.status(201).json(newBlog);
});

app.listen(PORT, () => {
  console.log(`Blog API Service running on port ${PORT}`);
}); 