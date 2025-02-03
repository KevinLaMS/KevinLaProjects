if %1. ==. goto :needurl
Echo to be run in a devbox

winget configure samples.winget

echo clone powertoys in VS
Pause

Echo change powertoys to use new SDK

echo launch Dev cmd
pause 

echo Build with passing in new path to SDK, specify architecture
pause

echo Update powertoys to use new code

Echo run signing test
pause

Echo run WACK test on store sample
pause

Echo Submit sample to store
pause

goto :end
:needurl
Echo pass in url
echo https://download.microsoft.com/download/5/d/6/5d6636b7-f66a-4baf-bcd0-c663626c738d/Installers/winsdksetup.exe