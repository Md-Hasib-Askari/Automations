param(
    [string]$sourcePath
)

$destinationDir = "D:\Downloads"
$logFile = "D:\Downloads\move_log.txt"

function Write-Log {
    param($message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -FilePath $logFile -Append -Encoding UTF8
    Write-Output "$timestamp - $message"
}

if (-Not (Test-Path $sourcePath)) {
    Write-Log "ERROR: Source does not exist: $sourcePath"
    exit 1
}

if (-Not (Test-Path $destinationDir)) {
    New-Item -ItemType Directory -Path $destinationDir | Out-Null
    Write-Log "Created destination directory: $destinationDir"
}

$baseName = Split-Path $sourcePath -Leaf
$destinationPath = Join-Path $destinationDir $baseName

# Copy logic
if (Test-Path $sourcePath -PathType Container) {
    Write-Log "Detected directory. Copying: $sourcePath to $destinationPath"
    Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force
}
else {
    Write-Log "Detected file. Copying: $sourcePath to $destinationPath"
    Copy-Item -Path $sourcePath -Destination $destinationPath -Force
}

Start-Sleep -Seconds 1

# Verification
if (Test-Path $destinationPath) {
    Write-Log "Copy successful: $destinationPath"

    if (Test-Path $sourcePath -PathType Leaf) {
        $srcSize = (Get-Item $sourcePath).Length
        $dstSize = (Get-Item $destinationPath).Length

        if ($srcSize -ne $dstSize) {
            Write-Log "ERROR: File size mismatch! Source: $srcSize bytes, Destination: $dstSize bytes"
            exit 2
        }
    }

    # Delete original
    Remove-Item -Path $sourcePath -Recurse -Force
    Write-Log "Deleted original: $sourcePath"
}
else {
    Write-Log "ERROR: Copy failed for $sourcePath"
    exit 3
}
