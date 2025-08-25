param( $baseversion, $oldbranch, $newversion, $newbranch)
Get-Date
if ($newbranch -eq $null) {

	$location=@(get-childitem -path \\winbuilds\release\Ge_release_svc_prod3)
	$numberofdirs=$location.count -20
	$x=0

	foreach ($dirfolder in $location){	
		if($x -gt $numberofdirs) {write-host $dirfolder
		}
		$x++

	}
} else {

Write-Host Compare headers
	$DiffReport="C:\temp\HeaderDiff"+$newversion+ ".txt"
	If(test-path($DiffReport)){remove-item $DiffReport}
	$newbuilds="\\winbuilds\release\" + $newbranch
	$oldbuilds="\\winbuilds\release\" + $oldbranch
	$x86content="\x86fre\kit_src\Content\"
	$x64Content="\amd64fre\kit_src\Content\"
	$armContent="\arm64fre\kit_src\Content\"

	$newfullpath=$newbuilds  + "\" + $newversion + $x86content
	$basefullpath =  $oldbuilds + "\" + $baseversion + $x86content

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
$folderlist="desktop_user_mode_headers_(x86)"

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
					Write-host comparing $file.fullname
					$diffvalue = diff (cat $file.fullname) (cat $oldfile)
					if ($diffvalue.lenght -eq 0) {write-host diff issue
						write-host $diffvalue
						write-host $diffvalue.length
						write-host $file.FullName
						Pause}
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