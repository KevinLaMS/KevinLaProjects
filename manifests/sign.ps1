$a=New-SelfSignedCertificate -Type Custom -KeyUsage DigitalSignature -CertStoreLocation "Cert:\CurrentUser\My" -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.3", "2.5.29.19={text}") -Subject "CN=Contoso Software, O=Contoso Corporation, C=US" -FriendlyName "Your friendly name goes here"

# $certpath = "Cert:\Curr# entUser\My\" + $a.Thumbprint#
# Export-PfxCertificate -cert $certpath -FilePath c:\temp\msix\msix.pfx  -Password $mypwd 


$mypwd = ConvertTo-SecureString -String '1234' -Force -AsPlainText



$certpath = "Cert:\LocalMachine\My\" + $a.Thumbprint
$certpath = "Cert:\CurrentUser\My\" + $a.Thumbprint

Get-ChildItem -Path $certpath  |
    Export-PfxCertificate -FilePath c:\temp\msix\msix.pfx -Password $mypwd



Export-PfxCertificate -cert $certpath -FilePath c:\temp\msix\msix.pfx  -Password $mypwd 