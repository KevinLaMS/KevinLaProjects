rem write script to compare 
.\packages\26100.1882.240927-1745\winsdksetup.exe /q 
if 0.==.0 ( 
xcopy "c:\program files (x86)\windows kits\10" "C:\temp\sdk\26100.1882.240927-1745" 
Winget uninstall "windowssdk" 
pause 
) 
.\packages\26100.2454.241115-1734\winsdksetup.exe /q 
if 0.==.0 ( 
xcopy "c:\program files (x86)\windows kits\10" "C:\temp\sdk\26100.1882.240927-1745" 
pause 
) 
