Yes, you can absolutely link the centralized document library from your hub site to each child (matter-specific) site, and then use metadata filtering to show only that case’s relevant documents. Here’s how you can approach it:

1. **Add the Central Library to Each Matter Site**: 
   - In each child site, you can add a **document library web part** that connects to the centralized document library on the hub site.
   - You don’t need to copy or move documents to the child sites. Instead, you’re just linking to the same library in the hub.

2. **Filter Documents by Metadata**: 
   - Once the library is linked, you can set up a default view or use **web part filters** to show only documents tagged with metadata relevant to that particular case (e.g., Case ID, Matter Name).
   - For example, in the document library web part settings, you can filter based on metadata like `Case Name` or `Case ID`, ensuring that only documents related to that specific matter are displayed on that site.

3. **Use Dynamic Filtering or Audience Targeting**: 
   - If needed, you can apply dynamic filtering options so that users in each child site automatically see only the documents tagged for that particular case without needing to manually adjust the filters.

4. **Managed Metadata Navigation**: 
   - You can configure metadata-based navigation in the central library. This allows users on child sites to navigate through folders or categories based on the case-specific metadata without creating multiple views.

This method keeps your document storage centralized while still ensuring each case team only sees their relevant documents, streamlining document access and management across your case sites.