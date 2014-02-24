msg * Please ensure that you save the file in c:\Documents And Settings\Administrator\Desktop\ .Manually install otherwise
"c:\Program Files\Internet Explorer\iexplore.exe" "http://www.sliksvn.com/pub/Slik-Subversion-1.7.1-win32.msi"
SET MSIArgs=/qn /norestart REBOOT=ReallySuppress
MSIEXEC.EXE /I "c:\Documents And Settings\Administrator\Desktop\Slik-Subversion-1.7.1-win32.msi"  %MSIArgs% /l install.log
SET RepoPath=https://jboutelle.svn.cvsdude.com/conversion/branches/stable/win-factory/
SET CheckDir=c:\svndir
mkdir %CheckDir%
"C:\Program Files\SlikSvn\bin\svn.exe" co --username ssadmin --password d3vo9s %RepoPath% %CheckDir%
"c:\svndir\Binaries\SaveAsPDFandXPS.exe"
xcopy /i /s "c:\svndir\Binaries" "c:\Binaries"
copy "c:\svndir\Binaries\cleanTemp.bat"  "c:\Documents And Settings\Administrator\Desktop\"
schtasks /create /tn "Clean pptfactory temp" /tr "c:\Binaries\cleanTemp.bat" /sc weekly /st 04:42:00 /ru System
mkdir "D:\ConFac"
mkdir "D:\ConFac\conversion"
mkdir "D:\ConFac\jobs"
mkdir "D:\Temp"
mkdir "D:\ConFac\logs"
"c:\Binaries\ConsoleApplication1.exe"

