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

function Get-PowerBIVersion {
    $url = "https://www.microsoft.com/en-us/download/details.aspx?id=58494"
    try {
        $response = Invoke-WebRequest -Uri $url
        $html = $response.Content
        Write-Host "✅ Successfully fetched Power BI page."

        # Extract version from the specific HTML block
        $pattern = "<h3 class=['""]h6['""]>Version:</h3>\s*<p[^>]*>([\d\.]+)</p>"
        $match = [regex]::Match($html, $pattern)

        if ($match.Success) {
            return $match.Groups[1].Value
        } else {
            Write-Warning "⚠️ Could not extract Power BI version from HTML."
            return $null
        }
    } catch {
        Write-Error "❌ Failed to fetch Power BI version: $_"
        return $null
    }
}

function Get-7ZipVersion {
    $url = "https://www.7-zip.org/download.html"
    try {
        $response = Invoke-WebRequest -Uri $url
        $html = $response.Content
        Write-Host "✅ Successfully fetched 7-Zip page."

        # Regex to match: Download 7-Zip 24.05
        $pattern = "Download 7-Zip\s+(\d+\.\d+)"
        $match = [regex]::Match($html, $pattern)

        if ($match.Success) {
            return $match.Groups[1].Value
        } else {
            Write-Warning "⚠️ Could not extract 7-Zip version from HTML."
            return $null
        }
    } catch {
        Write-Error "❌ Failed to fetch 7-Zip page: $_"
        return $null
    }
}

# -------------- For Chrome, Adobe, VLC, Notepad++, putty,  we will use winget -------------- 
# winget search 



# -------------- Run Functions -----------------

$vlcVersion = Get-VLCVersion
if ($vlcVersion) {
    Write-Host "🔍 VLC Latest Version: $vlcVersion" -ForegroundColor Green
}

$notepadVersion = Get-NotepadPPVersion
if ($notepadVersion) {
    Write-Host "🔍 Notepad++ Latest Version: $notepadVersion" -ForegroundColor Green
}

$powerBIVersion = Get-PowerBIVersion
if ($powerBIVersion) {
    Write-Host "🔍 Power BI Desktop Latest Version: $powerBIVersion" -ForegroundColor Green
}

$zipVersion = Get-7ZipVersion
if ($zipVersion) {
    Write-Host "🔍 7-Zip Latest Version: $zipVersion" -ForegroundColor Green
}


## Need to decide if I'm going with scraping or choco. 

