To extract JSON data from SharePoint lists, pages, and scripts using Python and the SharePoint REST API, you'll need to make API requests to fetch the data from each resource. Below, I'll guide you through how to extract data from:

1. **SharePoint List "JEFF"**
2. **SharePoint List "Mark Schedule"**
3. **A SharePoint Page**
4. **All Site Scripts**

### Prerequisites:
- You need an authentication method. For simplicity, I'm demonstrating using `requests` and `requests_ntlm` (for NTLM authentication). You can also use OAuth tokens for secure access, which is recommended for production.
- Python packages: `requests` and `requests_ntlm` (install using `pip install requests requests_ntlm`).
- Proper permissions to access the SharePoint site, lists, and pages.

### Sample Python Code:

```python
import requests
from requests_ntlm import HttpNtlmAuth

# SharePoint site details
site_url = "https://yourtenant.sharepoint.com/sites/yoursite"
username = "your_username"
password = "your_password"
auth = HttpNtlmAuth(username, password)
headers = {
    "Accept": "application/json;odata=verbose",
    "Content-Type": "application/json;odata=verbose"
}

# Function to get list data as JSON
def get_list_data(list_name):
    list_url = f"{site_url}/_api/web/lists/getbytitle('{list_name}')/items"
    response = requests.get(list_url, headers=headers, auth=auth)
    
    if response.status_code == 200:
        return response.json()
    else:
        print(f"Failed to fetch data from list {list_name}: {response.content}")
        return None

# Function to get a SharePoint page as JSON
def get_page_data(page_name):
    page_url = f"{site_url}/_api/web/GetFileByServerRelativeUrl('/sites/yoursite/SitePages/{page_name}.aspx')"
    response = requests.get(page_url, headers=headers, auth=auth)
    
    if response.status_code == 200:
        return response.json()
    else:
        print(f"Failed to fetch page {page_name}: {response.content}")
        return None

# Function to get all site scripts
def get_site_scripts():
    scripts_url = f"{site_url}/_api/Microsoft.Sharepoint.Utilities.WebTemplateExtensions.SiteScriptUtility.GetSiteScripts"
    response = requests.post(scripts_url, headers=headers, auth=auth, json={})
    
    if response.status_code == 200:
        return response.json()
    else:
        print(f"Failed to fetch site scripts: {response.content}")
        return None

# Fetch data from the JEFF list
jeff_list_data = get_list_data("JEFF")
print("JEFF List Data:", jeff_list_data)

# Fetch data from the Mark Schedule list
mark_schedule_data = get_list_data("Mark Schedule")
print("Mark Schedule List Data:", mark_schedule_data)

# Fetch data from a SharePoint page (replace 'SamplePage' with your page name)
page_data = get_page_data("SamplePage")
print("Page Data:", page_data)

# Fetch all site scripts
site_scripts = get_site_scripts()
print("Site Scripts:", site_scripts)
```

### Key Points:
1. **Lists**: `get_list_data()` function fetches items from the specified list.
2. **Page**: `get_page_data()` fetches a page using its server-relative URL; ensure you adjust the URL according to your page's path.
3. **Site Scripts**: `get_site_scripts()` fetches all site scripts configured on your SharePoint site. Note that this endpoint might require elevated permissions.

### Authentication Note:
- Replace `HttpNtlmAuth` with OAuth for production environments. Using `Microsoft Authentication Library (MSAL)` is more secure and recommended, especially for applications deployed on the web.

Let me know if you need further customization or have any questions!