No, the non-automatic admin permissions you mentioned would **not affect your ability to create a flow** that triggers when a list item is added, assuming you have the necessary permissions for the **list** or **library** you are working with. Here's a breakdown:

### How Permissions Affect Flows:

1. **Global Admin Rights**:
   - As a **Global Admin**, you have the ability to manage and configure Microsoft Power Automate (Flows), SharePoint lists, and libraries across the tenant. However, your **content access** is still governed by SharePoint or OneDrive permissions for specific sites or libraries.

2. **Creating Flows with SharePoint Lists**:
   - If you want to create a **Power Automate flow** that triggers when a list item is added, you need **contributor or higher permissions** on that specific list or library.
   - **Flow permissions** are typically based on the account used to create the flow. If you create the flow, the flow will use your account's permissions to interact with the list, so:
     - You need to have access to the SharePoint list (at least **contribute** or **edit** permissions) to create a flow that interacts with that list.
     - If you don’t have permissions to the list where you’re trying to trigger the flow, you will need to **grant yourself access** as a Site Owner or list owner.

3. **HTTP Action in Flow**:
   - If you're creating a flow that uses an **HTTP request** (e.g., when a list item is added), you also need to ensure:
     - **Power Automate** has permission to use the **HTTP action** (this usually requires at least a **premium** Power Automate license).
     - The user account that initiates the flow has the correct permissions to **read/write** data to the target list or library.

4. **Permissions for List Items**:
   - If you’re triggering actions related to list items (like creating, reading, or modifying items), the flow will execute using the **permissions of the user who created the flow** (in this case, you).
   - If you don't have permission to a particular SharePoint list, the flow will fail when it tries to access that list. You can avoid this by ensuring you have **Owner** or **Contribute** permissions for the relevant list.

### Steps to Ensure Permissions for Your Flow:
1. **Check List Permissions**:
   - Go to the SharePoint list or library where you want the flow to be triggered.
   - Ensure you have at least **Edit** or **Contribute** permissions on the list. If not, add yourself or adjust permissions through **Site Permissions**.

2. **Grant Yourself Access If Needed**:
   - As a Global Admin, you can add yourself as an **Owner** or **Contributor** for the list or site, if necessary, using the **SharePoint Admin Center** or by adjusting the list’s permission settings directly.

3. **Testing Your Flow**:
   - Once permissions are set up, test your flow to ensure it works correctly. If any part of the flow involves accessing or modifying list items, it will succeed as long as you have the right access.

### Conclusion:
The fact that your Global Admin permissions don’t automatically give you content access to every SharePoint site or list **only impacts the flow if you don't have permissions to the list/library itself**. If you have access to the list where you’re creating the flow, this won’t be an issue. You just need to ensure that the account under which the flow is running has proper access to all resources involved.

Would you like more guidance on creating this specific flow, or assistance with permissions for the list?