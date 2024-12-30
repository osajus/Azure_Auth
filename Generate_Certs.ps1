# Certificate Method
# Generate a public and private certificate.
# Export both certificates to a folder
# Store the private certificate in the user's certification store

$subjectName = "<ENTER A NAME>" # The name that will appear in your computer's certificates store "Personal\Certificates" 
$certStore = "CurrentUser" # Keep this "CurrentUser"
$validity = 24 # Months

$newCert = @{
    Subject           = "CN=$($subjectName)"
    CertStoreLocation = "Cert:\$($certStore)\My"
    KeyExportPolicy   = "Exportable"
    KeySpec           = "Signature"
    NotAfter          = (Get-Date).AddMonths($($validity))
}
$Cert = New-SelfSignedCertificate @newCert

# Location to export the public certiticate to
$certFolder = ".\certs"
$certExport = @{
    Cert     = $Cert
    FilePath = "$($certFolder)\$($subjectName).cer"
}
Export-Certificate @certExport

# Location to export private certificate to
$certFolder = ".\certs"
$certThumbprint = $Cert.Thumbprint
$certPassword = Read-Host -Prompt "Enter a password: " -AsSecureString
$pfxExport = @{
    Cert         = "Cert:\$($certStore)\My\$($certThumbprint)"
    FilePath     = "$($certFolder)\$($subjectName).pfx"
    ChainOption  = "EndEntityCertOnly"
    NoProperties = $null
    Password     = $certPassword
}
Export-PfxCertificate @pfxExport 
Get-ChildItem -Path "Cert:\$($certStore)\My" | Where-Object {$_.Subject -Match "$certname"} | Select-Object Thumbprint, FriendlyName
