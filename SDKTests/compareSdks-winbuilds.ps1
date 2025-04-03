param( $baseversion="19041.985.210428-1722",  $newversion="19041.5609.250311-1926")
Get-Date
$debug=1
 

$baseversionpath="\\winbuilds\release\vb_release_svc_prod1\" + $baseversion + "\other\kit_content"
$newversionpath="\\winbuilds\release\vb_release_svc_im\" + $newversion + "\other\kit_content"

if($debug -eq 1 ) {write-host $baseversionpath $newversionpath}
$templocation="c:\temp\comparesdks"
$arch=@("x86", "arm", "amd64", "arm64")
				 $folderlist= @(
				"desktop_shared_headers", 
				"desktop_user_mode_headers", 
				"desktop_windows_runtime_headers",
				"modern_shared_headers_onecoreuap",
				"modern_user_mode_headers",
				"modern_windows_runtime_headers",
				"shared_headers_onecoreuap")

				$crtfolderlist="universal_crt_headers"


				 $libfolderlist= @(
				"desktop_user_mode_libraries", 
				"Modern_Managed_User_Mode_Libraries",
				"Modern_User_Mode_Libraries",
				"Universal_CRT_Enclave_Libraries",
				"Universal_CRT_Libraries")

				

#copy the files locally for comparing
if($debug -ne 1) {
	if (test-path $templocation){remove-item $templocation}
}

function copypath ($base, $version){
	foreach($a in $arch){
		$src=$baseversionpath + "\" + $a + "fre\content\"
		foreach ($b in $folderlist){
			$srcpath=$src + $b + "_(" + $a + ")"
			$destdir = $templocation + "\" + $version + "\" +  $a + "fre\content\" + $b + "_(" + $a + ")"
			if($debug -eq 1 ) {write-host $destdir}
			robocopy $srcpath $destdir
		}
		foreach ($b in $crtfolderlist){
			$srcpath=$src + $b  
			$destdir = $templocation + "\" + $version + "\" +  $a +  "fre\content\" + $b  
			if($debug -eq 1 ) {write-host $destdir}
			robocopy $srcpath $destdir
		}
	}
}

Write-host Copy base folders -foregroundcolor green
#copypath $baseversionpath $baseversion
Write-host newversion base folders -foregroundcolor green
#copypath $newversionpath $newversion


function copylibs($base, $version){

	foreach($a in $arch){
		$src=$baseversionpath + "\" + $a + "fre\content\"
		foreach ($b in $libfolderlist){
			$srcpath=$src + $b + "_(" + $a + ")"
			$destdir = $templocation + "\" + $version + "\" +  $a + "fre\content\" + $b + "_(" + $a + ")"
			if($debug -eq 1 ) {write-host $destdir}
			robocopy $srcpath $destdir "/s"
		}

	}
}

Write-host Copy base folders -foregroundcolor green
copylibs $baseversionpath $baseversion
Write-host newversion base folders -foregroundcolor green
copylibs  $newversionpath $newversion



# Compare the folders 
Write-Host compare-folders -foregroundcolor green
if($debug -eq 1 ) {write-host $copy complete}

$fsofolder = $templocation + "\" + $baseversion
$fsoBUfolder= $templocation + "\" + $newversion
$fso = Get-ChildItem -Recurse -path $fsofolder
$fsoBU = Get-ChildItem -Recurse -path $fsoBUfolder

$whatschanged = Compare-Object -ReferenceObject $fso -DifferenceObject $fsoBU

If ($whatschanged -eq $null){
	Write-Host Nothing has changed -foregroundcolor green
} else {
	write-host What has changed  -foregroundcolor red
	write-host $whatschanged -foregroundcolor red
}

