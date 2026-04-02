<#
.SYNOPSIS
    Adds a new episode to the Azure Security Podcast.

.DESCRIPTION
    Prompts for episode details (number, date, title, guest, description,
    RSS ID, and links), then appends the episode to data\episodes.json
    and regenerates index.html.

.EXAMPLE
    .\New-Episode.ps1
#>

param(
    [switch]$Help
)

if ($Help) {
    Get-Help $MyInvocation.MyCommand.Path -Detailed
    return
}

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

# ── Prompt for episode metadata ─────────────────────────────────────
Write-Host ""
Write-Host "╔══════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   New Azure Security Podcast Episode     ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

$defaultNumber = ""
$numberInput = Read-Host "Episode number"
if (-not $numberInput) { Write-Host "Episode number is required." -ForegroundColor Red; return }
$episodeNumber = [int]$numberInput

$defaultDate = (Get-Date).ToString("MMMM d, yyyy", [System.Globalization.CultureInfo]::InvariantCulture)
# Add ordinal suffix
$day = (Get-Date).Day
$suffix = switch ($day) {
    {$_ -in 1,21,31} { "st" }
    {$_ -in 2,22}    { "nd" }
    {$_ -in 3,23}    { "rd" }
    default           { "th" }
}
$defaultDate = (Get-Date).ToString("MMMM ", [System.Globalization.CultureInfo]::InvariantCulture) + "$day$suffix, " + (Get-Date).ToString("yyyy")
$dateInput = Read-Host "Date [$defaultDate]"
$episodeDate = if ($dateInput) { $dateInput } else { $defaultDate }

$episodeTitle = Read-Host "Episode title"
if (-not $episodeTitle) { Write-Host "Title is required." -ForegroundColor Red; return }

# ── Hosts ────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "── Which hosts are on this episode? ──" -ForegroundColor Yellow
$allHosts = @(
    @{ Name = "Michael"; Default = "Y" },
    @{ Name = "Sarah";   Default = "Y" },
    @{ Name = "Mark";    Default = "Y" },
    @{ Name = "Gladys";  Default = "N" }
)
$selectedHosts = @()
foreach ($h in $allHosts) {
    $prompt = if ($h.Default -eq "Y") { "  $($h.Name)? (Y/n)" } else { "  $($h.Name)? (y/N)" }
    $yn = Read-Host $prompt
    if ($h.Default -eq "Y") {
        if ($yn -ne 'n' -and $yn -ne 'N') { $selectedHosts += $h.Name }
    } else {
        if ($yn -eq 'y' -or $yn -eq 'Y') { $selectedHosts += $h.Name }
    }
}

if ($selectedHosts.Count -eq 0) {
    Write-Host "At least one host is required." -ForegroundColor Red; return
}

# Format host names: "Michael", "Michael and Sarah", "Michael, Sarah and Mark"
if ($selectedHosts.Count -eq 1) {
    $hostString = $selectedHosts[0]
} else {
    $hostString = ($selectedHosts[0..($selectedHosts.Count - 2)] -join ", ") + " and " + $selectedHosts[-1]
}

# ── Guests (optional, one or more) ──────────────────────────────────
Write-Host ""
Write-Host "── Guests (blank name to finish) ──" -ForegroundColor Yellow
$guests = @()
while ($true) {
    $gName = Read-Host "Guest name (blank to finish)"
    if (-not $gName) { break }
    $defaultLinkedIn = "https://linkedin.com/in/"
    $gLinkedInInput = Read-Host "  LinkedIn URL for $gName [$defaultLinkedIn]"
    $gLinkedIn = if ($gLinkedInInput) { $gLinkedInInput } else { "" }
    if ($gLinkedIn -and -not $gLinkedIn.StartsWith("http")) {
        $gLinkedIn = "https://linkedin.com/in/$gLinkedIn"
    }
    # If they just hit enter on the default, skip it (empty means no LinkedIn)
    if ($gLinkedIn -eq "https://linkedin.com/in/") { $gLinkedIn = "" }
    $gTwitter  = Read-Host "  Twitter/X handle for $gName (without @, or blank)"
    $guests += @{ name = $gName; linkedin = $gLinkedIn; twitter = $gTwitter }
    Write-Host "  ✓ Added guest: $gName" -ForegroundColor Green
}

