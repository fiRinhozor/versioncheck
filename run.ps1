# STEP 1: Fetch the HTML content from VLC website
<#$url = "https://www.videolan.org/vlc/download-windows.html"

try {
    $response = Invoke-WebRequest -Uri $url
    $html = $response.Content
    Write-Host "✅ Successfully fetched HTML content from VLC site."
} catch {
    Write-Error "❌ Failed to fetch the page: $_"
}


$pattern = "<span id=['""]downloadVersion['""]>\s*([\d\.]+)\s*</span>"

$match = [regex]::Match($html, $pattern)

if ($match.Success) {
    $version = $match.Groups[1].Value
    Write-Host "✅ Latest VLC version is: $version" -ForegroundColor Green
} else {
    Write-Warning "⚠️ Could not extract VLC version from HTML."
}#>

##VLC

<#function Get-NotepadPPVersion {
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

$notepadVersion = Get-NotepadPPVersion
if ($notepadVersion) {
    Write-Host "🔍 Notepad++ Latest Version: $notepadVersion" -ForegroundColor Green
}#>

#PowerBi without function for Invoking.
<#$url = "https://www.microsoft.com/en-us/download/details.aspx?id=58494"

try {
    $response = Invoke-WebRequest -Uri $url
    $html = $response.Content
    Write-Host "✅ Successfully fetched Power BI page."
} catch {
    Write-Error "❌ Failed to fetch Power BI page: $_"
    return
}

# STEP: Extract version using cleaned regex
$pattern = "<h3 class=['""]h6['""]>Version:</h3>\s*<p[^>]*>([\d\.]+)</p>"
$match = [regex]::Match($html, $pattern)

if ($match.Success) {
    $version = $match.Groups[1].Value
    Write-Host "🔍 Power BI Desktop Latest Version: $version" -ForegroundColor Green
} else {
    Write-Warning "⚠️ Could not extract Power BI version from HTML."
}#>

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

$powerBIVersion = Get-PowerBIVersion
if ($powerBIVersion) {
    Write-Host "🔍 Power BI Desktop Latest Version: $powerBIVersion" -ForegroundColor Green
}