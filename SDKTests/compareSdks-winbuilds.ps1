param( $baseversion,  $newversion)
Get-Date
if (-not($newversion -gt 1)) {

Dir \\winbuilds\release\Ge_release_svc_prod3
} else {

Write-Host Compare headers
	$DiffReport="C:\temp\HeaderDiff"+$newversion+ ".txt"
	If(test-path($DiffReport)){remove-item $DiffReport}
	$winbuilds="\\winbuilds\release\ge_release_svc_prod3"
	$x86content="\x86fre\kit_src\Content\"
	$x64Content="\amd64fre\kit_src\Content\"
	$armContent="\arm64fre\kit_src\Content\"
        $basefullpath = $winbuilds  + "\" + $baseversion + $x86content
        $newfullpath = $winbuilds + "\" + $newversion + $x86content
	 $folderlist= @(
				"desktop_shared_headers_(x86)", 
				"desktop_user_mode_headers_(x86)", 
				"desktop_windows_runtime_headers_(x86)",
				"modern_shared_headers_onecoreuap_(x86)",
				"modern_user_mode_headers_(x86)",
				"modern_windows_runtime_headers_(x86)",
				"shared_headers_onecoreuap_(x86)",
				"universal_crt_headers")
}

		$count=0
	foreach ($folder in $folderlist) {
	
		$basefullpathfolder=$basefullpath+$folder
		$newfullpathfolder=$newfullpath+$folder
		Write-Host Comparing folder $newfullpathfolder $count / $folderlist.count
		$count++
		$newfiles = get-childitem -path   $newfullpathfolder  -Recurse | where { !$_.PSisContainer }
		$oldfiles = get-childitem -path   $oldfullpathfolder  -Recurse | where { !$_.PSisContainer }
		# diff (cat $newfiles) (cat $oldfiles)
        	
		foreach ($file in $newfiles) {
                	$oldfile=$file.fullname.replace($newfullpathfolder,$basefullpathfolder)
			diff (cat $file.fullname) (cat $oldfile)
	                $results += diff (cat $file.fullname) (cat $oldfile)  		
		}

                if ($results -like "*because it does not exist.*"){
                        write-host NEW $file.fullname -foregroundcolor blue
                }

                if ($results.length -gt 2) {

                        if(-not ($results.inputobject -eq "")){
                        Write-host $file.fullname -foregroundcolor red | out-file -filepath 	$DiffReport -append
write-host did it write?
pause
                        diff (cat $file.fullname) (cat $oldfile) | out-file -filepath 	$DiffReport -append
                        }
                }
		$results=$null
}

Get-Date