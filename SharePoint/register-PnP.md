Yes, starting in 2023, with the broader transition to **Microsoft Entra ID** (formerly known as Azure AD), registration is now required for both **Power Apps** and **PnP PowerShell**. This is part of a move toward unified identity management across Microsoft services.

### **Entra ID Registration for PnP PowerShell**
When using **PnP PowerShell** (the PowerShell module that works with SharePoint Online and other Microsoft 365 services), you now need to register an application with **Microsoft Entra ID** to authenticate and manage permissions for your scripts. Here's what you need to know:

#### 1. **Application Registration**
   - You must **register a new app** in the **Microsoft Entra ID** (Azure portal).
   - The app registration allows PnP PowerShell to authenticate against your tenant using either **delegated** (user-based) or **application permissions**.

#### 2. **Assign Permissions**
   - During the registration process, you'll need to assign the appropriate **API permissions** to your app (e.g., SharePoint, Microsoft Graph) depending on what your PowerShell scripts need to access.
   - For **application permissions**, you may need admin consent for certain APIs (like SharePoint or Graph APIs).

#### 3. **Authentication Options**
   - You can authenticate using **certificates** or **client secrets**, depending on your security preferences.
   - PnP PowerShell supports various authentication modes, including interactive login, app-only, and device login.

### **Steps for Entra ID Registration for PnP PowerShell**:
1. **Go to the Microsoft Entra ID (Azure AD) portal**.
2. **Register a new application** under **App Registrations**.
3. **Set up API permissions** required for your operations (e.g., Microsoft Graph, SharePoint Online).
4. **Set up authentication** (via client secret or certificate).
5. **Configure your PnP PowerShell script** to use the app registration for authentication.

This is similar to the process for registering Power Apps, but it's important to note that Power Apps primarily deal with user-based delegated permissions, whereas PnP PowerShell commonly works with app-based (application) permissions for automation and administrative tasks.

Let me know if you need a more detailed step-by-step for registering the app or configuring PnP PowerShell!