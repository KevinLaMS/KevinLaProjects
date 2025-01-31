param($version)

write-host Get the NuGets

curl https://www.nuget.org/profiles/WindowsSDK -o c:\temp\curl.txt

$findstr = Findstr /isc:flat \temp\curl.txt

Foreach ($row in $findstr) {
	if ($row -like "*microsoft.windows.sdk.cpp*" -and (-not($row -like "*$version*"))){
		if (-not($row -like "*microsoft.windows.sdk.cpp.arm/10.0.*")){
				Write-host Error $row -foregroundcolor red
		}
	} else { 	
		if ($row -like "*microsoft.windows.sdk.cpp*" ){	Write-host Error $row -foregroundcolor green}
	}
}

