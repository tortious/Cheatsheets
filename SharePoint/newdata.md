To set up a system in Office 365 Business SharePoint where you can click a button to enter preset categories of data and open a new matter with a new page, you can use a combination of SharePoint lists, PowerApps, and Power Automate. Here’s a step-by-step guide:

### 1. Set Up a SharePoint List for Matters
1. **Create a SharePoint List:**
   - Go to the SharePoint site where you want to manage your matters.
   - Click `New` > `List`.
   - Create a custom list and name it (e.g., "Matters").

2. **Add Columns:**
   - Add columns for each category of data you need to capture (e.g., Matter Name, Client, Jurisdiction, Status, etc.).

### 2. Create a PowerApps Form for Data Entry
1. **Open PowerApps:**
   - In your SharePoint list, click `Integrate` > `Power Apps` > `Customize forms`.
   - PowerApps will open with your SharePoint list integrated.

2. **Design the Form:**
   - Customize the form to include fields for all the categories of data you need.
   - Add validation, formatting, and logic as needed.

3. **Publish the Form:**
   - Once your form is ready, save and publish it.

### 3. Create a Power Automate Flow to Generate a New Page
1. **Open Power Automate:**
   - Go to Power Automate from the Office 365 app launcher.

2. **Create a New Flow:**
   - Click `Create` > `Automated flow`.
   - Choose `When an item is created` as the trigger and select your SharePoint list.

3. **Add Actions to the Flow:**
   - **Get Item:** Use the `Get item` action to retrieve details of the new list item.
   - **Create a SharePoint Page:** Use the `Send an HTTP request to SharePoint` action to create a new modern page. This action will require the use of SharePoint REST API to create a page in your site. The endpoint for creating a new page is typically:
     ```http
     /_api/web/lists/GetByTitle('Site Pages')/Items
     ```
     You will need to provide the necessary fields like Title and Content.
   - **Add Web Parts to the Page:** Use additional HTTP requests to add web parts and customize the page layout.

4. **Update the Flow:**
   - Include actions to handle errors and confirm the successful creation of the page.
   - Save and test your flow.

### 4. Link the PowerApps Form to the SharePoint Site
1. **Add a Button to Your SharePoint Site:**
   - Go to the page where you want the button.
   - Edit the page and add a button web part.
   - Set the button’s link to the PowerApps form.

2. **Use the Button:**
   - When you click the button, the PowerApps form will open.
   - Enter the required data and submit the form.
   - The Power Automate flow will trigger, creating a new page for the matter.

### Summary
- **SharePoint List:** Captures matter data.
- **PowerApps:** Provides a custom form for data entry.
- **Power Automate:** Automates the creation of a new page for each new matter.
- **Button on SharePoint Site:** Links to the PowerApps form for easy data entry.

This setup will allow you to streamline the process of creating new matters and their associated pages in SharePoint.

