# Clear-WindowsUpdateCache
# Script to clear the Windows Update Cache to free up disk space

function Get-FreeDiskSpace {
    $OS = Get-WmiObject -Class Win32_OperatingSystem
    $Disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='$($os.SystemDrive)'" |
        Select @{Name="FreeGB";Expression={[math]::Round($_.FreeSpace / 1GB, 2)}}
    return $Disk.FreeGB
}

# Get initial free disk space
$Before = Get-FreeDiskSpace
Write-Host "Free Disk Space before: $Before GB" -ForegroundColor Blue

# Check Windows Update Service status
$WUService = Get-Service wuauserv

# Stop Windows Update Service if it's running
if ($WUService.Status -eq "Running") {
    Write-Host "Stopping Windows Update Service..." -ForegroundColor Blue
    $WUService | Stop-Service -Force
}

# Clean Windows Update Cache
Write-Host "Cleaning Windows Update Cache..." -ForegroundColor Blue
$UpdateCachePath = Join-Path $env:windir "SoftwareDistribution\Download"
Get-ChildItem -Path $UpdateCachePath -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

# Start Windows Update Service
Write-Host "Starting Windows Update Service..." -ForegroundColor Blue
$WUService | Start-Service

# Get final free disk space
$After = Get-FreeDiskSpace
Write-Host "Free Disk Space after: $After GB" -ForegroundColor Blue

# Calculate and display the freed disk space
$Cleaned = $After - $Before
Write-Host "Cleaned: $Cleaned GB" -ForegroundColor Green

Write-Host "Done..." -ForegroundColor Green
