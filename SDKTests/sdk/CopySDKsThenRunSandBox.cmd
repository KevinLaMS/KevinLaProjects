
@echo off
Echo Server  \\winbuilds\release\ge_release_svc_prod3\
Set sandbox="c:\users\kevinla\source\repos\winget-pkgs\Tools\SandboxTest.ps1"

if %1.==. goto :MissingBuild1
if %2.==. goto :MissingBuild2


goto :CopyBits

:MissingBuild1
Echo Missing baseline. It was 26100.1882.240927-1745
Goto :eof 

:MissingBuild2
dir \\winbuilds\release\ge_release_svc_prod3 /b
echo \\ntdev\Release\ge_release_svc_prod3\26100.2454.241115-1734 
Goto :eof 

:CopyBits
Echo looking for bits
if NOT exist c:\temp\sdk\packages\%1 (
    Echo copying baseline
    xcopy \\winbuilds\release\ge_release_svc_prod3\%1\amd64fre\kit_crossarch\bundles\KIT_BUNDLE_WINDOWSSDK_MEDIACREATION c:\temp\sdk\packages\%1 /s /i 
    rem z:\ge_release_svc_prod3\26100.2454.241115-1734\amd64fre\kit_crossarch\bundles\KIT_BUNDLE_WINDOWSSDK_MEDIACREATION
)
if NOT exist c:\temp\sdk\packages\%2 (
    
    Echo copying Diff
    xcopy \\winbuilds\release\ge_release_svc_prod3\%2\amd64fre\kit_crossarch\bundles\KIT_BUNDLE_WINDOWSSDK_MEDIACREATION c:\temp\sdk\packages\%2 /s /i 

)

echo rem write script to compare > go.cmd
echo .\packages\%1\winsdksetup.exe /q >> go.cmd
echo if %errorlevel%.==.0 ( >> go.cmd
    echo xcopy "c:\program files (x86)\windows kits\10" "C:\temp\sdk\%1" >> go.cmd
    echo Winget uninstall "windowssdk" >> go.cmd
    echo pause >> go.cmd
echo ) >> go.cmd
echo .\packages\%2\winsdksetup.exe /q >> go.cmd
echo if %errorlevel%.==.0 ( >> go.cmd
        echo xcopy "c:\program files (x86)\windows kits\10" "C:\temp\sdk\%1" >> go.cmd

    echo pause >> go.cmd
echo ) >> go.cmd

echo %sandbox% 

rem powershell %sandbox%