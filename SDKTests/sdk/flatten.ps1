param($url)
write-host $url  

$HeaderArray=@('CppWinRT_Headers', 'Debuggers_SDK_Headers', 'desktop_shared_headers_(x86)', 'Desktop_User_Mode_Headers_(x86)', 'Desktop_Windows_Runtime_Headers_(x86)', 'Modern_Shared_Headers_OnecoreUAP_(x86)', 'Modern_User_Mode_Headers_(x86)', 'Modern_Windows_Runtime_Headers_(x86)', 'Shared_Headers_OnecoreUAP_(x86)', 'Universal_CRT_Headers'
)


if ($url.length  -lt 5 ) {write-host Pass in the path }
else {


    foreach ($a in $HeaderArray) {
    $myUrl=$url + "\" + $a 
    write-host "Getting H files $myUrl"
    $hfiles+=Get-ChildItem -Path  $myUrl -Filter f*.h -Recurse -ErrorAction SilentlyContinue
    write-host "Getting IDL files $myUrl"
    $idlfiles+=Get-ChildItem -Path  $myUrl -Filter f*.idl -Recurse -ErrorAction SilentlyContinue
    }
}
$hfiles
$idlfiles

 