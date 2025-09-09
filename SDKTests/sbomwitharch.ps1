$base="\\winbuilds\release\ge_current_directes_kits\26476.1000.250827-0231\"
$SBomPath="amd64fre\kit_crossarch\sbom\KIT_BUNDLE_WINDOWSSDK_SBOM_MEDIACREATION\windowssdk\"
#ge_current_directes_kits\26476.1000.250827-0231\amd64fre\kit_crossarch\sbom

$url = $base + $SBomPath



$sbomtext = "c:\temp\bigassfile-nowack.txt"
Write-host Getting SBOM data
$sbom = get-childitem $url -recurse -file  -Filter "*.json"


$kit =  "c:\Program Files (x86)\Windows Kits\10\"


pushd $kit 
$didnotfile=[System.Collections.ArrayList]@()
$items = get-childitem $kit -recurse -file  

foreach ($file in $items ){
   # write-host Looking for $file.name

    $relativepath = $file.directory.name + "/" + $file.name
    $target="*" + $relativepath + "*"
    # write-host $target -foregroundcolor cyan

    foreach ($sbomitem in $sbom) {
  

        #$sbomitem.fullname
        #write-host $sbomitem -foregroundcolor green
        $content = get-content ($sbomitem.fullname)
        #write-host CONTENT $content
        #write-host Looking for $file.name  in $sbomitem.fullname

      
        if ($content -like $target) {#write-host SBOM covered -foregroundcolor green
            $success = 1
            Break
        } else {
            $success = 0 
        }
    }
    if ($success -eq 1){
        write-host $file.name   -foregroundcolor blue
    } else{
 
        $didnotfile += [string]$file.name +";" 
        write-host did not find file $target -foregroundcolor red
      

 
       

    }
     

}
write-host $didnotfile | out-file "c:\temp\MissingSBOMFiles.txt"
popd