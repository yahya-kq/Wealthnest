param(
    [int]$Port = 3000
)

$prefix = "http://localhost:$Port/"
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($prefix)

try {
    $listener.Start()
    Write-Host "WealthNest local server running at $prefix" -ForegroundColor Green
} catch {
    Write-Host "Failed to start listener: $_" -ForegroundColor Red
    exit 1
}

$baseDir = $PSScriptRoot

while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $rawUrl = $request.RawUrl
        $path = $rawUrl.Split('?')[0].TrimStart('/')

        if ([string]::IsNullOrWhiteSpace($path)) {
            $path = "index.html"
        }

        $localPath = Join-Path $baseDir $path

        if (-not (Test-Path $localPath -PathType Leaf)) {
            $localPath = Join-Path $baseDir "index.html"
        }

        if (Test-Path $localPath -PathType Leaf) {
            $bytes = [System.IO.File]::ReadAllBytes($localPath)
            
            $ext = [System.IO.Path]::GetExtension($localPath).ToLower()
            $contentType = "text/html; charset=utf-8"
            if ($ext -eq ".js") { $contentType = "application/javascript; charset=utf-8" }
            elseif ($ext -eq ".css") { $contentType = "text/css; charset=utf-8" }
            elseif ($ext -eq ".json") { $contentType = "application/json; charset=utf-8" }
            elseif ($ext -eq ".svg") { $contentType = "image/svg+xml" }
            elseif ($ext -eq ".png") { $contentType = "image/png" }

            $response.ContentType = $contentType
            $response.ContentLength64 = $bytes.Length
            $response.StatusCode = 200
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $response.StatusCode = 404
            $errBytes = [System.Text.Encoding]::UTF8.GetBytes("Not Found")
            $response.OutputStream.Write($errBytes, 0, $errBytes.Length)
        }

        $response.Close()
    } catch {
        # ignore client disconnects
    }
}
