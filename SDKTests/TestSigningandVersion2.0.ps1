unction GetProgramOutput([string]$exe, [string]$arguments, [string]$tool)
{

$toolpath  = '"' + $tool + '"'
$var = $arguments + '"' + $tool +'"'
# write-host ARGUMENTS $arguments
# write-host strings VAR $var
# $var='verify /pa /v "c:\program files (x86)\windows kits\10\bin\10.0.26100.0\x64\signtool.exe"'
# write-host compare vare  $var
    $process = New-Object -TypeName System.Diagnostics.Process
    $process.StartInfo.FileName = "$exe"
#   $process.StartInfo.Arguments = $arguments

    $process.StartInfo.Arguments = $var
   
    $process.StartInfo.UseShellExecute = $false
    $process.StartInfo.RedirectStandardOutput = $true
    $process.StartInfo.RedirectStandardError = $true
    $process.Start()
   
    $output = $process.StandardOutput.ReadToEnd()  
    $err = $process.StandardError.ReadToEnd()
   
    $process.WaitForExit()
   
    $output
    $err
}


   
# $exe ="C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\signtool.exe"

# $exe="c:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x86\signtool.exe"  
# $arguments ='verify /pa /v "c:\Program Files (x86)\Windows Kits\10\bin\10.0.15063.0\x64\GenXBF.dll"'
   
# $runResult = (GetProgramOutput $exe $arguments)
# $stdout = $runResult[-2]
# $stderr = $runResult[-1]
  #   pause
# [System.Console]::WriteLine("Standard out: " + $stdout)
# [System.Console]::WriteLine("Standard error: " + $stderr)


























function RunSigning() {
      $kitsroot="C:\Program Files (x86)\Windows Kits\10\"
      $signtool="C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\signtool.exe"
      $catdir="C:\Program Files (x86)\Windows Kits\10\catalogs"
     
      pushd $kitsroot
      $exefiles=get-childitem  -filter "*.exe" -Recurse
      $dllfiles=get-childitem  -filter "*.dll" -Recurse



      ##########################################
      function VersionCheck ($exe) {
            $exefullpath = $exe.fullname
            $fileVersion = (Get-Item $exefullpath).VersionInfo.FileVersion
            if ($fileVersion -lt 1) {
                  Write-Host "Error" $exefullpath $fileVersion -foregroundcolor red
                  "$exefullpath $fileVersion"   | out-file  -filepath $Global:LogFilePath  -append

            }
      }
      ##########################################

      function Signing ($exe ) {
            $exefullpath = $exe.fullname
          # Write-host testing $Signtool verify /pa /v $exe.fullname

 
$arguments ="verify /pa /v "
 
   
$runResult = (GetProgramOutput $Signtool $arguments $exe.fullname)
$stdout = $runResult[-2]
$stderr = $runResult[-1]

# write-host $stdout
# write-host ERROR $stderr




   #         $signresults = & $Signtool verify /pa /v $exe.fullname  
            if (-not($stdout -like "*Number of errors: 0*")) {

# write-host $signresults -foregroundcolor yellow

                  Write-Host "Error Not Signed" $exefullpath $fileVersion -foregroundcolor red
            if ( $stderr -like "*A certificate chain processed, but terminated in a root*") {
                  $Global:BadCert+=$exefullpath
                  write-host "bad cert" -foregroundcolor red
                  return "null"
                  
            }
                  return $exefullpath

            }
      }
      ##########################################

      "========================================" | out-file  -filepath $Global:LogFilePath  -append
      "===== Missing or bad Version  ================"  | out-file  -filepath $Global:LogFilePath  -append

      foreach ($exe in $exefiles)   {VersionCheck $exe }
      foreach ($dll in $dllfiles)   {VersionCheck $dll }
      $unsigned=@()
      $catalogsignedonly=@()
      $notcatalogsigned=@()
      foreach ($exe in $exefiles)   {
            # write-host  "signing $exe"
            $return= Signing $exe
            if (-not($return -eq "null")){$unsigned+=$return}

             }
      foreach ($dll in $dllfiles)   {

            $return= Signing $dll
            if (-not($return -eq "null")){$unsigned+=$return}
      }

      # write-host $unsigned
      $unsigned+=$signtool
      #####################  
      # Test for catalog signed
      pushd $catdir

      $catfiles=get-childitem  -filter "*.cat" -Recurse
      foreach ($unsignedfile in $unsigned ) {
          $previous="Just a flag to prevent duplicates"
 
            $catflag="FALSE"
          $vcnt=0
            while ($vcnt -lt  $catfiles.count) {
            # write-host $Signtool
            # write-host $Signtool verify /v /c $catfiles[$vcnt].fullname $unsignedfile
                  $signresults = & $Signtool verify /v /c $catfiles[$vcnt].fullname $unsignedfile
                  if ($signresults -like "*File is signed in catalog*") {
                        Write-Host $unsignedfile is catalog signed -foregroundcolor green
                        $catflag="TRUE"
                  $vcnt =  $catfiles.count +1
                            
                  }
            if ($catflag -eq "TRUE") {$catalogsignedonly+=$unsignedfile}
            else {
                  if (-not($previous -eq $unsignedfile)) {
                        $notcatalogsigned+=$unsignedfile
                        $previous=$unsignedfile
                  }
          }

          $vcnt++
            }
     
      }

      "========================================" | out-file  -filepath $Global:LogFilePath  -append
       "=====Catalog Signed Only================"  | out-file  -filepath $Global:LogFilePath  -append

      foreach ($file in $catalogsignedonly) {
            Write-Host Catalog signed only $file -foregroundcolor green
            $file | out-file  -filepath $Global:LogFilePath  -append
      }
      "========================================" | out-file  -filepath $Global:LogFilePath  -append
      "=====Unsigned Only================" | out-file  -filepath $Global:LogFilePath  -append

      foreach ($file in $notcatalogsigned) {
            Write-Host Unsigned $file -foregroundcolor red
            $file | out-file  -filepath $Global:LogFilePath  -append
      }
}

