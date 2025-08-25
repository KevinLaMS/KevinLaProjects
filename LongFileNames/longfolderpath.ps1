$counter=0
[string]$bigfile
while ($counter -lt 300){
    $bigfile=$bigfile+[string]$counter
    $bigpath=$bigpath + "\" + $counter 
    $counter++
}

$s="\temp\deleteme\lfn\" + $bigfile

md $s

$s="\temp\deleteme\lfn\" + $bigpath
md $s