# ── Episode description ─────────────────────────────────────────────
Write-Host ""
if ($guests.Count -gt 0) {
    $guestNames = ($guests | ForEach-Object { $_.name })
    if ($guestNames.Count -eq 1) {
        $guestString = $guestNames[0]
    } else {
        $guestString = ($guestNames[0..($guestNames.Count - 2)] -join ", ") + " and " + $guestNames[-1]
    }
    Write-Host "Description will start with: In this episode $hostString talk with $guestString about..." -ForegroundColor DarkGray
} else {
    Write-Host "Description will start with: In this episode $hostString talk about..." -ForegroundColor DarkGray
}
$descriptionRest = Read-Host "...finish the sentence"
Write-Host "The news section will start with: 'We also discuss Azure Security news about...'" -ForegroundColor DarkGray
$newsDescription = Read-Host "...finish the sentence (or blank to skip)"

# ── RSS.com info ────────────────────────────────────────────────────
Write-Host ""
Write-Host "── RSS.com details ──" -ForegroundColor Yellow
$rssId = Read-Host "RSS.com episode ID (the number from the URL)"
# Default short name: first word of each significant title word, no spaces
$defaultShortName = ($episodeTitle -split '\s+' | Where-Object { $_.Length -gt 2 } | ForEach-Object { $_ -replace '[^a-zA-Z0-9]','' } | Select-Object -First 3) -join ''
if (-not $defaultShortName) { $defaultShortName = "Ep$episodeNumber" }
$rssShortNameInput = Read-Host "RSS.com short name [$defaultShortName]"
$rssShortName = if ($rssShortNameInput) { $rssShortNameInput } else { $defaultShortName }

# ── Links ───────────────────────────────────────────────────────────
Write-Host ""
Write-Host "── Links (enter one per line, blank line to finish) ──" -ForegroundColor Yellow
Write-Host "  Format: URL then text, separated by a space"
Write-Host "  Example: https://example.com/article Article Title Here"
Write-Host ""

$links = @()
while ($true) {
    $linkInput = Read-Host "Link (blank to finish)"
    if (-not $linkInput) { break }

    $spaceIdx = $linkInput.IndexOf(' ')
    if ($spaceIdx -gt 0) {
        $url  = $linkInput.Substring(0, $spaceIdx).Trim()
        $text = $linkInput.Substring($spaceIdx + 1).Trim()
    } else {
        $url  = $linkInput.Trim()
        $text = $url
    }
    $links += @{ url = $url; text = $text }
    Write-Host "  ✓ Added: $text" -ForegroundColor Green
}

# ── Build contentHtml ───────────────────────────────────────────────
$sb = [System.Text.StringBuilder]::new()

# Opening sentence with hosts + guests, social links inline after each name
if ($guests.Count -gt 0) {
    $guestLabel = if ($guests.Count -eq 1) { "guest" } else { "guests" }
    [void]$sb.Append("In this episode $hostString talk with $guestLabel ")

    for ($i = 0; $i -lt $guests.Count; $i++) {
        $g = $guests[$i]
        # Name
        [void]$sb.Append($g.name)
        # Social links in parens right after name
        $socials = @()
        if ($g.linkedin) {
            $socials += "<a target=`"_blank`" rel=`"noreferrer`" href='$($g.linkedin)'><i class=`"fa-brands fa-linkedin`"></i></a>"
        }
        if ($g.twitter) {
            $socials += "<a target=`"_blank`" rel=`"noreferrer`" href='https://twitter.com/$($g.twitter)'><i class=`"fa-brands fa-x-twitter`"></i></a>"
        }
        if ($socials.Count -gt 0) {
            [void]$sb.Append("&nbsp;(" + ($socials -join " ") + ")")
        }
        # Separator between guests
        if ($i -lt $guests.Count - 2) {
            [void]$sb.Append(", ")
        } elseif ($i -eq $guests.Count - 2) {
            [void]$sb.Append(" and ")
        }
    }
    [void]$sb.Append("`n                  about $descriptionRest")
} else {
    [void]$sb.Append("In this episode $hostString talk about $descriptionRest")
}

