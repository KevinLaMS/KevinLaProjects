


# COMPARE TWO DIRECTORIES RECURSIVELY #
# RETURNS LIST OF @{RelativePath, Hash, FullName}
function DiffDirectories {
  [CmdletBinding()]
  param (
    [parameter(Mandatory=$TRUE,Position=0,HelpMessage="Directory to compare left.")]
    [alias("l")]
    [string]$LeftPath,

    [parameter(Mandatory=$TRUE,Position=1,HelpMessage="Directory to compare right.")]
    [alias("r")]
    [string]$RightPath
  )
  PROCESS {
    $LeftHash = GetFilesWithHash $LeftPath
    $RightHash = GetFilesWithHash $RightPath
    diff -ReferenceObject $LeftHash -DifferenceObject $RightHash -Property RelativePath,Hash
  }
}

### END FUNCTION DEFINITIONS ###

### PROGRAM LOGIC ###

if($Compare.length -ne 2) {
  Print -x "Compare requires passing exactly 2 path parameters separated by comma, you passed $($Compare.length)." -f
}
Print "Comparing $($Compare[0]) to $($Compare[1])..." -a 1
$LeftPath   = RequirePath path/to/left $Compare[0] container
$RightPath  = RequirePath path/to/right $Compare[1] container
$Diff       = DiffDirectories $LeftPath $RightPath
$LeftDiff   = $Diff | where {$_.SideIndicator -eq "<="} | select RelativePath,Hash
$RightDiff   = $Diff | where {$_.SideIndicator -eq "=>"} | select RelativePath,Hash
if($ExportSummary) {
  $ExportSummary = ResolvePath path/to/summary/dir $ExportSummary
  MakeDirP $ExportSummary
  $SummaryPath = Join-Path $ExportSummary summary.txt
  $LeftCsvPath = Join-Path $ExportSummary left.csv
  $RightCsvPath = Join-Path $ExportSummary right.csv

  $LeftMeasure = $LeftDiff | measure
  $RightMeasure = $RightDiff | measure

  "== DIFF SUMMARY ==" > $SummaryPath
  "" >> $SummaryPath
  "-- DIRECTORIES --" >> $SummaryPath
  "`tLEFT -> $LeftPath" >> $SummaryPath
  "`tRIGHT -> $RightPath" >> $SummaryPath
  "" >> $SummaryPath
  "-- DIFF COUNT --" >> $SummaryPath
  "`tLEFT -> $($LeftMeasure.Count)" >> $SummaryPath
  "`tRIGHT -> $($RightMeasure.Count)" >> $SummaryPath
  "" >> $SummaryPath
  $Diff | Format-Table >> $SummaryPath

  $LeftDiff | Export-Csv $LeftCsvPath -f
  $RightDiff | Export-Csv $RightCsvPath -f
}
$Diff
SafeExit














param($branch="ge_release_svc_prod3", $build="26100.2454.241115-1734", $baseline_branch="ge_release_svc_prod1", $baseline_build="26100.1742.240904-1906")


$build=get-childitem "\\winbuilds\release\ge_release_svc_prod1" | sort lastwritetime | select -last 1


$amd="amd64fre"
$x86="x86fre"
$kit="kit_src\content"

$dest="c:\temp\deleteme\compare\" + $build
$dest2="c:\temp\deleteme\compare\" + $base_build

$test=2
 


if (test-path($dest)){remove-item $dest -recurse}
if (test-path($dest2)){$baseok = $true}

$HeaderArray=@('CppWinRT_Headers', 'Debuggers_SDK_Headers', 'desktop_shared_headers_(x86)', 'Desktop_User_Mode_Headers_(x86)', 'Desktop_Windows_Runtime_Headers_(x86)', 'Modern_Shared_Headers_OnecoreUAP_(x86)', 'Modern_User_Mode_Headers_(x86)', 'Modern_Windows_Runtime_Headers_(x86)', 'Shared_Headers_OnecoreUAP_(x86)', 'Universal_CRT_Headers'
)
$HeaderArray+="uap_contracts"

	foreach ($headerfolder in $HeaderArray) {
		write-host "Copying  $headerfolder"
		$destpath=$dest + "\" + $x86 + "\" +  $headerfolder
		$destpath2=$dest + "\" + $amd + "\" +  $headerfolder
		$folder="\\winbuilds\release\" + $branch + "\" + $build + "\" + $x86 + "\" + $kit + "\" + $headerfolder 
		$folder2="\\winbuilds\release\" + $branch + "\" + $build + "\" + $amd + "\" + $kit + "\" + $headerfolder 
		Write-host looking for $folder
		if (test-path($folder)) {if($test -eq 1) {copy-item -path $folder -destination $destpath -recurse}}
		Write-host looking for $folder2
		if (test-path($folder2)) {if($test -eq 1){copy-item -path $folder2 -destination $destpath2 -recurse}}
		
		if ($baseok -eq $false) 
			{
				$destpath3=$dest2 + "\" + $x86 + "\" +  $headerfolder
				$destpath4=$dest2 + "\" + $amd + "\" +  $headerfolder
				$folder3="\\winbuilds\release\" +  $baseline_branch + "\" + $baseline_build + "\" + $x86 + "\" + $kit + "\" + $headerfolder 
				$folder4="\\winbuilds\release\" +  $baseline_branch + "\" + $baseline_build + "\" + $amd + "\" + $kit + "\" + $headerfolder 


				if (test-path($folder3)) {if($test -eq 1){copy-item -path $folder3 -destination $destpath3 -recurse}}
				if (test-path($folder4)) {if($test -eq 1){copy-item -path $folder4 -destination $destpath4 -recurse}}
			}
	

}

 

$deltas = DiffDirectories ($destpath, $destpath3 )


