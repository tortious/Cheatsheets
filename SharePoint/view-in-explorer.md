To view SharePoint document folders in File Explorer, you can use the **Sync** feature or map the SharePoint library as a network drive. Here’s how to do both:

### Method 1: Sync SharePoint Document Library with OneDrive

1. **Go to the SharePoint Site:**
   - Open your web browser and navigate to the SharePoint site where the document library is located.

2. **Navigate to the Document Library:**
   - Go to the document library you want to sync.

3. **Click on the Sync Button:**
   - In the document library, you’ll see a **Sync** button on the command bar at the top. Click it.

4. **Allow OneDrive to Sync:**
   - A prompt will appear asking you to open Microsoft OneDrive. Click **Open**.
   - If you’re not signed in to OneDrive, you’ll need to sign in with your Microsoft account.
   - OneDrive will start syncing the document library to your local computer.

5. **Access the Folder in File Explorer:**
   - Once synced, you can find the SharePoint folder in File Explorer under the **OneDrive** section (it may be labeled with your organization's name).

### Method 2: Map a SharePoint Library as a Network Drive

1. **Copy the SharePoint Library URL:**
   - Navigate to the document library in SharePoint.
   - Copy the URL from the address bar up to the part before `Forms/AllItems.aspx`. It will look something like `https://yourcompany.sharepoint.com/sites/yoursite/Shared%20Documents`.

2. **Open File Explorer:**
   - Press `Win + E` to open File Explorer.

3. **Map the Network Drive:**
   - In File Explorer, click on **This PC** in the left sidebar.
   - Click the **Map network drive** button in the toolbar (you might need to click on the **Computer** tab first to see it).
   - Choose a drive letter that you want to assign to the SharePoint library.
   - In the **Folder** field, paste the URL you copied earlier.
   - Check the box for **Reconnect at sign-in** if you want the drive to map automatically every time you log in.
   - Click **Finish**.

4. **Sign in if Required:**
   - You may be prompted to enter your Microsoft credentials. Enter them if asked.
   
5. **Access the SharePoint Library:**
   - The SharePoint library should now appear as a mapped drive in File Explorer under **This PC**.

These methods allow you to interact with SharePoint document libraries directly from File Explorer, making it easier to manage your files as if they were on your local drive.


