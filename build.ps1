# Azure Security Podcast Build Script
# This script helps maintain the modernized website

Write-Host "Azure Security Podcast - Build & Optimization Script" -ForegroundColor Cyan
Write-Host "=" * 50

# Function to minify CSS (basic)
function Optimize-CSS {
    param($inputFile, $outputFile)
    
    $css = Get-Content $inputFile -Raw
    # Remove comments
    $css = $css -replace '/\*.*?\*/', ''
    # Remove extra whitespace
    $css = $css -replace '\s+', ' '
    # Remove unnecessary spaces around braces and semicolons
    $css = $css -replace '\s*{\s*', '{'
    $css = $css -replace '\s*}\s*', '}'
    $css = $css -replace '\s*;\s*', ';'
    
    $css | Out-File $outputFile -Encoding UTF8 -NoNewline
    
    $originalSize = (Get-Item $inputFile).Length
    $newSize = (Get-Item $outputFile).Length
    $savings = [math]::Round((($originalSize - $newSize) / $originalSize) * 100, 1)
    
    Write-Host "✓ Optimized CSS: $([math]::Round($originalSize/1KB,1))KB → $([math]::Round($newSize/1KB,1))KB ($savings% reduction)" -ForegroundColor Green
}

# Check if combined CSS needs updating
$cssFiles = @("css\default.css", "css\layout.css", "css\media-queries.css", "css\fonts.css")
$combinedFile = "css\combined.css"
$minifiedFile = "css\combined.min.css"

$needsUpdate = $false
if (-not (Test-Path $combinedFile)) {
    $needsUpdate = $true
} else {
    $combinedDate = (Get-Item $combinedFile).LastWriteTime
    foreach ($file in $cssFiles) {
        if ((Get-Item $file).LastWriteTime -gt $combinedDate) {
            $needsUpdate = $true
            break
        }
    }
}

if ($needsUpdate) {
    Write-Host "Combining CSS files..." -ForegroundColor Yellow
    $combined = $cssFiles | ForEach-Object { Get-Content $_ -Raw } | Join-String
    $combined | Out-File $combinedFile -Encoding UTF8
    Write-Host "✓ Created combined.css" -ForegroundColor Green
}

# Create minified version
Write-Host "Creating minified CSS..." -ForegroundColor Yellow
Optimize-CSS $combinedFile $minifiedFile

# Validate JSON files
Write-Host "Validating JSON files..." -ForegroundColor Yellow
try {
    $episodes = Get-Content "data\episodes.json" | ConvertFrom-Json
    Write-Host "✓ episodes.json is valid ($($episodes.episodes.Count) episodes)" -ForegroundColor Green
    
    $config = Get-Content "data\config.json" | ConvertFrom-Json
    Write-Host "✓ config.json is valid" -ForegroundColor Green
} catch {
    Write-Host "✗ JSON validation failed: $_" -ForegroundColor Red
}

# Report file sizes
Write-Host "`nFile Size Report:" -ForegroundColor Cyan
Write-Host "-" * 30

$sizeReport = @(
    @{ Name = "Combined CSS"; Path = $combinedFile },
    @{ Name = "Minified CSS"; Path = $minifiedFile },
    @{ Name = "Modern JS"; Path = "js\app.js" },
    @{ Name = "Episodes JSON"; Path = "data\episodes.json" },
    @{ Name = "Config JSON"; Path = "data\config.json" }
)

foreach ($item in $sizeReport) {
    if (Test-Path $item.Path) {
        $size = [math]::Round((Get-Item $item.Path).Length / 1KB, 1)
        Write-Host "$($item.Name): $($size)KB" -ForegroundColor White
    }
}

Write-Host "`n✓ Build complete! Use combined.min.css for production." -ForegroundColor Green