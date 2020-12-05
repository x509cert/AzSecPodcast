 Set-StrictMode -Version latest

 $PSDefaultParameterValues['Out-File:Encoding'] = 'ASCII'

if ($args.Count -ne 3) {
    "Usage: ConverTranscriptTo-Md VTTfile Episode GuestName"
    exit
}

$vtt = $args[0]
$episode = $args[1]
$guest = $args[2]

$md = "transcript$episode.md"

"Converting [$vtt] to [$md] with guest $guest.`nCorrect? (y/N)"
$yn = read-host
if ($yn.ToLower() -ne 'y') {
    exit;
}

$text = Get-Content "intro.txt"
$text += Get-Content $vtt
$text += Get-Content "outro.txt"


# remove various items

$text = $text -replace '<v |<\/v>|WEBVTT', ''
$text = $text -replace '>', ' '
$text = $text -replace '^\d.+\d$', ''
$text = $text -replace '^(\s*\r\n){2,}', '\r\n'

$names = "Michael Howard (CYBER SECURITY)", "Sarah Young", "Mark Simos", "Gladys Rodriguez", $guest
foreach ($name in $names) {
    $firstname = ($name -split " ")[0]
    $text = $text.Replace($name, ("**" + $firstname + "**:"))
}

$text | Out-File -Encoding Ascii $md 