popd


$url="https://download.microsoft.com/download/3/b/d/3bd97f81-3f5b-4922-b86d-dc5145cd6bfe/windowssdk/winsdksetup.exe"
$url="https://download.microsoft.com/download/a/f/2/af287d69-2c0a-4320-9d0f-555d5be767b9/winsdksetup.exe"
$dest="c:\temp\setup.exe"
$Global:LogFilePath="C:\temp\results.txt"
if (test-path ($Global:LogFilePath)) {remove-item $Global:LogFilePath}
$Global:BadCert=@()
$Global:BadCert+="============= BAD CERTS ==============="

write-host  "&curl $url -o c:\temp\setup.exe"
&curl $url -o $dest

if (test-path ($dest) ){
     & $dest "/q"

      while ((get-process "winsdksetup").ProcessName){
            Write-Host "Waiting on finish"
            start-sleep -seconds 60
      }



}

## Burn Version
# This code looks at LOG files and verifies that the burn version is correct.
$LogFilePath = $env:Temp + "\windowssdk"

pushd $LogFilePath
$burn=(get-childitem -recurse | select-string "burn" -List ) -split " "
$count=0
      While($count -lt $burn.count) {
     
            if ($burn[$count] -eq "Burn") {$burntemp=$burn[($count +1)]
                  $BurnVersion= ($burntemp -split ",")[0]
                  break
            }
      $count++
      }
if ($BurnVersion -lt "3.14.1") {write-host "MSRC Version Fail, $BurnVersion" -foregroundcolor red
      pause
      } Else   {write-host "MSRC Version PASS, $BurnVersion" -foregroundcolor green

            RunSigning
      }

popd

 

      foreach ($file in $Global:BadCert) {

            $file | out-file  -filepath $Global:LogFilePath  -append
      }