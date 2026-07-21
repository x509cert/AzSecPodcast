<#
.SYNOPSIS
    Adds a new episode to the Azure Security Podcast.

.DESCRIPTION
    Prompts for episode details (number, date, title, guest, description,
    RSS ID, and links), then can prepend the episode to data\episodes.json.
    The script also refreshes data\episodes-index.json and data\EpisodeNNN.json
    files used by the site for lazy-loading episode content.

    Pass the optional edit argument to add one news link to an existing
    episode in data\episodes.json, or sync to regenerate episode data and
    share-link pages.

.EXAMPLE
    .\New-Episode.ps1

.EXAMPLE
    .\New-Episode.ps1 edit

.EXAMPLE
    .\New-Episode.ps1 sync
#>

param(
    [ValidateSet("edit", "sync")]
    [string]$Mode,

    [switch]$Help
)

if ($Help) {
    Get-Help $MyInvocation.MyCommand.Path -Detailed
    return
}

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

function Read-RequiredValue {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Prompt,

        [string]$DefaultValue
    )

    $displayPrompt = if ($DefaultValue) { "$Prompt [$DefaultValue]" } else { $Prompt }
    $value = Read-Host $displayPrompt
    if (-not $value -and $DefaultValue) { return $DefaultValue }
    if (-not $value) {
        Write-Host "$Prompt is required." -ForegroundColor Red
        return $null
    }
    return $value
}

function ConvertTo-HtmlAttributeValue {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Value
    )

    return [System.Net.WebUtility]::HtmlEncode($Value)
}

function Get-EpisodeFileName {
    param(
        [Parameter(Mandatory = $true)]
        [int]$EpisodeNumber
    )

    $pad = if ($EpisodeNumber -ge 100) { '{0:D4}' -f $EpisodeNumber } else { '{0:D3}' -f $EpisodeNumber }
    return "Episode$pad.json"
}

function Write-EpisodeLinkPage {
    param(
        [Parameter(Mandatory = $true)]
        [object]$Episode
    )

    $episodeNumber = [int]$Episode.number
    $episodeFileName = Get-EpisodeFileName -EpisodeNumber $episodeNumber
    $pageFileName = [System.IO.Path]::ChangeExtension($episodeFileName, ".html")
    $pageDirectory = Join-Path $repoRoot "episodes"
    $pagePath = Join-Path $pageDirectory $pageFileName
    $pad = if ($episodeNumber -ge 100) { '{0:D4}' -f $episodeNumber } else { '{0:D3}' -f $episodeNumber }
    $anchorId = "ep$pad"
    $episodeTitle = [System.Net.WebUtility]::HtmlEncode([string]$Episode.title)
    $episodeDate = [System.Net.WebUtility]::HtmlEncode([string]$Episode.date)
    $episodeContent = [string]$Episode.contentHtml
    $pageTitle = "The Azure Security Podcast - $episodeTitle"
    $episodeUrl = "https://azsecuritypodcast.net/episodes/$pageFileName"
    $homepageUrl = "../#$anchorId"

    if (-not (Test-Path $pageDirectory)) {
        New-Item -ItemType Directory -Path $pageDirectory | Out-Null
    }

    $pageHtml = @"
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>$pageTitle</title>
   <meta name="description" content="Episode $episodeNumber of The Azure Security Podcast: $episodeTitle">
   <meta property="og:title" content="$pageTitle">
   <meta property="og:description" content="Episode $episodeNumber of The Azure Security Podcast.">
   <meta property="og:type" content="website">
   <meta property="og:url" content="$episodeUrl">
   <meta property="og:image" content="https://azsecuritypodcast.net/images/logo2.png">
   <meta name="twitter:card" content="summary">
   <meta name="twitter:site" content="@AzureSecPod">
   <meta name="twitter:title" content="$pageTitle">
   <meta name="twitter:description" content="Episode $episodeNumber of The Azure Security Podcast.">
   <meta name="twitter:image" content="https://azsecuritypodcast.net/images/logo2.png">
   <link rel="canonical" href="$episodeUrl">
   <link rel="preconnect" href="https://cdnjs.cloudflare.com" crossorigin>
   <link rel="preconnect" href="https://player.rss.com" crossorigin>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css" crossorigin>
   <link rel="stylesheet" href="../css/styles.css?v=4">
   <link rel="shortcut icon" href="../images/favicon-aznew.ico">
</head>
<body>
   <section id="hero">
      <div class="row">
         <div class="twelve columns">
            <div class="hero-text">
               <h1><a href="../">The Azure Security Podcast</a></h1>
            </div>
         </div>
      </div>
   </section>
   <main>
      <section id="features">
         <article>
            <div class="row add-bottom">
               <div class="nine columns offset-2">
                  <h3 class="Heading">
                     <span style="font-weight:bold">Episode $episodeNumber</span> - $episodeDate - [$episodeTitle]
                     <a href="$homepageUrl" title="View this episode on the podcast homepage"><i class="fa-solid fa-link" style="font-size: 0.8em; color: #666;"></i></a>
                  </h3>
                  <div class="EpisodeContent">
$episodeContent
                  </div>
               </div>
            </div>
         </article>
      </section>
   </main>
</body>
</html>
"@

    Set-Content $pagePath -Value $pageHtml -Encoding utf8
}

