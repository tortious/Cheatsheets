# Cheatsheets
cheatsheets for all things - e.g. linux, pacman, software, etc

## Misc Useful Stuff
---

[Winstall](https://winstall.app/apps) is a resource for browsing shit to download with winget. [Winget.run](https://winget.run/) is pretty much the same.

[SharePoint on MEdium.com](https://medium.com/tag/sharepoint/recommended)

[File Renaming in SharePoint Document Library using Power Automate](https://iamrehanmemon.medium.com/file-renaming-in-sharepoint-document-library-using-power-automate-62dd4de6e240)

---

medium.com
Upload file to SharePoint Site using Python - Giniya Gupta - Medium
Giniya Gupta
~3 minutes

Giniya Gupta
Photo by Chris J. Davis on Unsplash

Are you curious about how to upload files to SharePoint using Python Script? In this article, you’ll find how Python can help you save time and effort. Keep reading so you can bid adieu to manual file uploading and bonjour to productivity 😊

Let’s dive in and get started!

Step 1. Install Office365-Rest-Python-Client

pip install Office365-REST-Python-Client

*pip or pip3 depending upon your system

Step 2. Import required libraries

from office365.runtime.auth.authentication_context import AuthenticationContext
from office365.sharepoint.client_context import ClientContext

Step 3. Authentication

3.1 Create client context object

In simple words, client context is an object that contains information about SharePoint objects (sites, lists and items) and methods (create, read, update, delete). We need it, so we can retrieve files and send updates back. In this article ,we will create the context object using the client id and client secret.

site_url = 'https://{your-tenant-prefix}/sites/{your-folder-of-interest}'
app_principal = {
  'client_id': '{client_id}',
  'client_secret': '{client_secret}',
}
context_auth = AuthenticationContext(url=site_url)
context_auth.acquire_token_for_app(client_id=app_principal['client_id'], 
client_secret=app_principal['client_secret'])
ctx = ClientContext(site_url, context_auth)

3.2 Retrieve the title of a SharePoint website to check if client context object is working as expected

web=ctx.web

ctx.load(web)

ctx.execute_query()
print("Web site title: {0}".format(web.properties['Title']))

*Your client context object is ready to load file

Step 4. Load file to SharePoint site

4.1 Import os module

The OS module provides functions for interacting with the operating system

localpath = "{local path of the file you want to upload to SharePoint Site}/file_to_transfer.txt"
remotepath = "/sites/{path_to_folder_of_your_interest}/"+"name_you_want_to_give_to_uploaded_file.xlsx"

*ensure you follow this syntax for remote path else code will fail

4.2 Open and read the content of local file in binary format (“rb”) and save the content in a variable

with open(localpath,"rb") as content_file:
    file_content = content_file.read()

4.3 Load the file_content from previous step to SharePoint site

dir, name = os.path.split(remotepath)

4.4 Upload the file to SharePoint site

file = ctx.web.get_folder_by_server_relative_url(dir).upload_file(name, file_content).execute_query()

Voilà! your file is uploaded 😊
---


