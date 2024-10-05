# Accessing and Downloading SharePoint Files via Python and Microsoft Graph API

In the modern workplace, integrating Microsoft SharePoint with Python applications enables automated management and access to documents, folders, and other resources programmatically. This tutorial outlines the creation and the use of the SharePointClient class to interact with SharePoint through the Microsoft Graph API.

The tutorial will guide you through application registration in Azure, implementing the Python class, and setting necessary permissions. Finally, the complete source code will be shared on GitHub.
Prerequisites

Before we begin, make sure you have:

    Python installed on your machine.
    Access to a Microsoft SharePoint site.
    Installed the requests library in Python, available via pip (pip install requests).

Step 1: Register Your Application

To interact with SharePoint via the Microsoft Graph API, you need to register your application in Azure Active Directory (Azure AD). This provides the necessary tenant_id, client_id, and client_secret.
How to Register:

    Sign into the Azure Portal: Navigate to Azure Portal and log in.
    Access Azure Active Directory: Select Azure Active Directory from the sidebar.
    Register a new application: Go to “App registrations” and click “New registration”. Provide a name, choose the account types, and set a redirect URI if needed (Not needed for this article).
    Obtain IDs and Secrets: Post-registration, note the provided Client ID and Tenant ID. Create a new client secret under “Certificates & secrets”.

Step 2: Configure Permissions

Set the correct permissions in Azure AD to allow your application to read files and sites.
Setting Permissions:

    API permissions: On your app’s registration page, click “API permissions”.
    Add permissions: Select “Add a permission”, choose “Microsoft Graph” then “Application permissions”.
    Add specific permissions: Find and add Files.Read.All and Sites.Read.All to enable file and site reading capabilities.
    Grant admin consent: To activate the permissions, click “Grant admin consent for [Your Organization]”.

Step 3: Setting Up the SharePointClient Class

Implement the SharePointClient class which includes authentication and methods to interact with SharePoint data. Below is the class integrated into a script:
Conclusion

The SharePointClient class provides a streamlined way to interact with SharePoint resources through Python. This solution is ideal for automating document management tasks, enhancing productivity across your organization. Check out the full source code on GitHub.

Keep your credentials secure and adhere to best practices for managing sensitive information. Enjoy automating with Python and SharePoint!
