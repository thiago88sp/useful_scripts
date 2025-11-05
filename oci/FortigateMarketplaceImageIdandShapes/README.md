# FortiGate Marketplace Image ID and Shapes Retrieval Tool

This script retrieves Oracle Cloud Infrastructure (OCI) marketplace image IDs and their compatible compute shapes for FortiGate Next-Generation Firewall deployments.

**Created by:** Thiago Pontes - Cloud Solutions Architect

## Overview

The `getMarketplaceImageIdandShapes` script automates the process of finding FortiGate marketplace images in OCI and determining which compute shapes are compatible with those images. This is particularly useful for Infrastructure as Code deployments where you need to programmatically determine the correct image IDs and supported instance shapes.

## Prerequisites

Before using this script, ensure you have:

1. **OCI CLI installed and configured**
   - Install the OCI CLI following the [official documentation](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm)
   - Configure authentication using `oci setup config`

2. **Proper OCI permissions**
   - Read access to Compute services
   - Access to Marketplace listings

3. **Bash shell environment**
   - The script is written for bash and should work on Linux, macOS, and Windows with WSL

## Usage

### Basic Syntax
```bash
./getMarketplaceImageIdandShapes "Listing Name" "Version"
```

### Parameters

- **Listing Name** (required): The exact name of the FortiGate marketplace listing
- **Version** (required): The FortiGate version you want to find

### Examples

#### Example 1: FortiGate BYOL
```bash
./getMarketplaceImageIdandShapes "FortiGate Next-Gen Firewall (BYOL)" "7.6.0"
```

#### Example 2: FortiGate PAYG
```bash
./getMarketplaceImageIdandShapes "FortiGate Next-Gen Firewall (PAYG)" "7.4.3"
```

### Making the Script Executable

If you encounter permission issues, make the script executable:
```bash
chmod +x getMarketplaceImageIdandShapes
```

## Output

The script provides detailed information for both ARM64 and X64 architectures (when available):

```
-----------------------------------------
Listing ID (ARM64): ocid1.appcataloglisting.oc1...
Source ID (ARM64): ocid1.image.oc1...
Listing Resource Version (ARM64): 7.6.0_ARM64_paravirtualized_mode
Compatible Shapes (ARM64):
VM.Standard.A1.Flex
VM.Standard.Ampere.Generic
-----------------------------------------
Listing ID (X64): ocid1.appcataloglisting.oc1...
Source ID (X64): ocid1.image.oc1...
Listing Resource Version (X64): 7.6.0_X64_paravirtualized_mode
Compatible Shapes (X64):
VM.Standard2.1
VM.Standard2.2
VM.Standard2.4
VM.Standard2.8
VM.Standard3.Flex
VM.Standard.E3.Flex
VM.Standard.E4.Flex
-----------------------------------------
```

## Key Information Provided

- **Listing ID**: The marketplace listing identifier
- **Source ID**: The actual image ID used for instance creation
- **Listing Resource Version**: The specific version string including architecture
- **Compatible Shapes**: List of all compute shapes that support this image

## Use Cases

### Infrastructure as Code
Use the Source ID in your Terraform, Ansible, or other IaC tools:

```hcl
# Terraform example
resource "oci_core_instance" "fortigate" {
  # ... other configuration
  source_details {
    source_type = "image"
    source_id   = "ocid1.image.oc1.iad.aaaaaaaa..." # Use the Source ID from script output
  }
  shape = "VM.Standard2.4" # Use one of the compatible shapes
}
```

### Automation Scripts
Integrate into deployment automation to dynamically fetch the latest image IDs.

### Documentation
Generate documentation with current available shapes and image IDs for your team.

## Troubleshooting

### Common Issues

1. **"Error: Could not fetch listing ID"**
   - Verify the listing name is exactly correct (case-sensitive)
   - Check your OCI CLI configuration and permissions

2. **"Error: Could not find version"**
   - Ensure the version number is correct
   - Check if the version is available in your region

3. **"Error: Version argument is missing"**
   - Both listing name and version parameters are required

### Debug Mode
To see detailed OCI CLI output, you can modify the script to add `--debug` flag to the OCI commands.

## Supported FortiGate Listings

Common FortiGate marketplace listings include:
- `FortiGate Next-Gen Firewall (BYOL)`
- `FortiGate Next-Gen Firewall (PAYG)`
- `FortiGate Next-Gen Firewall (PAYG) - AMD`

## Contributing

Feel free to submit issues or pull requests to improve this script. Common improvements could include:
- Adding support for other Fortinet products
- Output formatting options (JSON, CSV)
- Region-specific queries
- Batch processing multiple versions

## License

This script is provided as-is for educational and operational purposes. Please ensure compliance with your organization's policies and Oracle Cloud Infrastructure terms of service.

## Additional Resources

- [OCI CLI Documentation](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm)
- [FortiGate on OCI Documentation](https://docs.fortinet.com/product/fortigate-public-cloud)
- [OCI Compute Shapes Documentation](https://docs.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm)