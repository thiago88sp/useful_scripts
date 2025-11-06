# FortiWeb Marketplace Image ID Retrieval Tool

This script retrieves Oracle Cloud Infrastructure (OCI) marketplace image IDs for FortiWeb Web Application Firewall deployments.

**Created by:** Thiago Pontes - Cloud Solutions Architect

## Overview

The `getFortiWebImage` script automates the process of finding FortiWeb marketplace images in OCI. This is particularly useful for Infrastructure as Code deployments where you need to programmatically determine the correct image IDs for FortiWeb WAF instances.

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
./getFortiWebImage "Listing Name" "Version"
```

### Parameters

- **Listing Name** (required): The exact name of the FortiWeb marketplace listing
- **Version** (required): The FortiWeb version you want to find

### Examples

#### Example 1: FortiWeb WAF
```bash
./getFortiWebImage "Fortinet FortiWeb Web Application Firewall WAF" "7.4.2"
```

#### Example 2: Different Version
```bash
./getFortiWebImage "Fortinet FortiWeb Web Application Firewall WAF" "7.6.0"
```

### Making the Script Executable

If you encounter permission issues, make the script executable:
```bash
chmod +x getFortiWebImage
```

## Output

The script provides detailed information about the FortiWeb marketplace image:

```
====================================
FortiWeb Image Lookup Script
====================================
Product: Fortinet FortiWeb Web Application Firewall WAF
Version: 7.4.2
====================================
Searching for Listing ID for 'Fortinet FortiWeb Web Application Firewall WAF'...
✓ Listing ID found: ocid1.appcataloglisting.oc1...
Searching for image version '7.4.2'...
✓ Image version found: 7.4.2_paravirtualized_mode
Searching for Image ID for version '7.4.2_paravirtualized_mode'...
✓ Image ID found: ocid1.image.oc1...

====================================
FortiWeb RESULTS:
====================================
Product         : Fortinet FortiWeb Web Application Firewall WAF
Listing ID      : ocid1.appcataloglisting.oc1...
Image ID        : ocid1.image.oc1...
Image Version   : 7.4.2_paravirtualized_mode
====================================

📋 For Terraform usage:
mp_listing_id               = "ocid1.appcataloglisting.oc1..."
mp_listing_resource_version = "7.4.2_paravirtualized_mode"

✅ Script completed successfully!
```

## Key Information Provided

- **Listing ID**: The marketplace listing identifier
- **Image ID**: The actual image ID used for instance creation
- **Image Version**: The specific version string with mode information

## Use Cases

### Infrastructure as Code
Use the Image ID and Listing ID in your Terraform configurations:

```hcl
# Terraform example
resource "oci_core_instance" "fortiweb" {
  # ... other configuration
  source_details {
    source_type                     = "image"
    source_id                       = "ocid1.image.oc1..." # Use the Image ID from script output
    marketplace_source_listing_id   = "ocid1.appcataloglisting.oc1..." # Use the Listing ID
    marketplace_source_version      = "7.4.2_paravirtualized_mode" # Use the Image Version
  }
}
```

### Automation Scripts
Integrate into deployment automation to dynamically fetch the latest image IDs.

### Documentation
Generate documentation with current available image IDs for your team.

## Troubleshooting

### Common Issues

1. **"Error: Could not find listing-id"**
   - Verify the listing name is exactly correct (case-sensitive)
   - Check your OCI CLI configuration and permissions

2. **"Error: Version not found"**
   - Ensure the version number is correct
   - Check if the version is available in your region

3. **"Error: Required parameters not provided"**
   - Both listing name and version parameters are required

### Debug Mode
To see detailed OCI CLI output, you can modify the script to add `--debug` flag to the OCI commands.

## Supported FortiWeb Listings

Common FortiWeb marketplace listings include:
- `Fortinet FortiWeb Web Application Firewall WAF`

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
- [FortiWeb on OCI Documentation](https://docs.fortinet.com/product/fortiweb-public-cloud)
- [OCI Marketplace Documentation](https://docs.oracle.com/en-us/iaas/Content/Marketplace/Concepts/marketoverview.htm)