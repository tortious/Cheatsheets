# SharePoint With Python: A Comprehensive Guide to Working SharePoint Online File and Folders using Python

In this comprehensive guide, we will delve into the intricacies of connecting to SharePoint Online, providing step-by-step instructions for configuring essential settings within the SharePoint site. The article will walk you through the necessary configurations to establish a robust connection between your Python environment and SharePoint Online. Furthermore, we will explore the Python code required to read and upload large files seamlessly to specific folders within the SharePoint site. By combining configuration insights with practical code examples, this guide aims to empower users to harness the full potential of SharePoint Online for efficient file management through Python scripting. Whether you are a developer, data professional, or anyone seeking to integrate SharePoint with Python, this article serves as a valuable resource for navigating the process effortlessly.

A. Creating SharePoint Client ID and Secrets

First, We need to create app-based credentials.

Important: To generate app-based credentials, you must be a site owner of the SharePoint site.

    Go to the appregnew.aspx page in your SharePoint Online tenant. For example, https://<Your_Company>.sharepoint.com/teams/<Team_Name>/_layouts/15/appregnew.aspx
    Navigate to this page and locate the “Generate” buttons positioned alongside the Client ID and Client Secret fields. Proceed to input the required information as illustrated in the accompanying screenshot.

Title: You can give whatever name you like

App Domain: In case you are developing this application for your workplace or educational institution’s SharePoint site, consider using your company’s DNS as the App Domain. For more info: https://learn.microsoft.com/en-us/sharepoint/administration/configure-an-environment-for-apps-for-sharepoint
Image Courtesy: Microsoft

Important: Safely store the information — the client ID and client secret, as it will be crucial for the subsequent steps.

3. Next, proceed to grant site-scoped permissions for the recently created principal. Depending on your access types, use either link to grant permissions: https://<YourCompany>.sharepoint.com/teams/<Team_Name>/_layouts/15/appinv.aspx

or https://<YourCompany>-admin.sharepoint.com/_layouts/15/appinv.aspx

After the page loads, input your client ID into the “App Id” box and select “lookup,” as indicated in the screen below
Image Courtesy: Microsoft

4. To grant permissions, you will be required to provide the permission XML that outlines the necessary permissions (if you’re a site admin — “FullControl”, if you’re an owner — “Manage”). Copy the provided permission XML into the “Permission Request XML” box and proceed to select “Create”.

<AppPermissionRequests AllowAppOnlyPolicy="true"> 
<AppPermissionRequest Scope="http://sharepoint/content/sitecollection" Right="Manage" />
 </AppPermissionRequests>

5. Upon selecting “Create”, a permission consent dialog will appear. Click “Trust It” to grant the necessary permissions.

Safeguard the created client id/secret combination as would it be your administrator account. This client ID/secret holds the capability to read/update all data within your SharePoint Online environment

B. Working with Python

Configuration settings are now complete. Next, transition to the Terminal and install the required Python package for Office365 using the specified command.

pip install Office365-REST-Python-Client

Alternatively, the latest version could be directly installed via GitHub:

pip install git+https://github.com/vgrem/Office365-REST-Python-Client.git

In your Python Integrated Development Environment (IDE), import the necessary libraries and utilize the previously created Client ID and Secret as needed.

import io, pandas as pd, tempfile
from office365.sharepoint.client_context import ClientContext
from office365.runtime.auth.authentication_context import AuthenticationContext
from office365.sharepoint.folders.folder import Folder
from office365.sharepoint.files.file import File


sharepoint_clientId = "XXXXXXXXXXXXXXXX"
sharepoint_clientsecret = "XXXXXXXXXXXXXXXXXXXXXXX"

Proceed to create a Python code responsible for initializing the connection with SharePoint Online

class SharePoint_Connection:

    def __init__(self, client_id: str, client_secret: str, team: str) -> None:
        """
        Constructor to initialize SharePoint_Connection object with client_id, client_secret, and team values.

        Parameters:
            - client_id (str): The client ID used for SharePoint authentication.
            - client_secret (str): The client secret used for SharePoint authentication.
            - team (str): The name of the SharePoint team.

        Returns:
            - None
        "
""
        self.client_id = client_id
        self.client_secret = client_secret
        self.team = team

    def establish_sharepoint_context(self):
        """
        Establishes a SharePoint context using the provided client_id, client_secret, and team.

        Parameters:
            - self: An instance of the class that contains the method.

        Returns:
            - ctx (ClientContext): A SharePoint client context established using the provided authentication credentials
            (client_id, client_secret) and team information. If successful, the function returns the ClientContext object.
            If an error occurs during the establishment of the SharePoint context, an exception is caught and an error message
            is printed, and the function returns None.
        "
