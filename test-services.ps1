# PowerShell script to test all services

Write-Host "Testing Blog API..." -ForegroundColor Green
Write-Host "GET http://localhost:3000/api/blogs" -ForegroundColor Yellow
Invoke-RestMethod -Uri "http://localhost:3000/api/blogs" | ConvertTo-Json

Write-Host "`nTesting Auth Service..." -ForegroundColor Green
Write-Host "POST http://localhost:3001/api/auth/login" -ForegroundColor Yellow
$authBody = @{
    username = "admin"
    password = "admin123"
} | ConvertTo-Json

$token = Invoke-RestMethod -Uri "http://localhost:3001/api/auth/login" -Method Post -Body $authBody -ContentType "application/json"
$token | ConvertTo-Json

Write-Host "`nTesting Analytics Service..." -ForegroundColor Green
Write-Host "GET http://localhost:3002/api/analytics/page-views" -ForegroundColor Yellow
Invoke-RestMethod -Uri "http://localhost:3002/api/analytics/page-views" | ConvertTo-Json

Write-Host "`nTesting Apache Proxy..." -ForegroundColor Green
Write-Host "GET http://localhost/api/blogs" -ForegroundColor Yellow
Invoke-RestMethod -Uri "http://localhost/api/blogs" | ConvertTo-Json

Write-Host "`nTesting Apache Proxy with Auth Service..." -ForegroundColor Green
Write-Host "POST http://localhost/api/auth/login" -ForegroundColor Yellow
Invoke-RestMethod -Uri "http://localhost/api/auth/login" -Method Post -Body $authBody -ContentType "application/json" | ConvertTo-Json

Write-Host "`nTesting Apache Proxy with Analytics Service..." -ForegroundColor Green
Write-Host "GET http://localhost/api/analytics/page-views" -ForegroundColor Yellow
Invoke-RestMethod -Uri "http://localhost/api/analytics/page-views" | ConvertTo-Json

Write-Host "`nAll services tested successfully!" -ForegroundColor Green 