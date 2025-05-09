﻿# PowerShell System Health Check

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

1. Save the script as `SystemHealthCheck.ps1` (e.g., download from this repository).
2. Open PowerShell and navigate to the script’s directory:                             
```cd path\to\script\directory```
3. **Bypass Execution Policy (if needed)**: If you see an error about the script not being digitally signed, use one of these options:
- **Option 1: Allow downloaded scripts for this session** (recommended for testing):

   ```Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force```
   ```.\SystemHealthCheck.ps1```

- **Option 2: Unblock the downloaded file**:

   ```Unblock-File -Path .\SystemHealthCheck.ps1```                                  
   ```.\SystemHealthCheck.ps1```

- **Option 3: Set policy to RemoteSigned** (requires admin, good for frequent scripting):
```Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force```
```.\SystemHealthCheck.ps1```

4. Check the console output and the report file in `C:\Temp` (created automatically if it doesn’t exist).

**Note**: The `Bypass` or `Unblock-File` options are safest for one-time runs. Use `RemoteSigned` for ongoing PowerShell work, as it allows local scripts but requires downloaded scripts to be signed. Run PowerShell as administrator if prompted for `Set-ExecutionPolicy`.

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
