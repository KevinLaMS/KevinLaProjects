
param ($sdkversion)
$listofversions=@("10.0.10586.0", "10.0.16299.0", "10.0.22621.0", "10.0.18362.0", "10.0.17134.0", "10.0.17763.0", "10.0.15063.0",  "10.0.19041.0", "10.0.10240.0", "10.0.26100.0")

if (-not($sdkversion -like "*.0")) {
	Write-host Error: You need to pass in valid version with Zero as last digit. 10.0.26100.0
} Else {


Write-Host requires 2017 tools, and msvc 140

$broken=@()
$pass=0
$count=0
$fail=0
Get-ChildItem "*.vcxproj" -Recurse | ForEach-Object -Process {
	$count++
	Write-host Modify project files to use $sdkversion -foregroundcolor blue
	foreach ($r in $listofversions) {
    	(Get-Content $_) -Replace $r, $sdkversion | Set-Content $_
	}

	write-host $_
        $filecontent = Get-Content $_

        if ($filecontent -like "*$sdkversion*" ) {
                $dir=$_.DirectoryName
                $sln=Get-ChildItem "*.sln" -path $dir
                write-host Building $sln.fullname
				msbuild -t:Restore   $sln.fullname  -p:RestorePackagesConfig=true
                $myerror= msbuild $sln.fullname /property:Configuration=Debug /property:Platform=x64

                if ($myerror -like "*Build FAILED*") {Write-host $myerror -foregroundcolor red
				$broken+=$_.fullname
				$fail++
				$errorLog = $errorLog + $myerror
		} else {
			$pass++
		}


        }
}


Write-host Success: $pass -foregroundcolor green
Write-host Fail: $fail  -foregroundcolor red
write-host Total: $count
foreach($o in $broken) {write-host $o -foregroundcolor red}
Write-host Success: $pass -foregroundcolor green
Write-host Fail: $fail  -foregroundcolor red
Write-Host
write-host PassKey requires additional headers so failure OK (univeral platform tools C++ 143)
write-host toast requires wix so failure OK
write-host DisplayCoreCustomCompositor has winrt error 

}

