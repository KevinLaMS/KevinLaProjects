
$YamlFiles = get-ChildItem -path "c:\users\kevinla\source\repos\winget-pkgs\manifests" -Recurse


#look for URL
foreach ($file in $YamlFiles){
    #Get folder 
    #get parent folder
    #only test one file

    if ($file.name -like "*installer*" ){
        $mani = $file
        $directory = (get-item $file.FullName).Directory.Parent.FullName
        $list = get-ChildItem $directory
        $holdname=""
        Foreach ($DirName in $list){
               # $DirName.name
                if ($DirName.name -gt $HoldName.name){
                    $manifest=$mani
                    $holdName = $DirName

                }
        }

 
        # Write-Host folder to test $HoldName.FullName
    }
   
    $manifest[0]




}