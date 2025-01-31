


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














param($destpath , $destpath3  ) 

 
 

$deltas = DiffDirectories ($destpath, $destpath3 )


