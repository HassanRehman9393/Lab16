# Kubernetes Microservices with Apache Reverse Proxy

This project demonstrates deploying and scaling microservices on Kubernetes with Apache as a reverse proxy and CI/CD integration.

## Architecture

- **Microservices**:
  - Blog API Service - Simple blog CRUD operations
  - Auth Service - Authentication and token management
  - Analytics Service - Track usage statistics

- **Apache Reverse Proxy** - Routes traffic to appropriate microservices
- **Kubernetes** - Orchestrates containers with autoscaling
- **CI/CD** - GitHub Actions workflow for automated deployment

## Prerequisites

- Docker and Docker Hub account
- Kubernetes cluster (Minikube, kind, or cloud provider)
- kubectl configured for your cluster
- GitHub account

## Local Development

### Build and run microservices locally

1. Clone the repository:
```bash
git clone <repository-url>
cd k8s-microservices-lab
```

2. Install dependencies and run each service:

```bash
# Blog API Service
cd services/blog-api
npm install
npm start

# Auth Service
cd ../auth-service
npm install
npm start

# Analytics Service
cd ../analytics-service
npm install
npm start
```

### Build and run with Docker Compose

1. Update the Docker username in the docker-compose.yml file
2. Run all services:

```bash
docker-compose up -d
```

## Kubernetes Deployment

### Manual Deployment

1. Update the Docker username in Kubernetes YAML files:
```bash
sed -i 's/${DOCKER_USERNAME}/your-docker-username/g' k8s/*.yaml
```

2. Apply Kubernetes configuration:
```bash
kubectl apply -f k8s/auth-secrets.yaml
kubectl apply -f k8s/blog-api-deployment.yaml
kubectl apply -f k8s/auth-service-deployment.yaml
kubectl apply -f k8s/analytics-service-deployment.yaml
kubectl apply -f k8s/apache-proxy-deployment.yaml
```

3. Verify deployment:
```bash
kubectl get deployments
kubectl get pods
kubectl get services
```

4. Access the application:
```bash
kubectl port-forward svc/apache-proxy-service 8080:80
```

Then open http://localhost:8080 in your browser.

### GitHub Actions Deployment

1. Add secrets to your GitHub repository:
   - DOCKER_USERNAME: Your Docker Hub username
   - DOCKER_PASSWORD: Your Docker Hub password
   - KUBE_CONFIG: Your Kubernetes config in Base64

2. Push to main branch to trigger the CI/CD pipeline.

## Testing the Services

After deployment, you can test the services using:

```bash
# Check if the proxy is working
curl http://localhost:8080/health

# Get blog posts
curl http://localhost:8080/api/blogs

# Login to auth service
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin123"}'

# Check analytics
curl http://localhost:8080/api/analytics/page-views
```

## License

This project is licensed under the MIT License. 