if ($newsDescription) {
    [void]$sb.Append("`n`n                  <br>`n                  We also discuss Azure Security news about $newsDescription")
}

[void]$sb.Append("`n`n                  <br><br>`n`n")

# Player embed
[void]$sb.Append("                  <iframe src=`"https://player.rss.com/azsecpodcast/${rssId}?theme=light`" class=`"podcast-player`" title=`"The Azure Security Podcast`" frameborder=`"0`"><a href=`"https://rss.com/podcasts/azsecpodcast/${rssId}/`">${rssShortName}</a></iframe>`n`n")

# Links section
[void]$sb.Append("                  <h5>Links</h5>`n")
[void]$sb.Append("                  <ul>`n")
[void]$sb.Append("                     <li><a target=`"_blank`" rel=`"noreferrer`" href='https://rss.com/podcasts/azsecpodcast/${rssId}/#transcript'>Transcript <i class=`"fa-solid fa-book`"></i></a></li>`n")

foreach ($link in $links) {
    [void]$sb.Append("                     <li><a target=`"_blank`" rel=`"noreferrer`" href=`"$($link.url)`">$($link.text)</a></li>`n")
}

[void]$sb.Append("                  </ul>")

$contentHtml = $sb.ToString()

# ── Write single-episode JSON file ──────────────────────────────────
$newEpisode = [PSCustomObject]@{
    number      = $episodeNumber
    date        = $episodeDate
    title       = $episodeTitle
    contentHtml = $contentHtml
}

$pad = if ($episodeNumber -ge 100) { '{0:D4}' -f $episodeNumber } else { '{0:D3}' -f $episodeNumber }
$outputFile = Join-Path $repoRoot "data\Episode$pad.json"

$newEpisode | ConvertTo-Json -Depth 10 | Set-Content $outputFile -Encoding utf8

Write-Host ""
Write-Host "════════════════════════════════════════════" -ForegroundColor Green
Write-Host "  Episode $episodeNumber - $episodeTitle" -ForegroundColor Green
Write-Host "  Saved to: $outputFile" -ForegroundColor Green
Write-Host "════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""

# ── Display the JSON ────────────────────────────────────────────────
Write-Host "── Generated JSON ──" -ForegroundColor Cyan
$newEpisode | ConvertTo-Json -Depth 10 | Write-Host
Write-Host ""

# ── Offer to add to episodes.json ────────────────────────────────────
$addToJson = Read-Host "Add this episode to episodes.json? (y/N)"
if ($addToJson -eq 'y' -or $addToJson -eq 'Y') {

    $jsonPath = Join-Path $repoRoot "data\episodes.json"
    $json = Get-Content $jsonPath -Raw -Encoding utf8 | ConvertFrom-Json
    $episodes = @($json.episodes)
    $updatedEpisodes = @($newEpisode) + $episodes
    [PSCustomObject]@{ episodes = $updatedEpisodes } | ConvertTo-Json -Depth 10 | Set-Content $jsonPath -Encoding utf8
    Remove-Item $outputFile
    Write-Host ""
    Write-Host "✓ Added to episodes.json (deleted $outputFile)" -ForegroundColor Green
} else {
    Write-Host "Skipped. You can add it later by merging $outputFile into episodes.json." -ForegroundColor Yellow
}
Write-Host ""
