If (test-path ("c:\temp\msix\success.txt ")){remove-item "c:\temp\msix\success.txt " }
If (test-path ("c:\temp\msix\error.txt ")){remove-item "c:\temp\msix\error.txt " }

$list= Get-content "c:\temp\msix.files.txt"

# Group files by application and select the biggest version
$grouped = @{}
foreach ($yaml in $list) {
	# Extract version from path (assumes ...\publisher\application\version\...)
	$parts = $yaml -split '\\'
	if ($parts.Length -ge 7) {
		$publisher = $parts[-4]
		$application = $parts[-3]
		$version = $parts[-2]
		$key = "$publisher|$application"
		if (-not $grouped.ContainsKey($key)) {
			$grouped[$key] = @()
		}
		$grouped[$key] += @{yaml=$yaml; version=$version}
	}
}

# Function to compare version strings
function Get-MaxVersion($items) {
	return $items | Sort-Object {
		[Version]($_.version)
	} -Descending | Select-Object -First 1
}

foreach ($key in $grouped.Keys) {
	$maxItem = Get-MaxVersion $grouped[$key]
	$yaml = $maxItem.yaml
	Write-Host "Processing $yaml (version $($maxItem.version))"
	c:\temp\msix\LOADYAML.PS1 $yaml
}
