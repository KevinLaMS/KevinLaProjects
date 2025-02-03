
$outfile="C:\temp\MyReport.xml"
if (test-path($outfile)){remove-item $outfile}

Get-ChildItem "*.appx" -Recurse | ForEach-Object -Process {
&"c:\program files (x86)\windows kits\10\App Certification Kit\appcert.exe" test -appxpackagepath $_.Fullname reportoutputpath $outfile 

write-host "c:\program files (x86)\windows kits\10\App Certification Kit\appcert.exe" test -appxpackagepath $_.Fullname reportoutputpath $outfile 


if ( $lastexitcode	 -ne "0" ) {write-host error
type C:\temp\MyReport.xml
	$fail++

pause}
}



Write-host Success $pass -foregroundcolor green
Write-host Fail $fail  -foregroundcolor red
write-host $broken

