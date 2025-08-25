function TestApp ($CppWinRT){
   
    $app = $CppWinRT[0]
    $arch = $CppWinRT[1]
    $likestring = $CppWinRT[2]


    $basepath="C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\"
    $toolpath=$basepath + $arch + "\" + $app

    $runresults = & $toolpath
    # write-host $runresults -foregroundcolor blue

    if ($runresults -like "*$likestring*") {
            Write-host PASS $app $arch -foregroundcolor green
    } else {
        Write-host FAIL $app $arch -foregroundcolor red
        write-host $runresults
        return $app  
    }
}

$errorreport=@()
$skipped=@()
$CppWinRT=@("cppwinrt.exe","chpe","Windows metadata to include in projection")
$errorreport+=TestApp $CppWinRT
 
$CppWinRT=@("cppwinrt.exe","x64","Windows metadata to include in projection")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("cppwinrt.exe","x86","Windows metadata to include in projection")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("adpcmencode3.exe","x86","ERROR: Must specify two filenames.")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("adpcmencode3.exe","x64","ERROR: Must specify two filenames.")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("betest.exe","x86","This version of BETest only runs on Windows 8 and Windows")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("betest.exe","x64","This version of BETest only runs on Windows 8 and Windows")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("cert2spc.exe","x86","Usage: Cert2Spc")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("cert2spc.exe","x64","Usage: Cert2Spc")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("computerhardwareids.exe", "x86","Using the BIOS to gather information")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("computerhardwareids.exe", "x64","Using the BIOS to gather information")
$errorreport+=TestApp $CppWinRT
#$CppWinRT=@("convert-moftoprovider.exe", "x86","Try 'Convert-MofToProvider.exe -help' for usage")
$skipped+="convert-moftoprovider.exe"
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("ctrpp.exe", "x86", "Generate customized notification callback template")
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("dxc.exe","x86","Required input file argument is missing. use -help to get more information.")
$skipped+="dxc"
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("extidgen.exe","x86","dwExtensionID0")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("filtdump.exe","x86","Usage: FiltDump")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("filtreg.exe","x86","Filters loaded by extension:")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("ftquery.exe","x86","mymachine.systemindex")
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("fxc.exe","x86","No files specified, use /? to get usage information")
$skipped+="fxc"
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("gc.exe","x86","Compile SAPI XML grammars only")
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("genmanifest.exe","x86","genmanifest manifestconfig.mcf")
$skipped+="genmanifest.exe"
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("ifilttst.exe","disables logging.")
$skipped+="ifilttst.exe"
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("isxps.exe","x86","Only validate against the OPC specification")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("makeappx.exe","x86","pack        --  Create a new app package from files on disk")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("makecat.exe","x86","return fail even on recoverable errors")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("MakeCert.exe","x86","The signing authority of the certificate")
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("makepri.exe","x86","resourcepack")
$skipped+="makepri.exe"
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("mbidgenerator.exe","x64","Usage: MBIDGenerator")
$skipped+="mbdigenerator.exe"
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("mc.exe","x64","Message Compiler")
$skipped+="mc.exe"
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("mdmerge.exe","x64"," -v: Validate - Validate metadata type references")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("mftrace.exe","x64","mftrace.exe wmplayer.exe Bear.wmv")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("midl.exe","x64","midl : command line error MIDL1000 : missing source-file name")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("midlc.exe","x64","midl : error MIDL2407 : no intermediate file specified: use midl.exe")
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("midlrt.exe","x64","missing source-file name")
$skipped+="midlrt.exe"
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("msicert.exe","x86","The default behavior is to populate the MsiDigitalSignature")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("msifiler.exe","x86","specifies an alternative directory to find files")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("MsiInfo.exe","x86","MsiInfo.exe {database} Options.... --> To Set Summary Info Properties")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("Msimerg.exe","x86","Msi Merge Tool --- Merge Two Databases")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("MsiMsp.exe","x86"," Windows Installer patch creation tool.")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("MsiTran.exe","x86","Error 1. Msi Transform Tool --- Generate and Apply Transform Files")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("mt.exe","x64","[ -manifest <manifest1 name> <manifest2 name> ... ]")
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("muirct.exe","x64","source_filename")
$skipped+="muirct.exe"
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("PackageEditor.exe","x64","PackageEditor createDelta -bp <baseline package> -up <updated")
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("pktextract.exe","x64","option is not given")
$skipped+="pkextract.exe"
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("pvk2pfx.exe","x64","Side-By-Side Public Key Token Extractor")
$skipped+="pvk2pfx.exe"

