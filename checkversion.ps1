########################################
# Powershell Script to Check Latest App Versions.
# Checking SCCM and web versions.
########################################

function Get-VLCVersion {
    $url = "https://www.videolan.org/vlc/download-windows.html"
    try {
        $response = Invoke-WebRequest -Uri $url
        $html = $response.Content
        $pattern = "<span id=['""]downloadVersion['""]>\s*([\d\.]+)\s*</span>"
        $match = [regex]::Match($html, $pattern)
        if ($match.Success) {
            return $match.Groups[1].Value
        } else {
            Write-Warning "⚠️ VLC version not found."
            return $null
        }
    } catch {
        Write-Error "❌ Failed to get VLC version: $_"
        return $null
    }
}

function Get-NotepadPPVersion {
    $url = "https://notepad-plus-plus.org/"
    try {
        $response = Invoke-WebRequest -Uri $url
        $html = $response.Content

        # Match text like: <strong>Current Version 8.8.1</strong>
        $pattern = "Current Version (\d+\.\d+\.\d+)"
        $match = [regex]::Match($html, $pattern)
        if ($match.Success) {
            return $match.Groups[1].Value
        } else {
            Write-Warning "⚠️ Notepad++ version not found in HTML."
            return $null
        }
    } catch {
        Write-Error "❌ Failed to fetch Notepad++ page: $_"
        return $null
    }
}


# -------------- Run Functions -----------------

$vlcVersion = Get-VLCVersion
if ($vlcVersion) {
    Write-Host "🔍 VLC Latest Version: $vlcVersion" -ForegroundColor Green
}

$notepadVersion = Get-NotepadPPVersion
if ($notepadVersion) {
    Write-Host "🔍 Notepad++ Latest Version: $notepadVersion" -ForegroundColor Green
}