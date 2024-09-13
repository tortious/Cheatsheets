    static void Main(string[] args)
    {
        string siteUrl = "https://contonso.com.tr";
        string listTitle = "Documents";
        string username = "username";
        string password = "password";
        string domain = "domain"; // Domain is not needed for non-domain environments     

        try
        {
            using (ClientContext context = new ClientContext(siteUrl))
            {
                //if Form based authentication and NTLM is enabled and you want to login with NTLM use this.
                context.ExecutingWebRequest += new EventHandler<WebRequestEventArgs>((obj, e) =>
                {
                    e.WebRequestExecutor.WebRequest.Headers.Add("X-FORMS_BASED_AUTH_ACCEPTED", "f");
                });

                context.Credentials = new NetworkCredential(username, password, domain);
                Web web = context.Web;
                
                List list = web.Lists.GetByTitle(listTitle); 
				        CamlQuery query = new CamlQuery();
               
                query.FolderServerRelativeUrl = "/Shared%20Documents/Subfolder1/Subfolder2"; // Set the folder URL here
                
                query.ViewXml = $@"<View Scope='FilesOnly'>
                                    <Query>
                                        <Where>
                                            <And>
                                                <Geq>
                                                    <FieldRef Name='Created' />
                                                    <Value IncludeTimeValue='FALSE' Type='DateTime'>{DateTime.Today.AddDays(-5).ToString("yyyy-MM-dd")}</Value>
                                                </Geq>
                                                <Leq>
                                                    <FieldRef Name='Created' />
                                                    <Value IncludeTimeValue='FALSE' Type='DateTime'>{DateTime.Today.AddDays(+1).ToString("yyyy-MM-dd")}</Value>
                                                </Leq>
                                            </And>
                                        </Where>
                                    </Query>
                                </View>";

                ListItemCollection items = list.GetItems(query);

                context.Load(items, ic => ic.Include(
                   item => item.Id,
                   item => item["Title"],
                   item => item["Created"],
                   item => item.FileSystemObjectType,
                   item => item["FileLeafRef"],
                   item => item["FileRef"])); // Ensure FileRef (item URL) is included
                context.ExecuteQuery();

                //context.ExecuteQuery();

                foreach (ListItem item in items)
                {
                    //Console.WriteLine($"Item ID: {item.Id}, Title: {item["Title"]}, FileLeafRef: {item["FileLeafRef"]}, Created: {item["Created"]}, URL: {item["FileRef"]}");

                    if (item.FileSystemObjectType == FileSystemObjectType.File)
                    {
                        Microsoft.SharePoint.Client.File file = item.File;
                        context.Load(file);
                        context.ExecuteQuery();

                        var fileName = (string)item["FileLeafRef"]; // Gets the file name
                        var fileRef = (string)item["FileRef"]; // Full path on SharePoint

                        // Define the path where the file will be saved
                        string savePath = Path.Combine(@"\\PCNAME\SharedFolder", fileName);

                        // Check if the file already exists in the destination directory
                        if (!System.IO.File.Exists(savePath))
                        {
                            // Create the directory if it doesn't exist
                            var directory = Path.GetDirectoryName(savePath);
                            if (!Directory.Exists(directory))
                            {
                                Directory.CreateDirectory(directory);
                            }

                            // Save the file from the stream to the shared folder
                            using (var fileStream = System.IO.File.Create(savePath))
                            {
                                FileInformation fileInfo = Microsoft.SharePoint.Client.File.OpenBinaryDirect(context, fileRef);
                                fileInfo.Stream.CopyTo(fileStream);
                            }
                        }
                        else
                        {
                            //Console.WriteLine($"File already exists: {savePath}. Skipping copy.");
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            //Console.WriteLine($"An error occurred: {ex.Message}");
        }

        //Console.WriteLine("Press any key to exit...");
        //Console.ReadKey();
    }
}
