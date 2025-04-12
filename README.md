# PowerShell System Health Check

## Overview
This PowerShell script performs a system health check on a Windows machine, gathering data on CPU, memory, disk space, critical services, and recent system errors. I created it to demonstrate my ability to learn PowerShell quickly for a Tier 2 tech support role.

## Features
- Checks CPU usage and flags high load (>80%).
- Reports memory usage and warns if low (<15% free).
- Monitors C: and D: drive space, alerting if free space is below 20%.
- Displays 'The C: drive is the only drive present' if no D: drive is found.
- Verifies the status of the Windows Update service.
- Retrieves the last 5 system errors from the Event Log (past 24 hours).
- Saves results to a timestamped text file in C:\Temp.

## How to Run
1. Save the script as SystemHealthCheck.ps1.
2. Open PowerShell and navigate to the script’s directory.
3. Run the script: .\SystemHealthCheck.ps1.
4. Check the console output and the report file in C:\Temp.

## Learning Process
I built this script in a few days with guidance from Grok (xAI) to learn PowerShell basics like cmdlets, variables, and file handling. It shows I can pick up new tools fast and apply them to tech support tasks.

## Customizations
- Added support for checking both C: and D: drives.
- Included a message to clarify when only the C: drive is present.

## Future Improvements
- Add checks for other services or drives.
- Email the report to an admin.
- Create a GUI for easier interaction.

## License
MIT License