function Sync-EpisodeDataFiles {
    $dataPath = Join-Path $repoRoot "data"
    $jsonPath = Join-Path $dataPath "episodes.json"
    $indexPath = Join-Path $dataPath "episodes-index.json"
    $json = Get-Content $jsonPath -Raw -Encoding utf8 | ConvertFrom-Json
    $episodes = @($json.episodes)

    $indexEpisodes = foreach ($episode in $episodes) {
        $episodeNumber = [int]$episode.number
        $episodeFileName = Get-EpisodeFileName -EpisodeNumber $episodeNumber
        $episode | ConvertTo-Json -Depth 10 | Set-Content (Join-Path $dataPath $episodeFileName) -Encoding utf8
        Write-EpisodeLinkPage -Episode $episode

        [PSCustomObject]@{
            number = $episodeNumber
            date   = $episode.date
            title  = $episode.title
            file   = $episodeFileName
        }
    }

    [PSCustomObject]@{ episodes = @($indexEpisodes) } | ConvertTo-Json -Depth 10 | Set-Content $indexPath -Encoding utf8
}

function Add-NewsItemToEpisodesJson {
    $jsonPath = Join-Path $repoRoot "data\episodes.json"
    $json = Get-Content $jsonPath -Raw -Encoding utf8 | ConvertFrom-Json
    $episodes = @($json.episodes)

    if ($episodes.Count -eq 0) {
        Write-Host "No episodes found in $jsonPath." -ForegroundColor Red
        return
    }

    Write-Host ""
    Write-Host "╔══════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║       Add Azure Security News Item       ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    $defaultEpisodeNumber = [string]$episodes[0].number
    $episodeNumberInput = Read-RequiredValue -Prompt "Episode number" -DefaultValue $defaultEpisodeNumber
    if (-not $episodeNumberInput) { return }
    $episodeNumber = [int]$episodeNumberInput

    $episodeIndex = -1
    for ($i = 0; $i -lt $episodes.Count; $i++) {
        if ([int]$episodes[$i].number -eq $episodeNumber) {
            $episodeIndex = $i
            break
        }
    }

    if ($episodeIndex -lt 0) {
        Write-Host "Episode $episodeNumber was not found in $jsonPath." -ForegroundColor Red
        return
    }

    $episode = $episodes[$episodeIndex]
    Write-Host "Adding news item to episode $($episode.number): $($episode.title)" -ForegroundColor Yellow
    Write-Host ""

    $url = Read-RequiredValue -Prompt "News item URL"
    if (-not $url) { return }
    $url = $url.Trim()
    if (-not $url) {
        Write-Host "News item URL is required." -ForegroundColor Red
        return
    }
    $title = Read-Host "News item title [$url]"
    if (-not $title) { $title = $url }
    $title = $title.Trim()
    if (-not $title) { $title = $url }

    $encodedUrl = ConvertTo-HtmlAttributeValue -Value $url
    $encodedTitle = [System.Net.WebUtility]::HtmlEncode($title)
    $newListItem = "                     <li><a target=`"_blank`" rel=`"noreferrer`" href=`"$encodedUrl`">$encodedTitle</a></li>"

    $contentHtml = [string]$episode.contentHtml
    $closingListMatches = [System.Text.RegularExpressions.Regex]::Matches($contentHtml, "(?im)^[ \t]*</ul>")
    if ($closingListMatches.Count -eq 0) {
        Write-Host "Episode $episodeNumber does not contain a Links list ending with </ul>." -ForegroundColor Red
        return
    }
    $closingListIndex = $closingListMatches[$closingListMatches.Count - 1].Index

    $lineBreak = if ($contentHtml.Contains("`r`n")) { "`r`n" } else { "`n" }
    $updatedContentHtml = $contentHtml.Insert($closingListIndex, "$newListItem$lineBreak")
    $episodes[$episodeIndex].contentHtml = $updatedContentHtml

    [PSCustomObject]@{ episodes = $episodes } | ConvertTo-Json -Depth 10 | Set-Content $jsonPath -Encoding utf8
    Sync-EpisodeDataFiles

    Write-Host ""
    Write-Host "✓ Added news item to data\episodes.json and refreshed lazy-load data files" -ForegroundColor Green
}

if ($Mode -eq "sync") {
    Sync-EpisodeDataFiles
    Write-Host "Refreshed lazy-load data files and episode share-link pages." -ForegroundColor Green
    return
}

if ($Mode -eq "edit") {
    Add-NewsItemToEpisodesJson
    return
}

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
    $guestNames = @($guests | ForEach-Object { $_.name })
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
[void]$sb.Append("                  <iframe loading=`"lazy`" src=`"https://player.rss.com/azsecpodcast/${rssId}?theme=light`" class=`"podcast-player`" title=`"The Azure Security Podcast`" frameborder=`"0`"><a href=`"https://rss.com/podcasts/azsecpodcast/${rssId}/`">${rssShortName}</a></iframe>`n`n")

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

$outputFile = Join-Path $repoRoot ("data\" + (Get-EpisodeFileName -EpisodeNumber $episodeNumber))

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
    Sync-EpisodeDataFiles
    Write-Host ""
    Write-Host "✓ Added to episodes.json and refreshed lazy-load data files" -ForegroundColor Green
} else {
    Write-Host "Skipped. You can add it later by merging $outputFile into episodes.json." -ForegroundColor Yellow
}
Write-Host ""
