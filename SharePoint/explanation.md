rc9000   replied to  TezetazB
‎Aug 14 2024 10:38 AM

To manage your SharePoint list more efficiently and avoid clutter from multiple columns for each year, you can use views and calculated columns to show only the current year’s data and generate reports that include data from multiple years.

I would start by first creating a Calculated Column for the Year, then navigate to your SharePoint list, click on the settings gear icon and select List settings, under Columns, click Create column, then name the column such as my example where ill call it TrainingYear, then you will want to select Calculated (calculation based on other columns) as the column type. In the Formula field, enter the following formula to extract the year from the date column (assuming your date column is named TrainingDate):
=YEAR([TrainingDate])
Next, set the data type returned to Number, and then click OK to save the column.

To create views for each year, Go to your SharePoint list.
Click on the view selector (e.g., All Items) and select Create new view.
Name the view (e.g., 2024 Trainings).
Select the layout you prefer (e.g., Standard View).
Scroll down to the Filter section.
Set the filter to show items where TrainingYear is equal to 2024.
Click OK to save the view.
Repeat these steps to create views for other years, such as 2025 Trainings.

Now, if you wish to hide columns from previous years, I would suggest the following steps to take:
Go to the view selector and select the view you want to edit, such as 2024 Trainings, then click on the settings gear icon and select Edit current view, uncheck the columns for previous years that you do not want to display and then click OK to save the changes.

If you would like to generate reports including multiple years that include data from each year, you can use Power BI or Excel to connect to your SharePoint list and create a consolidated report using Power BI. For this portion, I suggest you take these steps:
Open Power BI Desktop, then click on Get Data and select SharePoint Online List, you then enter the URL of your SharePoint site and select the list, load the data into Power BI, create a new report and use filters to include data from multiple years and finally design your report to display the required information.

For Excel, you're going to want to open it first, then go to the Data tab and select Get Data > From Online Services > From SharePoint Online List, then enter the URL of your SharePoint site and select the list, and finally you can then load the data into Excel. Use PivotTables or other Excel features to create a report that includes data from multiple years.

To facilitate and automate the creation of views, you may also run a PowerShell script that accomplishes all of this as well:
PowerShell Automation Script:

# Ensure script is run with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
Write-Error "You need to run this script as an Administrator."
exit
}

# Function to create a view for a specific year
function Create-YearView {
param (
[string]$siteUrl,
[string]$listName,
[int]$year
)

$viewName = "$year Trainings"
$viewQuery = "<Query><Where><Eq><FieldRef Name='TrainingYear'/><Value Type='Number'>$year</Value></Eq></Where></Query>"

$context = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)
$list = $context.Web.Lists.GetByTitle($listName)
$viewCreationInfo = New-Object Microsoft.SharePoint.Client.ViewCreationInformation
$viewCreationInfo.Title = $viewName
$viewCreationInfo.ViewFields = @("Title", "TrainingDate", "TrainingYear")
$viewCreationInfo.Query = $viewQuery
$viewCreationInfo.RowLimit = 100
$viewCreationInfo.ViewTypeKind = [Microsoft.SharePoint.Client.ViewType]::Html
$list.Views.Add($viewCreationInfo)
$context.ExecuteQuery()

Write-Output "View '$viewName' created successfully."
}

# Example usage
$siteUrl = "https://yoursharepointsite"
$listName = "YourListName"
$years = @(2024, 2025)

foreach ($year in $years) {
Create-YearView -siteUrl $siteUrl -listName $listName -year $year
}

This approach will help you manage your SharePoint list more effectively, showing only the current year’s data while still being able to generate reports that include data from multiple years.
