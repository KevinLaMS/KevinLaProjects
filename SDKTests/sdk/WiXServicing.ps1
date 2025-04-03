
$list=@("\\winbuilds\release\ge_release_svc_im\26100.3478.250311-1929\x86fre\kit_bundles",
"\\winbuilds\release\zn_release_svc_im\25398.1487.250311-1927\x86fre\kit_bundles",
"\\winbuilds\release\fe_release_svc_im\20348.3329.250311-1927\x86fre\kit_bundles",
"\\winbuilds\release\ni_release_svc_im\22621.5040.250311-1927\other\kit_bundles",
"\\winbuilds\release\vb_release_svc_im\19041.5609.250311-1926\other\kit_bundles",
"\\winbuilds\release\rs5_release_svc_im\17763.7010.250311-1926\other\kit_bundles")

foreach ($e in $list) {
	$paths=$e + "\windowssdk\winsdksetup.exe"
	if ( -not(test-path($e))) {
		Write-host "ERROR: Missing $paths"   -foregroundcolor red

	} else {
		Write-host Found: $paths -foregroundcolor green
	}
}