$compress = @{
    Path = "./info.toml", "./src"
    CompressionLevel = "Fastest"
    DestinationPath = "./BetterCameraUnlocker.zip"
}
Compress-Archive @compress -Force

Move-Item -Path "./BetterCameraUnlocker.zip" -Destination "./BetterCameraUnlocker.op" -Force

Write-Host("✅ Done!")