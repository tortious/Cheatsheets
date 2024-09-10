To extract all JSON data from a SharePoint site, you can use the SharePoint REST API. Here's a general outline of how to do this:

### Steps:

#### 1. **Accessing the SharePoint REST API**
   - You can access the SharePoint REST API at the following URL format:
     ```
     https://<site-url>/_api/web
     ```
   Replace `<site-url>` with the base URL of your SharePoint site.

#### 2. **Authentication**
   - If you are accessing SharePoint Online, you will need to authenticate using either:
     - OAuth with Azure AD, if you are accessing it programmatically (recommended for most modern apps).
     - Using SharePoint App Registration (for permissions-based access).
     - For simple scripts, you can authenticate using cookies or other methods if you are within your organization's network.

#### 3. **Making GET Requests**
   - Use a tool like **Postman**, **PowerShell**, or any **HTTP client** in Python, JavaScript, etc., to make GET requests.
   - Example of a GET request to retrieve a list of all lists and libraries in your site:
     ```
     GET https://<site-url>/_api/web/lists
     ```
     This will return a JSON response containing all lists and libraries.

#### 4. **Filter the Data**
   - You can filter the data returned from the API using query parameters. For example:
     - `$select`: Choose specific fields.
     - `$filter`: Filter by specific criteria.
     - `$top`: Limit the number of results returned.
   
   Example:
   ```
   GET https://<site-url>/_api/web/lists?$select=Title,ItemCount&$top=100
   ```

#### 5. **Extract List Items**
   - To get items from a specific list (e.g., "Documents"):
     ```
     GET https://<site-url>/_api/web/lists/getbytitle('Documents')/items
     ```

#### 6. **Paginate Large Data Sets**
   - If the data set is large, the API will return data in batches. You’ll need to handle pagination using the `odata.nextLink` property in the response to get the next batch.

#### 7. **Export Data**
   - Once you've retrieved the JSON data using the REST API, you can:
     - Write it to a file (e.g., using Python or JavaScript).
     - Store it in a database.
     - Process it directly.

### Example PowerShell Script to Extract List Data:

```powershell
# Define variables
$siteUrl = "https://<site-url>"
$listName = "Documents"

# Authenticate
$creds = Get-Credential

# Make API Request
$response = Invoke-RestMethod -Uri "$siteUrl/_api/web/lists/getbytitle('$listName')/items" -Method GET -Credential $creds -Headers @{
    Accept = "application/json;odata=verbose"
}

# Convert to JSON and output
$jsonData = $response | ConvertTo-Json
$jsonData | Out-File "C:\path\to\output\file.json"
```

### Tools & Languages:
- **PowerShell:** Use the `Invoke-RestMethod` or `Invoke-WebRequest`.
- **Python:** Use libraries like `requests` to make API calls and parse the response.
- **Postman:** For manual testing, where you can directly test the API and export the data.

Would you like help with a specific API call or script for this?