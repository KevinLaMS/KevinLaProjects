$GE_Prerelease="\\winbuilds\release\ge_prerelease_im\"
$GE_Prod="\\winbuilds\release\ge_release_svc_prod3\"
$server3

$missingfile=@()
$badsymbol=@()

$folder=get-childitem -path   $GE_Prerelease | select -last 10
#findappxsip
Foreach ($v in $folder ){
    $verarch=$v.name + "\amd64fre\"
    $file="kit_src\content\sdk_modern_tools\x64\appxpackaging.dll "

    $tool="c:\Program Files (x86)\Windows Kits\10\Debuggers\x64\symchk.exe " 
    $options="/v "
    $symbols=" /s https://msdl.microsoft.com/download/symbols"

    $filename=$ge_prerelease + $verarch + $file 

    $command =   $options + $filename + $symbols

    # Write-host "&c:\Program Files (x86)\Windows Kits\10\Debuggers\x64\symchk.exe   $filename $symbols"
    Write-host checking $filename
    $result =  &"c:\Program Files (x86)\Windows Kits\10\Debuggers\x64\symchk.exe"   $filename  "/s" https://msdl.microsoft.com/download/symbols

    if ($result -like "*FAILED files = 1*") {
            write-host Bad Symbol: $filename -foregroundcolor  red 
            $badsymbol+=$filename

    }
    if ($result -like "*SYMCHK: FAILED files = 0*" -and $result -like "*SYMCHK: PASSED + IGNORED files = 0*") {
        write-host File not available: $filename -foregroundcolor red
        $missingfile+=$filename
    }
    Write-host $result

}

$folder=get-childitem -path   $GE_Prod | select -last 10
#findappxsip
Foreach ($v in $folder ){
    $verarch=$v.name + "\amd64fre\"
    $file="kit_src\content\sdk_modern_tools\x64\appxpackaging.dll "

    $tool="c:\Program Files (x86)\Windows Kits\10\Debuggers\x64\symchk.exe " 
    $options="/v "
    $symbols=" /s https://msdl.microsoft.com/download/symbols"

    $filename=$GE_Prod + $verarch + $file 

    $command =   $options + $filename + $symbols

    Write-host checking $filename
    
    $result =  &"c:\Program Files (x86)\Windows Kits\10\Debuggers\x64\symchk.exe"   $filename  "/s" https://msdl.microsoft.com/download/symbols

    if ($result -like "*FAILED files = 1*") {
            write-host Bad Symbol:  $filename -foregroundcolor  red 
            $badsymbol+=$filename
    }
    if ($result -like "*SYMCHK: FAILED files = 0*" -and $result -like "*SYMCHK: PASSED + IGNORED files = 0*") {
        write-host File not available: $filename -foregroundcolor red
        $missingfile+=$filename
    }
    Write-host $result

}
Write-host Bad Symbols -foregroundcolor red
foreach ($row in $badsymbol) {Write-host $row }
Write-host Missing File -foregroundcolor red
foreach ($row in  $missingfile ) {Write-host $row  }
