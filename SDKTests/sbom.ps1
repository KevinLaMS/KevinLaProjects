$base="\\winbuilds\release\ge_current_directes\26473.1000.250819-1606\"
$SBomPath="\amd64fre\kit_crossarch\sbom\KIT_BUNDLE_WINDOWSSDK_SBOM_MEDIACREATION\windowssdk\"

$url = $base + $SBomPath

 

$sbomtext = "c:\temp\bigassfile.txt"
Write-host Getting SBOM data
$sbom = get-childitem $url -recurse -file  -Filter "*.json"


$kit =  "c:\Program Files (x86)\Windows Kits\10\"
$kit =  "c:\Program Files (x86)\Windows Kits\10\"
cd
$didnotfile=[System.Collections.ArrayList]@()
$items = get-childitem $kit -recurse -file  

foreach ($file in $items ){
   # write-host Looking for $file.name
    $target="*" + $file.name + "*"

    # write-host $target -foregroundcolor cyan

    foreach ($sbomitem in $sbom) {
  
        #$sbomitem.fullname
        #write-host $sbomitem -foregroundcolor green
        $content = get-content ($sbomitem.fullname)
        # write-host CONTENT $content
        #write-host Looking for $file.name  in $sbomitem.fullname
        #write-host      $target 
        if ($content -like $target) {#write-host SBOM covered -foregroundcolor green
            $success = 1
            Break
        } else {
            $success = 0 
        }
    }
    if ($success -eq 1){
        write-host $file.name $sbomitem -foregroundcolor blue
    } else{
        write-host did not find file $file.name -foregroundcolor red
        $didnotfile += [string]$file.name
      

 
       

    }
     

}
write-host $didnotfile | out-file "c:\temp\MissingSBOMFiles.txt"