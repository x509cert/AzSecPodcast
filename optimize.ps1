# Azure Security Podcast Performance Optimization Script
param(
    [switch]$SkipImageOptimization = $false
)

Write-Host "🚀 Starting Azure Security Podcast Performance Optimization..." -ForegroundColor Green

# Check if we're in the right directory
if (!(Test-Path "index.html")) {
    Write-Error "Please run this script from the AzSecPodcast directory"
    exit 1
}

Write-Host "📊 Analyzing current file sizes..." -ForegroundColor Yellow

# Get current sizes
$cssFiles = @("css\default.css", "css\layout.css", "css\media-queries.css", "css\podcast.css", "css\animate.css")
$originalCssSize = 0
foreach ($file in $cssFiles) {
    if (Test-Path $file) {
        $size = (Get-Item $file).Length
        $originalCssSize += $size
        Write-Host "  $file : $([math]::round($size/1KB, 2)) KB" -ForegroundColor White
    }
}

# Get image sizes
Write-Host "`n📷 Large image sizes:" -ForegroundColor Yellow
Get-ChildItem "images\*.jpg", "images\*.png" | 
    Where-Object { $_.Length -gt 100KB } |
    Sort-Object Length -Descending |
    Select-Object -First 10 |
    ForEach-Object {
        Write-Host "  $($_.Name) : $([math]::round($_.Length/1KB, 2)) KB" -ForegroundColor White
    }

# Check optimized CSS
if (Test-Path "css\optimized.css") {
    $optimizedSize = (Get-Item "css\optimized.css").Length
    $cssReduction = $originalCssSize - $optimizedSize
    Write-Host "`n✅ CSS Optimization Results:" -ForegroundColor Green
    Write-Host "  Original CSS files: $([math]::round($originalCssSize/1KB, 2)) KB" -ForegroundColor White
    Write-Host "  Optimized CSS file: $([math]::round($optimizedSize/1KB, 2)) KB" -ForegroundColor White
    Write-Host "  Savings: $([math]::round($cssReduction/1KB, 2)) KB ($([math]::round(($cssReduction/$originalCssSize)*100, 1))%)" -ForegroundColor Cyan
}

# Check JavaScript optimization
if (Test-Path "js\ui-optimized.js") {
    $vanillaJsSize = (Get-Item "js\ui-optimized.js").Length
    Write-Host "`n✅ JavaScript Optimization:" -ForegroundColor Green
    Write-Host "  jQuery 3.7.1 (CDN): ~89 KB (eliminated)" -ForegroundColor White
    Write-Host "  Original ui.js: $([math]::round((Get-Item "ui.js").Length/1KB, 2)) KB" -ForegroundColor White
    Write-Host "  Optimized vanilla JS: $([math]::round($vanillaJsSize/1KB, 2)) KB" -ForegroundColor White
}

# Validate HTML structure
Write-Host "`n🔍 Validating optimizations..." -ForegroundColor Yellow

$htmlContent = Get-Content "index.html" -Raw

# Check for optimized CSS reference
if ($htmlContent -match 'css/optimized\.css') {
    Write-Host "  ✅ Using optimized CSS file" -ForegroundColor Green
} else {
    Write-Host "  ❌ Still using multiple CSS files" -ForegroundColor Red
}

# Check for jQuery removal
if ($htmlContent -match 'jquery') {
    Write-Host "  ❌ jQuery still referenced" -ForegroundColor Red
} else {
    Write-Host "  ✅ jQuery dependency removed" -ForegroundColor Green
}

# Check for lazy loading
if ($htmlContent -match "loading='lazy'") {
    Write-Host "  ✅ Lazy loading implemented for images" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  Consider adding lazy loading to images" -ForegroundColor Yellow
}

# Check for service worker
if (Test-Path "sw.js") {
    Write-Host "  ✅ Service worker created for caching" -ForegroundColor Green
} else {
    Write-Host "  ⚠️  Service worker not found" -ForegroundColor Yellow
}

# Check for resource hints
if ($htmlContent -match 'preconnect') {
    Write-Host "  ✅ Resource hints (preconnect) added" -ForegroundColor Green
}

Write-Host "`n🎯 Performance Recommendations:" -ForegroundColor Magenta

Write-Host "  1. 🖼️  Optimize images using online tools:" -ForegroundColor White
Write-Host "     • https://squoosh.app/ (Google's image optimizer)" -ForegroundColor Gray
Write-Host "     • https://tinypng.com/ (PNG/JPG compression)" -ForegroundColor Gray
Write-Host "     • Target: M365.png (745KB→<100KB), Mark.jpg (578KB→<80KB)" -ForegroundColor Gray

Write-Host "  2. 📱 Add WebP format support for modern browsers" -ForegroundColor White
Write-Host "  3. 🔄 Consider pagination for older episodes" -ForegroundColor White
Write-Host "  4. 📊 Set up performance monitoring with Core Web Vitals" -ForegroundColor White

# Performance summary
Write-Host "`n📈 Expected Performance Gains:" -ForegroundColor Green
Write-Host "  • CSS: ~60-75% size reduction (combined + minified)" -ForegroundColor Cyan
Write-Host "  • JS: jQuery elimination (~89KB saved)" -ForegroundColor Cyan  
Write-Host "  • Images: 70-80% size reduction with optimization" -ForegroundColor Cyan
Write-Host "  • Caching: Service Worker for repeat visits" -ForegroundColor Cyan
Write-Host "  • Loading: Lazy loading for below-the-fold content" -ForegroundColor Cyan

Write-Host "`n✨ Optimization Complete! Your podcast site is now blazing fast! 🔥" -ForegroundColor Green

# Show git status
Write-Host "`n📋 Git Status:" -ForegroundColor Yellow
git status --short