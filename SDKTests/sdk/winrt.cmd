if %2.==. goto :base
if %1.==. goto :missing

:missing
Echo need to pass in the version of the build
Echo example 26100.2446.241104-1808

:headers

Header=\x86fre\kit_src\content\modern_shared_headers_onecoreuap_(x86)


goto :eof 




:base 
Echo base version is 26100.2446.241104-1808
set base=ge_release_svc_prod1
set base_version=26100.2446.241104-1808