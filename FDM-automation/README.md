# FDM Automation Script

A PowerShell automation script designed to streamline file management for download workflows, particularly useful for downloading files to an SSD and automatically transferring them to an HDD for storage.

## Overview

This script automates the process of moving files or directories from a source location to a destination directory (`D:\Downloads`), making it ideal for scenarios where you want to:

- Download files quickly to an SSD for speed
- Automatically transfer completed downloads to an HDD for long-term storage
- Maintain organized file management with comprehensive logging

## Features

- **Smart Copy & Move**: Automatically detects whether the source is a file or directory and handles copying accordingly
- **File Integrity Verification**: Compares file sizes to ensure successful transfers
- **Comprehensive Logging**: Creates detailed logs with timestamps for all operations
- **Error Handling**: Provides clear error messages and exit codes for troubleshooting
- **Automatic Cleanup**: Removes the original file/directory after successful transfer

## Usage

### Basic Syntax
```powershell
.\fdm_automation.ps1 -sourcePath "C:\path\to\your\file"
```

### Examples

**Transfer a single file:**
```powershell
.\fdm_automation.ps1 -sourcePath "C:\FastDownloads\movie.mkv"
```

**Transfer a directory:**
```powershell
.\fdm_automation.ps1 -sourcePath "C:\FastDownloads\DocumentPack"
```

## Integration with Download Managers

This script works excellently with download managers like Free Download Manager (FDM) for automated workflows:

1. Configure your download manager to save files to a fast SSD location
2. Set up the download manager to execute this script upon completion
3. Files will be automatically moved to your HDD storage location

### FDM Integration Example
In Free Download Manager:
- Go to Options → Advanced → Post-download actions
- Add a custom command: `powershell.exe -ExecutionPolicy Bypass -File "F:\Automations\FDM-automation\fdm_automation.ps1" %path%`

## Configuration

### Default Settings
- **Destination Directory**: `D:\Downloads`
- **Log File**: `D:\Downloads\move_log.txt`

### Customization
To change the destination directory, edit the `$destinationDir` variable in the script:
```powershell
$destinationDir = "E:\MyHDD\Storage"  # Change to your preferred location
```

## Log File

The script creates a detailed log file at `D:\Downloads\move_log.txt` that includes:
- Timestamps for all operations
- Success/failure status
- File size verification results
- Error messages with specific details

## Error Codes

- **Exit Code 1**: Source path does not exist
- **Exit Code 2**: File size mismatch after copy (integrity check failed)
- **Exit Code 3**: Copy operation failed

## Requirements

- Windows PowerShell 5.1 or later
- Appropriate permissions to read from source and write to destination
- Sufficient disk space in the destination directory

## Benefits for SSD/HDD Workflows

1. **Speed Optimization**: Download to SSD for maximum speed
2. **Storage Optimization**: Automatically move to HDD for capacity
3. **Automation**: No manual intervention required
4. **Safety**: Integrity checks ensure data reliability
5. **Organization**: Centralized destination with logging

## Troubleshooting

- Check the log file for detailed error information
- Ensure the script has proper permissions for both source and destination
- Verify that the destination drive has sufficient free space
- For network paths, ensure they are accessible from the script execution context

## License

This script is provided as-is for automation purposes. Modify as needed for your specific use case.
