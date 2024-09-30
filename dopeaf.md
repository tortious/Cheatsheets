To automatically provision a **packet of template documents** (e.g., pleadings, letter templates) into a document library when it's added to a new SharePoint site, you can achieve this through several approaches. Here's a reliable method using **Content Types with Document Templates** along with **Site Scripts and Site Designs** for automation.

### Approach: Using Content Types, Document Templates, and Site Designs

#### Step 1: **Create Content Types with Document Templates**
Each document type (e.g., Pleading, Letter to Adjuster, Letter to Client) will have its own **content type** associated with a specific template. Here's how:

1. **Go to the Hub Site** where you'll manage content types globally.
2. **Create a Content Type** for each document:
   - Go to **Site Settings** → **Site Content Types**.
   - Create content types for each type of document in your packet (e.g., “Pleading,” “Letter to Adjuster,” etc.).
   - For each content type, under **Advanced Settings**, upload the document template that will be automatically used when a new file of that type is created.

#### Step 2: **Create the Document Library in Your Hub Site**
Create a central **Document Library** in your hub site to house these document templates and assign the content types you created to this library:

1. **Add the Content Types** to the Document Library:
   - Go to **Library Settings**.
   - Enable **Allow management of content types** and add the relevant content types (Pleading, Letter to Adjuster, etc.).

#### Step 3: **Use Site Scripts and Site Designs to Automate Provisioning**
Now, to automatically add these content types and document templates whenever a new site is created, use **Site Designs** and **Site Scripts**. Site Scripts allow you to apply configurations (like document libraries, content types, and templates) when a new site is created.

1. **Create a Site Script** to automatically provision the document library and templates:
   - The Site Script will define the creation of a new document library and associate the content types (which point to your document templates).
   - Example JSON for a Site Script that provisions a library with content types:
     ```json
     {
         "$schema": "schema.json",
         "actions": [
             {
                 "verb": "createSPList",
                 "listName": "Documents",
                 "templateType": 101,
                 "subactions": [
                     {
                         "verb": "addContentType",
                         "name": "Pleading"
                     },
                     {
                         "verb": "addContentType",
                         "name": "Letter to Adjuster"
                     },
                     {
                         "verb": "addContentType",
                         "name": "Letter to Client"
                     }
                 ]
             }
         ],
         "bindata": {},
         "version": 1
     }
     ```

2. **Create a Site Design**:
   - Go to **SharePoint Admin Center** → **Site Designs** and create a new Site Design. Attach the Site Script to this Site Design.
   - The Site Design will be available as an option when a new site is created, ensuring that your library with the templates is provisioned automatically.

#### Step 4: **Deploy and Test**
   - When creating a new SharePoint site for a new matter, select the **Site Design** that you created. Once the site is provisioned, the document library with the predefined templates will automatically appear.

### Alternative Methods:

1. **PnP PowerShell or SharePoint Framework (SPFx)**:
   - If you are familiar with PowerShell or custom development, you can script the creation of document libraries and the upload of templates using **PnP PowerShell** or build a custom SPFx solution.

2. **Manual Upload with Document Sets**:
   - You could use **Document Sets** to bundle all the template documents together, so when a user adds a Document Set, they get a set of pre-configured documents. This is less automated but effective for smaller-scale needs.

### Benefits of this Approach:
- **Consistency**: Every new site will have the same structure and templates, reducing manual setup.
- **Efficiency**: Saves time by automatically adding document libraries and templates without manual intervention.
- **Scalability**: Easily scalable for future template packs or additional content types.

Let me know if you need more detailed steps or assistance with setting up scripts or content types!