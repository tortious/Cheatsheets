Certainly! Here’s a detailed guide on how to export an existing SharePoint modern site as a template for future use:
Steps to Export a SharePoint Modern Site as a Template
Enable Custom Script:
By default, custom scripts are disabled in SharePoint Online for security reasons. To enable it, you need to adjust the settings in the SharePoint Admin Center.
Navigate to the SharePoint Admin Center.
Go to Settings > Classic settings page.
Under Custom Script, select Allow users to run custom script on personal sites and Allow users to run custom script on self-service created sites.
Note that changes may take up to 24 hours to take effect.
Save the Site as a Template:
Once custom scripts are enabled, go to the site you want to save as a template.
Append /_layouts/15/savetmpl.aspx to the site URL. For example, if your site URL is https://yourtenant.sharepoint.com/sites/yoursite, navigate to https://yourtenant.sharepoint.com/sites/yoursite/_layouts/15/savetmpl.aspx.
Fill in the details for the template, such as the file name, template name, and description.
Choose whether to include content in the template. Including content means that all the lists, libraries, and their contents will be part of the template.
Download the Template:
After saving the site as a template, it will be stored in the Solutions Gallery of the site collection.
Navigate to the Solutions Gallery by going to Site Settings > Web Designer Galleries > Solutions.
Find your template in the list, click on it, and download the .wsp file to your local machine.
Upload and Activate the Template:
To use the template for creating new sites, you need to upload it to the Solutions Gallery of the site collection where you want to use it.
Go to the Solutions Gallery of the target site collection.
Click on Upload Solution and upload the .wsp file.
Once uploaded, activate the solution.
Create a New Site Using the Template:
Now that the template is activated, you can create a new site using it.
Go to the site collection where you uploaded the template.
Click on New > Subsite.
In the template selection, you should see your custom template listed under the Custom tab.
Select your template, fill in the necessary details for the new site, and create it.
Important Considerations
Modern Sites Limitation: The ability to save a site as a template is more straightforward with classic sites. For modern sites, the process might involve additional steps or workarounds, as the direct save as template option is not always available1.
Permissions: Ensure you have the necessary permissions to enable custom scripts and save sites as templates.
Content Inclusion: Including content in your template can significantly increase the size of the .wsp file and the time it takes to create new sites from the template.
For more detailed instructions and troubleshooting, you can refer to the Microsoft Learn documentation1.
If you have any specific questions or run into issues, feel free to ask!
1

learn.microsoft.com
2

sharepointdiary.com
3

answers.microsoft.com
4

enjoysharepoint.com
+2 more




3
of
30
responses
