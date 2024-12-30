# Azure_Auth
Connecting to Azure and MS Graph using certificate based authentication

Create a certificate using the Generate_Certs.ps1

Go to:
- https://portal.azure.com/
- Microsoft Entra ID
- App Registrations
- Locate appropriate registration (or create one)
- Certificates & secrets
- Certificates (tab)
- Upload Certificate
- Assure API Permissions are set appropriately for whatever you plan

Connect using Authenticate_MsGraph.ps1
