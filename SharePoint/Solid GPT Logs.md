## List of links
---

- [Json create task list](https://chatgpt.com/share/459de06e-5323-4979-9a0f-045053292dd4)
- [GPT re list items into sp sites](https://chatgpt.com/share/2109a81a-f62a-422e-82a6-108d9b164a35)

     {
     "accept": "application/json;odata=verbose",
     "content-type": "application/json;odata=verbose"
     }

     {
     "request": {
        "Title": "@{triggerOutputs()?['body/Title']}",
        "Url": "https://yourtenant.sharepoint.com/sites/@{triggerOutputs()?['body/Title']}",
        "Lcid": 1033,
        "ShareByEmailEnabled": false,
        "WebTemplate": "SITE TEMPLATE ID",
        "Owner": "yourEmail@domain.com",
        "HubSiteId": "Hub Site ID"
     }
     }

- [integrating multiple data sources GPT](https://chatgpt.com/share/441cedb1-23df-4c73-a606-04ea1ee3e9e2) code associated: Filter(Table1, ColumnName = Dropdown1.Selected.Value)
- 
