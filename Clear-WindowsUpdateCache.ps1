##########
# Script to Clear the Windows Update Cache to free up diskspace
# Author: VirtualOx <info@virtualox.io>
# Version: v1.0.1, 2019-07-16
# Source: https://github.com/virtualox/Clear-WindowsUpdateCache
##########

function FreeDiskSpace() {
    $OS = Get-WMiobject -Class Win32_operatingsystem
    $Disk = Get-WMIObject Win32_Logicaldisk -filter "deviceid='$($os.systemdrive)'" |
    Select PSComputername,DeviceID,
    @{Name="FreeGB";Expression={[math]::Round($_.Freespace/1GB,2)}}
    return $Disk.FreeGB    
}

function CheckWUS() {
    $s = Get-Service wuauserv
    if ($s.Status -eq "Running") {
        return 0
    } else {
        return 1
    }
}
function StopWUS() {
     Stop-Service wuauserv -Force
}

function StartWUS() {
    Start-Service wuauserv
}

function WUSRunning() {
    Write-Host "Windows Update Service is Running..." -ForegroundColor Red
    Write-Host " Stopping Windows Update Service..." -ForegroundColor Blue

    # Stopping Windows Update Service and check again if it is stopped
    StopWUS
    if (CheckWUS) {
        WUSStopped
    } else {
        Write-Host "Can't stop Windows Update Service..." -ForegroundColor Red
        exit 1
    }
    Write-Host "Starting Windows Update Service..." -ForegroundColor Blue
    
    # Starting the Windows Update Service again
    StartWUS
}
function WUSStopped() {
    Write-Host "Windows Update Service is Stopped..." -ForegroundColor Green
    
    # Getting free disk space before the cleaning actions
    Write-Host " Free Disk Space before: " -ForegroundColor Blue -NoNewline
    $Before = FreeDiskSpace
    Write-Host "$Before GB"
    
    Write-Host " Cleaning Files..." -ForegroundColor Blue -NoNewline
    Get-ChildItem -LiteralPath $env:windir\SoftwareDistribution\Download\ -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    Write-Host "Done..." -ForegroundColor Green

    # Getting free disk space after the cleaning actions
    Write-Host " Free Disk Space after: " -ForegroundColor Blue -NoNewline
    $After = FreeDiskSpace
    Write-Host "$After GB"

    # Calculating the free disk space difference
    Write-Host " Cleaned: " -ForegroundColor Blue -NoNewline
    $Cleaned = $After - $Before
    Write-Host "$Cleaned GB"
}

# Program
if (CheckWUS) {
    WUSStopped
} else {
    WUSRunning
}
Write-Host "Done..." -ForegroundColor Green
exit 0
