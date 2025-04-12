# SystemHealthCheck.ps1
# A PowerShell script to check system health for CPU, memory, disk, services, and event logs
# Created by [Your Name] to demonstrate PowerShell learning for tech support tasks

# Set output file path
$outputFile = "C:\Temp\SystemHealthReport_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

# Ensure C:\Temp exists
if (-not (Test-Path -Path "C:\Temp")) {
    try {
        New-Item -ItemType Directory -Path "C:\Temp" -ErrorAction Stop | Out-Null
    } catch {
        Write-Host "Failed to create C:\Temp: $($_.Exception.Message)" -ForegroundColor Red
        exit
    }
}

# Initialize report
$global:report = "Matt checked your system. Here's what he found: - $(Get-Date)`n"
$global:report += "=====================================`n"

# Function to append to report and display
function Write-Report {
    param($Message)
    Write-Host $Message
    $global:report += "$Message`n"
}

try {
    # CPU Usage
    $cpuUsage = (Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average
    if ($null -eq $cpuUsage) { throw "Failed to retrieve CPU usage" }
    Write-Report "CPU Usage: $cpuUsage%"
    if ($cpuUsage -gt 80) {
        Write-Report "Warning: High CPU usage detected!"
    }

    # Memory Usage
    $os = Get-CimInstance Win32_OperatingSystem
    if ($null -eq $os) { throw "Failed to retrieve memory data" }
    $totalMem = $os.TotalVisibleMemorySize / 1MB
    $freeMem = $os.FreePhysicalMemory / 1MB
    $usedMemPercent = [math]::Round((($totalMem - $freeMem) / $totalMem) * 100, 2)
    Write-Report "Memory Usage: $usedMemPercent% ($freeMem GB free of $totalMem GB)"
    if ($usedMemPercent -gt 85) {
        Write-Report "Warning: Low memory available!"
    }

    # Disk Space for multiple drives
$drives = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | Where-Object { $_.DeviceID -in @('C:', 'D:') }
if ($null -eq $drives) { throw "Failed to retrieve disk data" }
$validDriveCount = 0
foreach ($disk in $drives) {
    $freeSpace = [math]::Round($disk.FreeSpace / 1GB, 2)
    $totalSpace = [math]::Round($disk.Size / 1GB, 2)
    if ($totalSpace -eq 0) { continue } # Skip if drive is invalid
    $validDriveCount++
    $freePercent = [math]::Round(($freeSpace / $totalSpace) * 100, 2)
    Write-Report "$($disk.DeviceID) Drive: $freePercent% free ($freeSpace GB of $totalSpace GB)"
    if ($freePercent -lt 20) {
        Write-Report "Warning: Low disk space on $($disk.DeviceID) drive!"
    }
}
if ($validDriveCount -eq 1) {
    Write-Report "The C: drive is the only drive present."
}

    # Recent Errors from Event Log
    $errors = Get-EventLog -LogName System -EntryType Error -Newest 5 -After (Get-Date).AddHours(-24) -ErrorAction Stop
    Write-Report "Recent System Errors (Last 24 Hours):"
    if ($errors) {
        foreach ($error in $errors) {
            Write-Report " - $($error.TimeGenerated): $($error.Message)"
        }
    } else {
        Write-Report "No errors found."
    }
}
catch {
    $errorMessage = "Error occurred: $($_.Exception.Message)"
    Write-Report $errorMessage
    Write-Host $errorMessage -ForegroundColor Red
}

# Save report to file
try {
    $global:report | Out-File -FilePath $outputFile -Force -ErrorAction Stop
    Write-Host "`nReport saved to $outputFile
    
    "
}
catch {
    Write-Host "Failed to save report to $outputFile. Error: $($_.Exception.Message)" -ForegroundColor Red

}