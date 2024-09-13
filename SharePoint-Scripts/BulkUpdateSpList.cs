SPList list = null;
SPListItem item;

SPSite thissite = SPContext.Current.Site;
SPWeb thisweb = SPContext.Current.Web;

SPUtility.ValidateFormDigest();
SPSecurity.RunWithElevatedPrivileges(delegate ()
{
    using (SPSite currentSite = new SPSite(thissite.ID))
    {
        using (SPWeb currentWeb = currentSite.OpenWeb(thisweb.ID))
        {
            
            list = currentWeb.Lists.TryGetList("TestDocLib");

            string batchDataFormat = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><ows:Batch OnError=\"Continue\">{0}</ows:Batch>";
            string batchDataSetVar = "<SetVar Name=\"urn:schemas-microsoft-com:office:office#{0}\">{1}</SetVar>";
            string batchDataUpdateMethodFormat = "<Method ID=\"{0}\"><SetList>{1}</SetList><SetVar Name=\"ID\">{2}</SetVar><SetVar Name=\"Cmd\">Save</SetVar><SetVar Name='owsfileref'>{3}</SetVar>{4}</Method>";

            StringBuilder sbBatchDataMethod = new StringBuilder();


            string batchDataSetVarLines = string.Format(batchDataSetVar, "Stok", 5);
            sbBatchDataMethod.AppendFormat(batchDataUpdateMethodFormat, 13, list.ID, 13, currentWeb.Url + "/" + list.Title + "/image1.JPG", batchDataSetVarLines);

           
            string batchDataXml = string.Format(batchDataFormat, sbBatchDataMethod.ToString());
            string result = currentWeb.ProcessBatchData(batchDataXml);



            //currentWeb.AllowUnsafeUpdates = false;
        }
    }
});

//if you need to update sharepoint list (not document library) then remove <SetVar Name='owsfileref'>{3}</SetVar> and " currentWeb.Url + "/" + list.Title + "/image1.JPG","
//also run batchDataSetVarLines and sbBatchDataMethod inside foreach loop


SPContext context = SPContext.Current;

SPSecurity.RunWithElevatedPrivileges(delegate ()
{
    using (SPSite currentSite = new SPSite(this.WebApplication.Sites[0].Url))
    {
        using (SPWeb web = currentSite.OpenWeb())
        {
            web.AllowUnsafeUpdates = true;

            SPList list = web.Lists["WorkersList"];

            IEnumerable<SPListItem> items = (from SPListItem a in list.Items select a);


            if (items.Count() > 0)
            {
                Guid[] ids = new Guid[items.Count()];

                int methodID = 0;
                StringBuilder sbDelete = new StringBuilder();
                sbDelete.Append("<?xml version=\"1.0\" encoding=\"UTF-8\"?><ows:Batch OnError=\"Continue\">");
                string command = "<Method ID=\"{0}\"><SetList Scope=\"Request\">" + list.ID + "</SetList><SetVar Name=\"ID\">{1}</SetVar><SetVar Name=\"Cmd\">Delete</SetVar></Method>";
                foreach (SPListItem item in items)
                {
                    sbDelete.Append(string.Format(command, methodID, item.ID.ToString()));
                    ids[methodID] = item.UniqueId;
                    methodID++;
                }
                sbDelete.Append("</ows:Batch>");
                web.ProcessBatchData(sbDelete.ToString());

                //guid id not working.
                //web.RecycleBin.Delete(ids);

                web.RecycleBin.DeleteAll();
            }

            string json = string.Empty;
            using (WebClient wc = new WebClient())
            {
                wc.Encoding = Encoding.UTF8;
                json = wc.DownloadString("https://contonso.api.users");
            }

            List<Pers> users = JsonConvert.DeserializeObject<List<Pers>>(json);


            if (users.Count() > 0)
            {
                string BatchXMLBanner = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><ows:Batch OnError=\"Continue\">{0}</ows:Batch>";
                string BatchXMLMethod = "<Method ID=\"{0}\"><SetList>{1}</SetList><SetVar Name=\"ID\">New</SetVar><SetVar Name=\"Cmd\">Save</SetVar>{2}</Method>";
                string BatchXMLSetVar = "<SetVar Name=\"urn:schemas-microsoft-com:office:office#{0}\">{1}</SetVar>";

                StringBuilder XMLSetVarLines = new StringBuilder();
                StringBuilder XMLSetMethods = new StringBuilder();

                int methodID = 0;

                foreach (Pers user in users)
                {

                    XMLSetVarLines.Append(String.Format(BatchXMLSetVar, "Title", user.extensionAttribute3));
                    XMLSetVarLines.Append(String.Format(BatchXMLSetVar, "displayName", user.displayName));
                    XMLSetVarLines.Append(String.Format(BatchXMLSetVar, "manager", user.manager));

                    XMLSetMethods.Append(String.Format(BatchXMLMethod, methodID, list.ID, XMLSetVarLines));
                    methodID++;
                    XMLSetVarLines.Length = 0;
                }
                string ret = (String.Format(BatchXMLBanner, XMLSetMethods));

                web.ProcessBatchData(ret);
            }
        }
    }
});
