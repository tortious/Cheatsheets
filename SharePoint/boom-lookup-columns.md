Linking multiple lists in SharePoint can be effectively managed using lookup columns, which allow you to create relationships between lists. Here's how you can link your lists, such as cases and clients, or cases and calendar events:

### 1. **Linking Lists with Lookup Columns**

**a. Link Cases to Clients:**

1. **Create or Modify the Cases List:**
   - Go to your “Cases” list and select **List Settings**.
   - Under **Columns**, choose to create a new column or modify an existing one.
   - **Add a Lookup Column:** 
     - Choose **Lookup** as the column type.
     - Name the column (e.g., “Client”).
     - Select the “Clients” list as the source for the lookup.
     - Choose the column from the “Clients” list that you want to display (e.g., “Client Name”).

2. **Update List Items:**
   - When adding or editing items in the “Cases” list, select the appropriate client from the dropdown populated by the “Clients” list.

**b. Link Cases to Calendar Events:**

1. **Create or Modify the Calendar List:**
   - Go to your “Calendar” list and select **List Settings**.
   - Under **Columns**, create a new column or modify an existing one.
   - **Add a Lookup Column:**
     - Choose **Lookup** as the column type.
     - Name the column (e.g., “Case”).
     - Select the “Cases” list as the source for the lookup.
     - Choose the column from the “Cases” list that you want to display (e.g., “Case Title”).

2. **Update Calendar Events:**
   - When creating or editing events in the calendar, select the appropriate case from the dropdown populated by the “Cases” list.

### 2. **Using Calculated Columns and Views**

**a. Display Related Information:**

1. **Add Calculated Columns:**
   - You can use calculated columns to display or combine data from related lists. For example, if you need to show the client’s contact information in the “Cases” list, create a calculated column that pulls data from the “Clients” list using lookup columns.

2. **Create Custom Views:**
   - Create custom views in your lists to show related information. For example, you can create a view in the “Cases” list that displays all related calendar events or client details.

### 3. **Creating Relationships with SharePoint Designer or Power Automate**

**a. SharePoint Designer:**
   - If you need more complex relationships or workflows, you can use SharePoint Designer to create data connections or workflows that handle data between lists.

**b. Power Automate:**
   - Use Power Automate to create workflows that update or synchronize data between lists. For instance, you can set up a flow to automatically create calendar events when a new case is added or update related lists based on changes.

### Example Setup

1. **Cases List:**
   - Columns:
     - Case ID (Primary Key)
     - Case Title
     - Client (Lookup Column from Clients List)
     - Additional fields...

2. **Clients List:**
   - Columns:
     - Client ID (Primary Key)
     - Client Name
     - Contact Information

3. **Calendar List:**
   - Columns:
     - Event ID (Primary Key)
     - Event Title
     - Case (Lookup Column from Cases List)
     - Date
     - Additional fields...

By leveraging lookup columns, calculated columns, and custom views, you can effectively link and manage related lists in SharePoint, ensuring that your data remains interconnected and accessible.