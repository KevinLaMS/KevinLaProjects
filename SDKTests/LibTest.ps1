param($branch1, $version1, $branch2, $version2)
try{
    $linkinstalled = &link

    $branch1 = "ge_release_svc_prod3"
    $branch2 = "ge_release_svc_prod3"
    $version1= "26100.2454.241115-1734"
    $version2= "26100.3037.250123-2219"



    $dest1 = "c:\temp\deleteme\$branch1\$version1"
    $dest2 = "c:\temp\deleteme\$branch2\$version2"
    $temp="c:\temp\deleteme\temp.msi"

    $src="\\winbuilds\release\" + $branch1 + "\" + $version1 + "\amd64fre\kit_products\"
    $FlatLibs= Get-childItem -Path $src -filter    "*.msi" -Recurse

    ForEach ($lib in $FlatLibs){
        if ($lib.Name -like "*sdk*libs*") {
            write-host $lib.fullname
            if (test-path($temp)){remove-item $temp}
 
            subst /d J:
            subst j: $lib.path 
            $temp="j:\"+ $libname
 
            msiexec /a $temp /qb TARGETDIR=$dest1
 
           $process=get-process msiexec
           while (($process).count -gt 1){
               start-sleep -Seconds 5
               $process=get-process msiexec
           }

            
        }
    }
 
 
    write-host $libs


    if(-not(test-path ($dest1))){
        xcopy 
    }




} catch {
    Write-Host "This should be run in Dev Command environment."  -ForegroundColor Red
}




