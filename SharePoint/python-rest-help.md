import requests
from requests_ntlm import HttpNtlmAuth

# SharePoint site details
site_url = "https://yourtenant.sharepoint.com/sites/yoursite"
username = "your_username"
password = "your_password"
headers = {
    "Accept": "application/json;odata=verbose",
    "Content-Type": "application/json;odata=verbose"
}

# Example of creating a list
create_list_url = f"{site_url}/_api/web/lists"
list_data = {
    '__metadata': {'type': 'SP.List'},
    'Title': 'JEFF',
    'BaseTemplate': 100  # 100 = Custom List
}

# Make the request
response = requests.post(create_list_url, json=list_data, headers=headers, auth=HttpNtlmAuth(username, password))

if response.status_code == 201:
    print("List created successfully")
else:
    print(f"Failed to create list: {response.content}")