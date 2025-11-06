# FortiAnalyzer Marketplace Image ID Retrieval Tool

This script retrieves Oracle Cloud Infrastructure (OCI) marketplace image IDs for FortiAnalyzer Centralized Logging/Reporting deployments.

**Created by:** Thiago Pontes - Cloud Solutions Architect

## Overview

The `getFortiAnalyzerImage` script automates the process of finding FortiAnalyzer marketplace images in OCI and validates their regional availability. This is particularly useful for Infrastructure as Code deployments where you need to programmatically determine the correct image IDs for FortiAnalyzer logging and reporting instances.

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
./getFortiAnalyzerImage "Listing Name" "Version"
```

### Parameters

- **Listing Name** (optional): The exact name of the FortiAnalyzer marketplace listing
  - Default: "FortiAnalyzer Centralized Logging/Reporting (BYOL)"
- **Version** (optional): The FortiAnalyzer version you want to find
  - Default: "7.2.1"

### Examples

#### Example 1: Using defaults
```bash
./getFortiAnalyzerImage
```

#### Example 2: Specifying version
```bash
./getFortiAnalyzerImage "FortiAnalyzer Centralized Logging/Reporting (BYOL)" "7.4.0"
```

#### Example 3: Different listing
```bash
./getFortiAnalyzerImage "FortiAnalyzer Centralized Logging/Reporting (BYOL)" "7.2.1"
```

### Making the Script Executable

If you encounter permission issues, make the script executable:
```bash
chmod +x getFortiAnalyzerImage
```

## Output

The script provides comprehensive information about the FortiAnalyzer marketplace image and regional availability:

```
====================================
FortiAnalyzer Image Lookup Script
====================================
Product: FortiAnalyzer Centralized Logging/Reporting (BYOL)
Version: 7.2.1
====================================
Searching for Listing ID for 'FortiAnalyzer Centralized Logging/Reporting (BYOL)'...
✓ Listing ID found: ocid1.appcataloglisting.oc1...
Searching for image version '7.2.1'...
✓ Image version found: 7.2.1_paravirtualized_mode
Searching for Image ID for version '7.2.1_paravirtualized_mode'...
✓ Image ID found: ocid1.image.oc1...

====================================
FortiAnalyzer RESULTS:
====================================
Product         : FortiAnalyzer Centralized Logging/Reporting (BYOL)
Listing ID      : ocid1.appcataloglisting.oc1...
Image ID        : ocid1.image.oc1...
Image Version   : 7.2.1_paravirtualized_mode
====================================

📋 For Terraform usage:
mp_listing_id               = "ocid1.appcataloglisting.oc1..."
mp_listing_resource_version = "7.2.1_paravirtualized_mode"

📋 To validate in OCI Console:
https://cloud.oracle.com/marketplace/application/ocid1.appcataloglisting.oc1...?region=sa-bogota-1

🔍 Validating availability in current region...
Current region: sa-bogota-1

🌎 Checking regional availability...
Available regions:
  ✅ sa-bogota-1 (Bogotá - Target region)
  📍 us-ashburn-1
  📍 us-phoenix-1
  📍 eu-frankfurt-1

✅ CONFIRMED: Image is available in sa-bogota-1 (Bogotá)

✅ Script completed successfully!
```

## Key Information Provided

- **Listing ID**: The marketplace listing identifier
- **Image ID**: The actual image ID used for instance creation
- **Image Version**: The specific version string with mode information
- **Regional Availability**: List of regions where the image is available
- **Terraform Configuration**: Ready-to-use Terraform parameters
- **Console URL**: Direct link to validate in OCI Console

## Use Cases

### Infrastructure as Code
Use the Image ID and Listing ID in your Terraform configurations:

```hcl
# Terraform example
resource "oci_core_instance" "fortianalyzer" {
  # ... other configuration
  source_details {
    source_type                     = "image"
    source_id                       = "ocid1.image.oc1..." # Use the Image ID from script output
    marketplace_source_listing_id   = "ocid1.appcataloglisting.oc1..." # Use the Listing ID
    marketplace_source_version      = "7.2.1_paravirtualized_mode" # Use the Image Version
  }
}
```

### Regional Deployment Planning
The script validates image availability across regions, helping you plan multi-region deployments.

### Automation Scripts
Integrate into deployment automation to dynamically fetch the latest image IDs and validate regional availability.

## Troubleshooting

### Common Issues

1. **"Error: Could not find listing-id"**
   - Verify the listing name is exactly correct (case-sensitive)
   - Check your OCI CLI configuration and permissions
   - The script will list available Fortinet products to help you find the correct name

2. **"Error: Version not found"**
   - Ensure the version number is correct
   - The script will display available versions if the specified version is not found

3. **"WARNING: Image NOT available in target region"**
   - The image exists but is not available in your target region
   - Consider using a different region or check if the image will be available soon

### Debug Mode
To see detailed OCI CLI output, you can modify the script to add `--debug` flag to the OCI commands.

## Supported FortiAnalyzer Listings

Common FortiAnalyzer marketplace listings include:
- `FortiAnalyzer Centralized Logging/Reporting (BYOL)`

## Special Features

### Regional Validation
This script includes advanced regional validation that:
- Detects your current OCI region
- Checks image availability across all regions
- Provides specific validation for South American regions
- Highlights target regions for easy identification

### Error Handling
The script provides helpful error messages and suggestions:
- Lists available Fortinet products if listing name is incorrect
- Shows available versions if the specified version is not found
- Validates each step of the lookup process

## Contributing

Feel free to submit issues or pull requests to improve this script. Common improvements could include:
- Adding support for other Fortinet products
- Output formatting options (JSON, CSV)
- Enhanced regional filtering
- Batch processing multiple versions

## License

This script is provided as-is for educational and operational purposes. Please ensure compliance with your organization's policies and Oracle Cloud Infrastructure terms of service.

## Additional Resources

- [OCI CLI Documentation](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm)
- [FortiAnalyzer on OCI Documentation](https://docs.fortinet.com/product/fortianalyzer-public-cloud)
- [OCI Marketplace Documentation](https://docs.oracle.com/en-us/iaas/Content/Marketplace/Concepts/marketoverview.htm)