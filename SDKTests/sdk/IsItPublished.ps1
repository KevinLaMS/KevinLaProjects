param($version="10.0.26100.2454")

$fixver=$version.replace("0.0.","0.1.")

$NuGetList=@("Microsoft.Windows.SDK.CPP.x86", "Microsoft.Windows.SDK.CPP", "Microsoft.Windows.SDK.CPP" ,"Microsoft.Windows.SDK.Contracts",  "Microsoft.Windows.SDK.BuildTools", "Microsoft.Windows.SDK.CPP.x64", "Microsoft.Windows.SDK.CPP.arm64")
$GoodURLList=@()
$BadURLList=@()

write-host Processing URLs
foreach ($url in $NuGetList) {
    
    $URI="https://www.nuget.org/packages/" + $url + "/" + $version
    $html=curl $URI -s 

    if ($html -like "*Not Found*") {
        # write-host $URI Missing -foregroundcolor red
        $BadURLList+=$URI 
    } else {
        $GoodURLList+=$URI 
    }
}

Write-Host Bad URIs -foregroundcolor red
foreach ($a in $BadURLList) {
    write-host $a
}
Write-Host Good URIs -foregroundcolor green
foreach ($a in $GoodURLList) {
    write-host $a
}

$getstandalonesdkhtml = invoke-webrequest -URI "https://developer.microsoft.com/en-us/windows/downloads/windows-sdk/"
# $getstandalonesdkhtml.Links.href

foreach ($href in $getstandalonesdkhtml.Links.href){
    if ($href -like "*fwlink*"){
            #write-host "  curl -i  $href"
        $headers=curl -i  $href -s
        $x=0
        while($x -lt $headers.count ){
            if($headers[$x] -like "*winsdksetup.exe*"){
                #write-host $headers[$x]
                $sdksetup=$headers[$x].split()
                #write-host   $sdksetup[1]
            }
            $x++
        }
  
    }
}

curl  $sdksetup[1]  --output "C:\temp\deleteme\winsdksetup.exe" -s 

$version=

$SDKVersion =  (get-item  C:\temp\deleteme\winsdksetup.exe).VersionInfo.FileVersion
if($SDKVersion -ne $fixver) {write-host FullSDK out of date  $SDKVersion expected $fixver -foregroundcolor red}
else {Write-Host FullSDK is correct version $fixver -foregroundcolor green }