""

        try:
            
            site_url = f"https://<example>.sharepoint.com/teams/{self.team}"
            
            context_auth = AuthenticationContext(site_url)
            
            if context_auth.acquire_token_for_app(
                client_id=self.client_id, client_secret=self.client_secret
            ):
                
                ctx = ClientContext(site_url, context_auth)
                return ctx
        except Exception as e:
            
            print(f"Error: {type(e).__name__} {e}")
            return None

Next, we are going to perform the following SharePoint actions through the Python environment.

    Create a remote directory/folder in SharePoint Online.

def create_sharepoint_directory(self, directory_name: str) -> str | None:
        """
        Creates a directory in SharePoint under the 'Shared Documents/General/' path.

        Parameters:
            - directory_name (str): The name of the directory to be created.

        Returns:
            - str: The relative URL of the created directory if successful. If an error occurs during the creation process,
            an error message is printed, and the function returns an empty string.
        "
""

        if directory_name:
            
            ctx = self.establish_sharepoint_context()

            
            try:
                result = ctx.web.folders.add(
                    f"Shared Documents/General/{directory_name}"
                ).execute_query()
                
                if result:

                    relative_url = f"Shared Documents/General/{directory_name}"
                    print(
                        f"{directory_name} directory has been created at '{relative_url}'"
                    )
                    return relative_url
                else:
                    print("Failed to create a folder/directory!")
                    return ""
            except Exception as e:
                
                print(f"Error: {type(e).__name__} {e}")
                return ""
        else:
            print("Directory name cannot be empty!")
            return ""

2. Retrieve data from an Excel/CSV file and store it as a Pandas DataFrame.

def read_sharepoint_file_as_df(self, file_path: str, dtype=None) -> pd.DataFrame:
        """
        Reads a file from SharePoint and returns its content as a Pandas DataFrame.

        Parameters:
            - file_path (str): The path of the file in SharePoint, relative to the 'Shared Documents' directory.
            - dtype (dict or None): Data type specification for columns in the DataFrame (optional).

        Returns:
            - pd.DataFrame: A Pandas DataFrame containing the content of the specified file. If the 'dtype' parameter is provided,
            it is used to specify data types for DataFrame columns during reading.
        "
""
        
        ctx = self.establish_sharepoint_context()
        web = ctx.web
        ctx.load(web)
        ctx.execute_query()
        
        out = io.BytesIO()
        f = (
            ctx.web.get_file_by_server_relative_url(f"/Shared Documents/{file_path}")
            .download(out)
            .execute_query()
        )
        
        if dtype is not None:
            
            
            df = pd.read_excel(out, dtype=dtype)
        else:
            
            
            df = pd.read_excel(out)
        
        out.close()
        return df

3. Write files, including large ones, back to SharePoint Online.

By default, SharePoint has a maximum file size limit of 250MB (exactly 262144000 bytes). However, the following code extends this limit to 250GB.

def write_bytefile_to_sharepoint(
        self, file_path: str, file_name: str, file_bytes: bytes
    ) -> None:
        """
        Writes a byte file to SharePoint in the specified folder with the given file name.

        Parameters:
            - file_path (str): The path of the folder in SharePoint where the file should be written, relative to the 'Shared Documents' directory.
            - file_name (str): The name to be given to the file in SharePoint.
            - file_bytes (bytes): The content of the file as a bytes object.

        Returns:
            - None
        """

        
        ctx = self.establish_sharepoint_context()
        
        folder: Folder = ctx.web.get_folder_by_server_relative_url(
            f"Shared Documents/{file_path}"
        )
        
        chunk_size: int = 500000

        
        file: File = folder.files.get_by_url(file_name)

        if file.exists:

            
            file.delete_object().execute_query()

        
        with tempfile.NamedTemporaryFile(delete=False) as temp_file:
            temp_file.write(file_bytes)

        
        with open(temp_file.name, "rb") as file_to_upload:
            folder.files.create_upload_session(
                file=file_to_upload, chunk_size=chunk_size, file_name=file_name
            ).execute_query()
        
        print(f"{file_name} has been uploaded successfully!")

Our code is now prepared to execute various actions. Let’s proceed by executing the actions:

Initialize Connection


connectionString = SharePoint_Connection(
    client_id=sharepoint_clientId,
    client_secret=sharepoint_clientsecret,
    team="Your Company's Team Name",
)



connectionString.create_sharepoint_directory("folder_name")

Read Excel file from SharePoint Online


df = connectionString.read_sharepoint_file_as_df(
    "General/folder/file_name.xlsx",
)
print(df.head())

Write files back to the SharePoint Site


df = pd.DataFrame(data={"col1": [1, 2], "col2": [3, 4], "col3": [5, 6]})
fileBytes = bytes(df.to_csv(index=False), encoding="utf-8")

connectionString.write_bytefile_to_sharepoint(
    "General/folder", "file_name.csv", fileBytes
)

The complete code can be found here:

https://github.com/MishraSubash/connect_sp_online
