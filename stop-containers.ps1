# PowerShell script to stop and remove all containers

Write-Host "Stopping and removing containers..." -ForegroundColor Yellow
docker stop blog-api auth-service analytics-service apache-proxy
docker rm blog-api auth-service analytics-service apache-proxy

Write-Host "Removing network..." -ForegroundColor Yellow
docker network rm microservices-network

Write-Host "Done!" -ForegroundColor Green 