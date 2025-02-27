$basemsiexeccount=(Get-Process msiexec).count

$basepath="\\winbuilds\release\ge_release_svc_prod3\"
$Currentversion="26100.3320.250212-1759"
$Previousversion="26100.3037.250123-2219"
$arch=@("amd64fre", "x86fre", "arm64fre")

function GetFiles ($version){
    $folders=@("Universal CRT Headers Libraries and Sources-x86_en-us.msi",
    "Windows Desktop Extension SDK Contracts-x86_en-us.msi","Windows Desktop Extension SDK-x86_en-us.msi"
    "Windows IoT Extension SDK Contracts-x86_en-us.msi",
    "Windows IoT Extension SDK-x86_en-us.msi",
    "Windows Mobile Extension SDK Contracts-x86_en-us.msi",
    "Windows Mobile Extension SDK-x86_en-us.msi",
    "Windows SDK Desktop Headers arm64-x86_en-us.msi",
    "Windows SDK Desktop Headers x64-x86_en-us.msi",
    "Windows SDK Desktop Headers x86-x86_en-us.msi",
    "Windows SDK Desktop Libs arm64-x86_en-us.msi",
    "Windows SDK Desktop Libs x64-x86_en-us.msi",
    "Windows SDK Desktop Libs x86-x86_en-us.msi",
    "Windows SDK Facade Windows WinMD Versioned-x86_en-us.msi",
    "Windows SDK for Windows Store Apps Contracts-x86_en-us.msi",
    "Windows SDK for Windows Store Apps Headers OnecoreUap-x86_en-us.msi",
    "Windows SDK for Windows Store Apps Headers-x86_en-us.msi",
    "Windows SDK for Windows Store Apps Libs-x86_en-us.msi",
    "Windows SDK for Windows Store Apps Metadata-x86_en-us.msi",
    "Windows SDK for Windows Store Apps-x86_en-us.msi",
    "Windows SDK for Windows Store Managed Apps Libs-x86_en-us.msi",
    "Windows SDK OnecoreUap Headers arm64-x86_en-us.msi",
    "Windows SDK OnecoreUap Headers x64-x86_en-us.msi",
    "Windows SDK OnecoreUap Headers x86-x86_en-us.msi",
    "Windows Team Extension SDK Contracts-x86_en-us.msi",
    "Windows Team Extension SDK-x86_en-us.msi")

    foreach ($file in $folders){

        $basepath="\\winbuilds\release\ge_release_svc_prod3\"
        $version=$Previousversion
        $arches=@("amd64fre", "x86fre", "arm64fre")
        $dest="c:\temp\deleteme\kevinla\" + $version

        write-host $file

        foreach ($arch in $arches){
            $path=$basepath + $version + "\" + $arch + "\kit_bundles\windowssdk\installers\" + $file 
            write-host $path
            msiexec /a  $path  /qb TARGETDIR=$dest
            While ((Get-Process msiexec).count -gt $basemsiexeccount){
                Start-Sleep -Seconds 3
            }
        }
    }
}
GetFiles ($Currentversion)
GetFiles ($Previousversion)