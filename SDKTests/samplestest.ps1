$listofversions=@("10.0.10586.0", "10.0.16299.0", "10.0.22621.0", "10.0.18362.0", "10.0.17134.0", "10.0.17763.0", "10.0.15063.0",  "10.0.19041.0", "10.0.10240.0")


$broken=@()
$pass=0
$count=0
$fail=0
Get-ChildItem "*.vcxproj" -Recurse | ForEach-Object -Process {
	$count++
	foreach ($r in $listofversions) {

    	(Get-Content $_) -Replace $r, '10.0.26100.0' | Set-Content $_
	}

	write-host $_
        $filecontent = Get-Content $_

        if ($filecontent -like "*10.0.26100.0*" ) {
                $dir=$_.DirectoryName
                $sln=Get-ChildItem "*.sln" -path $dir
                write-host Building $sln.fullname
                $myerror= msbuild $sln.fullname /property:Configuration=Debug /property:Platform=x64

                if ($myerror -like "*Build FAILED*") {Write-host $myerror -foregroundcolor red
			$broken+=$_.fullname
			$fail++
		} else {
			$pass++
		}


        }
}


Write-host Success: $pass -foregroundcolor green
Write-host Fail: $fail  -foregroundcolor red
write-host Total: $count
foreach($o in $broken) {write-host $o}



