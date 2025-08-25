$r = get-ChildItem -Recurse
$a=0
foreach ($4 in $r) {
	if ($4.FullName.length -gt $a) {$a = $4.FullName.length
	$name=$4.FullName
	if ($4.FullName.length -gt 250) {write-host $4.FullName.length $4.FullName -foregroundcolor red}
	}
}
write-host $name
write-host $a