$errorreport+=TestApp $CppWinRT
$CppWinRT=@("regwinmd.exe","x64","icrosoft(R) RegWinMD Utility Version 10.0.0.")
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("signtool.exe","x64","SignTool Error: A required parameter is missing.")
$skipped+="signtool.exe"
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("tracefmt.exe","x64","Searching for TMF files on path")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("tracelog.exe","x64","Configure PMC counter sampling on kernel events")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("tracepdb.exe","x64","TracePDB.Exe (")
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("tracewpp.exe","x64","General behavior:")
$skipped+="tracewpp.exe"
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("uicc.exe","x86","Microsoft (R) Ribbon Markup Compiler")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("uuidgen.exe","x86","????????-????-????-????-")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("vshadow.exe","x64","List all shadow copies in the system")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("vssagent.exe","x64","List all vss diagnose parameters")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("vstorcontrol.exe","x64","install   - Installs the Virtual Storage Driver")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("vswriter.exe","x64","Format: vswriter.exe <config-file>")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("WinAppDeployCmd.exe","x64","WinAppDeployCmd devices 10")
$errorreport+=TestApp $CppWinRT
# $CppWinRT=@("winmdidl.exe","x64","Metadata IDL Generation Utility")
$skipped+="winmdidl.exe"
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("wsdcodegen.exe","x64","Directs WsdCodeGen to generate source code")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("wstracedump.exe","x64","Usage : wstracedump")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("wstraceutil.exe","x64","Usage : WsTraceUtil.exe")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("wsutil.exe","x64","Do not produce summary after processing. When combined")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("xpsanalyzer.exe","x64","XpsAnalyzer /Directory:c:\test")
$errorreport+=TestApp $CppWinRT
$CppWinRT=@("xpsconverter.exe","x64","XpsConverter /OpenXPS /InputFile=Test.xps /OutputFile=Test.oxps")
$errorreport+=TestApp $CppWinRT
#$CppWinRT=@("xpsconverter.exe","x64","kevins")
$errorreport+=TestApp $CppWinRT

Write-Host These Apps failed
Write-host $errorreport -foregroundcolor red

Write-Host These Apps Skipped
Write-host $skipped -foregroundcolor Yellow

$a=" UI APPs

C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\accevent.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\cameraprofiletool.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\ComparePackage.exe
dep0loyutil
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\dxcapsviewer.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\espexe.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\filetypeverifier.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\gamesaveutil.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\graphedt.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\inspect.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\jsconstraintdebug.exe
TestApp $CppWinRT
$CppWinRT=@(

C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\oleview.exe","x64","
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\rc.exe","x64","



C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\SkTool.exe","x64","
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\TB3x.exe","x64","
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\topoedit.exe","x64","

C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\traceview.exe","x64","

C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\uuidgen.exe","x64","
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\veiid.exe","x64","
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\vsdiagview.exe","x64","


C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\vsstrace.exe","x64","

C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\wsddebug_client.exe","x64","
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\wsddebug_host.exe","x64","

C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\AccChecker\AccCheckConsole.exe","x64","
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\AccChecker\acccheckui.exe","x64","
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x64\UIAVerify\VisualUIAVerifyNative.exe","x64","
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\accevent.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\adpcmencode3.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\betest.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\cameraprofiletool.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\cert2spc.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\certmgr.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\ComparePackage.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\computerhardwareids.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\convert-moftoprovider.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\cppwinrt.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\ctrpp.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\DeployUtil.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\dxc.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\dxcapsviewer.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\espexe.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\extidgen.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\filetypeverifier.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\filtdump.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\filtreg.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\ftquery.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\fxc.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\gc.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\genmanifest.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\graphedt.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\ifilttst.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\inspect.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\isxps.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\makeappx.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\makecat.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\MakeCert.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\makepri.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\mbidgenerator.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\mc.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\mdmerge.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\mftrace.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\midl.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\midlc.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\midlrt.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\MsiCert.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\MsiDb.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\MsiFiler.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\MsiInfo.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\Msimerg.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\MsiMsp.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\MsiTran.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\mt.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\muirct.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\oleview.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\PackageEditor.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\pktextract.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\pvk2pfx.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\rc.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\regwinmd.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\signtool.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\TB3x.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\topoedit.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\tracefmt.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\tracelog.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\tracepdb.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\traceview.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\tracewpp.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\uicc.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\uuidgen.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\vsdiagview.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\vshadow.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\vssagent.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\vsstrace.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\vstorcontrol.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\vswriter.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\WiLogUtl.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\WinAppDeployCmd.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\winmdidl.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\wsdcodegen.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\wsddebug_client.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\wsddebug_host.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\wstracedump.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\wstraceutil.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\wsutil.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\xpsanalyzer.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\xpsconverter.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\AccChecker\AccCheckConsole.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\AccChecker\acccheckui.exe
C:\Program Files (x86)\Windows Kits\10\bin\10.0.26100.0\x86\UIAVerify\VisualUIAVerifyNative.exe"

