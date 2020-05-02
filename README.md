# Purpose

This example shows how automate the deployment of a web application with authentication enabled for Azure Active Directory.

Run the `Authenticate.ps1` script to authenticate.

Since this example uses both Azure PowerShell and the Azure CLI, you will need to authenticate to both.

Once you are authenticated, run the `Deploy.ps1` script to create all the Azure resources.

Run`BuildAndRelease.ps1` to build the .NET Core Web App and Web Api applications and deploy to Azure.

The`BuildAndRelease.ps1` script will also configure the Azure API Management instance, created by the `Deploy.ps1` script, for `WebApplication2` Web Api.

The `WebApplication1ApiManagementConfiguration.json` file is the ARM template that configures the Azure API Management operations and policies for `WebApplication2`.
