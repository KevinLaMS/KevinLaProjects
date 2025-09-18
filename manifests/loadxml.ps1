Param($PackageDescription, $Version, $PublisherDisplayName, $PublisherName, $PackageDisplayName, $PackageName, $PackagePath, $NewFileName, $InstallerType)


write-host =======================================================
write-host creating XML
write-host =======================================================



$xmlContent = Get-Content -Path "c:\temp\msix\baseline.xml"
$xmlDoc = [xml]$xmlContent


$value = $xmlDoc.MsixPackagingToolTemplate.PackageInformation
$Savevalue = $xmlDoc.MsixPackagingToolTemplate.SaveLocation

write-host $value

$value.packagename


$elementValue = $xmlDoc.root.element
Write-host $elementValue

write-host ====
write-host $PackageDescription $Version  $PublisherName  $PublisherDisplayName
$xmlDoc.MsixPackagingToolTemplate.PackageInformation.PackageDescription = $PackageDescription
#$xmlDoc.MsixPackagingToolTemplate.PackageInformation.Version= $Version
$xmlDoc.MsixPackagingToolTemplate.PackageInformation.PublisherDisplayName = $PublisherDisplayName
#$xmlDoc.MsixPackagingToolTemplate.PackageInformation.PublisherName = $PublisherName
$xmlDoc.MsixPackagingToolTemplate.PackageInformation.PackageDisplayName = $PackageDisplayName
$xmlDoc.MsixPackagingToolTemplate.PackageInformation.PackageName=(get-item .).parent.name


$xmlDoc.MsixPackagingToolTemplate.SaveLocation.TemplatePath=$NewFileName
$xmlDoc.MsixPackagingToolTemplate.SaveLocation.PackagePath=$PackagePath + ".msix"


    # Ensure Installer node exists
    if (-not $xmlDoc.MsixPackagingToolTemplate.Installer) {
        $installerNode = $xmlDoc.CreateElement('Installer')
        $xmlDoc.MsixPackagingToolTemplate.AppendChild($installerNode) | Out-Null
    } else {
        $installerNode = $xmlDoc.MsixPackagingToolTemplate.Installer
    }



if ($InstallerType -eq "MSI") {
    if ($installerNode -is [System.Xml.XmlElement]) {
        $installerNode.SetAttribute('Arguments', '/q')
    } else {
        $attr = $xmlDoc.CreateAttribute('Arguments')
        $attr.Value = '/q'
        $installerNode.Attributes.Append($attr) | Out-Null
    }
}
if ($InstallerType -eq "Inno"){

    if ($installerNode -is [System.Xml.XmlElement]) {
        $installerNode.SetAttribute('Arguments', '/VERYSILENT')
    } else {
        $attr = $xmlDoc.CreateAttribute('Arguments')
        $attr.Value = '/VERYSILENTq'
        $installerNode.Attributes.Append($attr) | Out-Null
    }
}
if ($InstallerType -eq "nullsoft") {
    if ($installerNode -is [System.Xml.XmlElement]) {
        $installerNode.SetAttribute('Arguments', '-agreelicense')
    } else {
        $attr = $xmlDoc.CreateAttribute('Arguments')
        $attr.Value = '-agreelicense'
        $installerNode.Attributes.Append($attr) | Out-Null
    }
}

if ($InstallerType -eq "exe" -or $InstallerType -eq "portable") {


    # Set the installer path
    $installerNode.Path = $PackagePath
    if ($installerNode -is [System.Xml.XmlElement]) {
        $installerNode.SetAttribute('UnattendedInstallWithoutArgument', 'true')
    } else {
        $attr = $xmlDoc.CreateAttribute('UnattendedInstallWithoutArgument')
        $attr.Value = 'true'
        $installerNode.Attributes.Append($attr) | Out-Null
    }

    # Add the attribute reliably
    if ($installerNode -is [System.Xml.XmlElement]) {
        $installerNode.SetAttribute('UnattendedInstallWithoutArgument', 'true')
    } else {
        $attr = $xmlDoc.CreateAttribute('UnattendedInstallWithoutArgument')
        $attr.Value = 'true'
        $installerNode.Attributes.Append($attr) | Out-Null
    }
    }
    else {

}

$xmlDoc.MsixPackagingToolTemplate.Installer.Path=$PackagePath
$xmldoc.save($NewFileName)


$errorlog="c:\temp\msix\error.txt"
$successLog ="c:\temp\msix\success.txt"

write-host =======================================================
write-host Building MSIX
write-host =======================================================

Write-Host "COMMAND MsixPackagingTool.exe create-package --template  $newfileName"
$diditwork = MsixPackagingTool.exe create-package --template  $newfileName
if ($diditwork -like "*Package created under:*" ) {
    write-Host Success -ForegroundColor Green

    Write-Output $NewFileName  | Out-File -FilePath   $successlog  -Append

} else {

    write-host FAIL -ForegroundColor red
 
    Write-Output $NewFileName  | Out-File -FilePath   $errorlog  -Append
    foreach ($line in $diditwork) {If ($line -like "*exit code*") {
        Write-Output $NewFileName  | Out-File -FilePath   $errorlog  -Append}
    }

}





$target=($PackagePath + ".msix").trim()
# write-host   sign /fd sha256 /a /f  c:\temp\msix\msix.pfx /p 1234  $target
# & "c:\program files (x86)\windows kits\10\bin\10.0.26100.0\x64\SignTool.exe" sign /fd sha256 /a /f  c:\temp\msix\msix.pfx /p 1234  $target
write-host  $target