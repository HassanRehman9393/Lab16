# PowerShell script to build and run all containers

Write-Host "Building and running microservices containers..." -ForegroundColor Green

# Clean up any existing containers
Write-Host "Cleaning up existing containers..." -ForegroundColor Yellow
docker rm -f blog-api auth-service analytics-service apache-proxy 2>$null

# Create network if it doesn't exist
Write-Host "Creating network..." -ForegroundColor Yellow
docker network create microservices-network 2>$null

# Blog API Service
Write-Host "Building and running Blog API Service..." -ForegroundColor Yellow
Set-Location -Path .\services\blog-api
docker build -t blog-api:latest .
docker run -d --name blog-api --network microservices-network -p 3000:3000 blog-api:latest

# Auth Service
Write-Host "Building and running Auth Service..." -ForegroundColor Yellow
Set-Location -Path ..\auth-service
docker build -t auth-service:latest .
docker run -d --name auth-service --network microservices-network -p 3001:3001 -e JWT_SECRET=your-secret-key auth-service:latest

# Analytics Service
Write-Host "Building and running Analytics Service..." -ForegroundColor Yellow
Set-Location -Path ..\analytics-service
docker build -t analytics-service:latest .
docker run -d --name analytics-service --network microservices-network -p 3002:3002 analytics-service:latest

# Apache Proxy
Write-Host "Building and running Apache Proxy..." -ForegroundColor Yellow
Set-Location -Path ..\..\apache
docker build -t apache-proxy:latest .
docker run -d --name apache-proxy --network microservices-network -p 80:80 apache-proxy:latest

# Return to root directory
Set-Location -Path ..

# List running containers
Write-Host "Running containers:" -ForegroundColor Green
docker ps

Write-Host "Testing services..." -ForegroundColor Green
Write-Host "Blog API: http://localhost:3000/api/blogs"
Write-Host "Auth Service: http://localhost:3001/api/auth/login (POST)"
Write-Host "Analytics Service: http://localhost:3002/api/analytics/page-views"
Write-Host "Apache Proxy: http://localhost/api/blogs"

# Instructions to stop containers
Write-Host "`nTo stop all containers, run:" -ForegroundColor Cyan
Write-Host "docker stop blog-api auth-service analytics-service apache-proxy"
Write-Host "docker rm blog-api auth-service analytics-service apache-proxy"
Write-Host "docker network rm microservices-network" 