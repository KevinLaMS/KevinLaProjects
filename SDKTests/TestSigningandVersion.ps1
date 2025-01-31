Get$signtool="C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\signtool.exe"

$exefiles=get-childitem  -filter "*.exe" -Recurse
$dllfiles=get-childitem  -filter "*.dll" -Recurse

foreach ($exe in $exefiles) {
	$exefullpath = $exe.fullname
	$fileVersion = (Get-Item $exefullpath).VersionInfo.FileVersion
	if ($fileVersion -lt 1) {
		Write-Host "Error" $exefullpath $fileVersion -foregroundcolor red
	}
}

foreach ($exe in $dllfiles) {
	$exefullpath = $exe.fullname
	$fileVersion = (Get-Item $exefullpath).VersionInfo.FileVersion
	if ($fileVersion -lt 1) {
		Write-Host "Error" $exefullpath $fileVersion -foregroundcolor red
	}
}

foreach ($exe in $exefiles) {
	$exefullpath = $exe.fullname
	$signresults = & $Signtool verify /pa /v $exe.fullname

	if (-not($signresults -like "*Number of errors: 0*")) {
		Write-Host "Error Not Signed" $exefullpath  -foregroundcolor red
	}
}

foreach ($exe in $dllfiles) {
	$exefullpath = $exe.fullname
	$signresults = & $Signtool verify /pa /v $exe.fullname

	if (-not($signresults -like "*Number of errors: 0*")) {
		Write-Host "Error Not Signed" $exefullpath  -foregroundcolor red
	}
}



