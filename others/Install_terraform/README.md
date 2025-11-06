# Terraform Installation Script for Windows

This PowerShell script automates the installation of Terraform on Windows systems.

**Created by:** Thiago Pontes - Cloud Solutions Architect

## Overview

The `Install-Terraform.ps1` script provides a quick and automated way to install Terraform on Windows machines. It downloads the official Terraform binary from HashiCorp, extracts it to a designated folder, and configures the system PATH for easy command-line access.

## Prerequisites

Before running this script, ensure you have:

1. **Windows PowerShell** (version 3.0 or later)
   - Available on Windows 7/Server 2008 R2 and newer
   - Or PowerShell Core 6+ on any supported platform

2. **Administrator privileges**
   - Required to modify system PATH environment variable
   - Right-click PowerShell and select "Run as Administrator"

3. **Internet connectivity**
   - The script downloads Terraform directly from HashiCorp's official releases

4. **Execution policy**
   - PowerShell execution policy must allow script execution
   - Run: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

## Usage

### Method 1: Direct Execution
```powershell
# Run as Administrator
.\Install-Terraform.ps1
```

### Method 2: Download and Execute
```powershell
# Download and run directly
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/thiago88sp/useful_scripts/main/others/Install_terraform/Install-Terraform.ps1" -OutFile "Install-Terraform.ps1"
.\Install-Terraform.ps1
```

### Method 3: One-liner (Advanced)
```powershell
# Download and execute in memory (run as Administrator)
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/thiago88sp/useful_scripts/main/others/Install_terraform/Install-Terraform.ps1'))
```

## What the Script Does

### 1. **Downloads Terraform**
- Fetches Terraform v1.13.5 (Windows AMD64) from HashiCorp's official releases
- Downloads to temporary directory (`$env:TEMP`)

### 2. **Creates Installation Directory**
- Creates `C:\Terraform` directory if it doesn't exist
- Uses a dedicated folder for clean organization

### 3. **Extracts Binary**
- Extracts the `terraform.exe` from the downloaded ZIP file
- Places it in the installation directory

### 4. **Updates System PATH**
- Adds `C:\Terraform` to the system PATH environment variable
- Checks for existing entries to avoid duplicates
- Modifies machine-level PATH (affects all users)

### 5. **Cleanup**
- Removes the temporary ZIP file
- Leaves system clean after installation

## Installation Output

```
==== Terraform Installer for Windows ====
Downloading Terraform 1.13.5...
Creating installation directory at C:\Terraform
Extracting Terraform...
Adding Terraform to system PATH...
Terraform installation completed successfully!
Close and reopen PowerShell, then run: terraform --version
```

## Post-Installation

### Verify Installation
After running the script:

1. **Close and reopen PowerShell/Command Prompt**
2. **Verify Terraform is installed:**
   ```powershell
   terraform --version
   ```
   Expected output:
   ```
   Terraform v1.13.5
   on windows_amd64
   ```

### First Steps with Terraform
```powershell
# Check available commands
terraform help

# Initialize a new Terraform configuration
terraform init

# Validate configuration
terraform validate

# Plan infrastructure changes
terraform plan

# Apply infrastructure changes
terraform apply
```

## Configuration

### Customizing Installation

You can modify the script variables before execution:

```powershell
# Change Terraform version
$terraformVersion = "1.14.0"  # Update to desired version

# Change installation path
$installPath = "C:\Tools\Terraform"  # Custom installation directory
```

### Installing Different Versions

To install a different version, modify the `$terraformVersion` variable:

```powershell
# For Terraform 1.14.0
$terraformVersion = "1.14.0"
$downloadUrl = "https://releases.hashicorp.com/terraform/$terraformVersion/terraform_${terraformVersion}_windows_amd64.zip"
```

## Troubleshooting

### Common Issues

1. **"Execution Policy Error"**
   ```
   Solution: Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

2. **"Access Denied" when modifying PATH**
   ```
   Solution: Run PowerShell as Administrator
   ```

3. **"terraform command not found" after installation**
   ```
   Solution: Close and reopen PowerShell/Command Prompt to refresh PATH
   ```

4. **Download fails**
   ```
   Solution: Check internet connectivity and firewall settings
   ```

### Manual Verification

Check if Terraform was installed correctly:

```powershell
# Check if file exists
Test-Path "C:\Terraform\terraform.exe"

# Check PATH variable
$env:PATH -split ';' | Select-String "Terraform"

# Test command
& "C:\Terraform\terraform.exe" --version
```

### Uninstallation

To remove Terraform installed by this script:

```powershell
# Remove installation directory
Remove-Item "C:\Terraform" -Recurse -Force

# Remove from PATH (manual)
# 1. Open System Properties > Environment Variables
# 2. Edit System PATH variable
# 3. Remove "C:\Terraform" entry
```

## Security Considerations

- **Run as Administrator**: Required for system PATH modification
- **Execution Policy**: Script requires appropriate PowerShell execution policy
- **Source Verification**: Downloads from official HashiCorp releases
- **HTTPS**: Uses secure HTTPS connection for downloads

## Use Cases

### Infrastructure as Code Teams
- Quick setup for new team members
- Standardized Terraform version across team
- Automated workstation configuration

### CI/CD Pipelines
- Automated agent setup
- Consistent build environments
- Infrastructure deployment automation

### Development Environments
- Quick local development setup
- Multiple environment configuration
- Cross-team standardization

## Supported Platforms

- **Windows 10/11** (x64)
- **Windows Server 2016/2019/2022** (x64)
- **PowerShell 3.0+**
- **PowerShell Core 6+**

## Version History

- **v1.0**: Initial release with Terraform 1.13.5 support

## Contributing

Feel free to submit issues or pull requests to improve this script. Common improvements could include:
- Support for different architectures (ARM64)
- Version selection parameter
- Silent installation mode
- Chocolatey integration
- Automatic updates

## License

This script is provided as-is for educational and operational purposes. Please ensure compliance with your organization's policies and HashiCorp's terms of service.

## Additional Resources

- [Terraform Official Documentation](https://www.terraform.io/docs)
- [Terraform Download Page](https://www.terraform.io/downloads)
- [HashiCorp Learn - Terraform](https://learn.hashicorp.com/terraform)
- [Terraform Registry](https://registry.terraform.io/)

## Related Scripts

This script is part of a collection of Infrastructure as Code tools:
- FortiGate OCI Image Scripts
- FortiAnalyzer OCI Image Scripts
- FortiWeb OCI Image Scripts