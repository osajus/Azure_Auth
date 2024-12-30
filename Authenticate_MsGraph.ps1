# Obtain Certificate Thumprint from your store
Get-ChildItem -Path "Cert:\CurrentUser\My" | Select-Object Subject, Thumbprint    

# Connect via MsGraph
Import-Module Microsoft.Graph.Groups

$ClientID = '<ENTER VALUE>'  # App Registration Overview -> Application (client) ID
$TenantID = '<ENTER VALUE'  # App Registration Overview -> Directory (tenant) ID

$thumprint = '<ENTER THUMBPRINT>'

Connect-MgGraph -ClientID $clientId -TenantId $TenantID -CertificateThumbprint $thumbprint -NoWelcome

# Sample Actions.  Use Graph Explorer to help find other things to do.  (https://developer.microsoft.com/en-us/graph/graph-explorer)
# Assure your Azure App Registration has appropriate API Permissions like:   "GroupMember.Read.All", "User.Read.All", "Group.Read.All"

# Find an existing group 
Get-MgGroup | Where-Object {$_.DisplayName -like '*SAR*'} | Select-Object DisplayName, Id

# Obtain members of a group.  
$groupID = '<ENTER VALUE>'
$members = Get-MgGroupMemberAsUser -GroupId $groupId 

# Loop through each group member and retrieve additional properties
foreach ($member in $members) {
    
    $user = Get-MgUser -UserId $member.Id -Property "id, displayName, department" 
    $userDetails += [PSCustomObject]@{
    Id                 = $user.id
    DisplayName        = $user.displayName              
    Department  = $user.department
    }
}

# Display the detailed user information
$userDetails | Select-Object Department, DisplayName | Sort-Object Department 


Disconnect-MsGraph
