exit


param( [string] $baseline, [string] $new)
$location=get-location
$newpath = $location.path + "\" + $new + "\Include\10.0.26100.0\"

$baselinepath = $location.path + "\" + $baseline + "\Include\10.0.26100.0\"

$folderlist =@("ucrt", "shared", "um")

foreach ($folder in $folderlist) {
	
	$newfullpath = $newpath + "\" + $folder
	$basefullpath = $baselinepath + "\" + $folder
	$newfiles = get-childitem -path   $newfullpath  -Recurse | where { !$_.PSisContainer }
	foreach ($file in $newfiles) {
		$oldfile=$file.fullname.replace($new,$baseline)
		#$oldfile=$basefullpath + "\" +  $file.name
		#compare-object $file.fullname $oldfile

		# write-host $file.fullname $oldfile
		$results = diff (cat $file.fullname) (cat $oldfile)

		if ($results -like "*because it does not exist.*"){
			write-host NEW $file.fullname -foregroundcolor blue	
		}
		
		if ($results.length -gt 2) {
		
			if(-not ($results.inputobject -eq "")){
			Write-host $file.fullname -foregroundcolor red
			diff (cat $file.fullname) (cat $oldfile)
			}
		}


	}
}