; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "MedImage Server Add-on Resize"
#define MyAppShortName "Resize"
#define MyAppGitName "resize"
#define MyAppLCShortName "resize"
#define MyAppVersion "0.1.0"
#define MyAppPublisher "AtomJump"
#define MyAppURL "http://medimage.co.nz"
#define MyAppExeName "winstart-browser.bat"

#define MyAppIcon "medimage.ico"

#define NSSM "nssm.exe"
#define NSSM32 "nssm-x86.exe"
#define NSSM64 "nssm.exe"
#define NODE64 "node-v4.2.6-x64.msi"
#define NODE "node-v4.2.6-x64.msi"


;Change this dir depending on where you are compiling from. Leave off the trailing slash
#define STARTDIR "C:\test\buildSoftwareMedImage\MedImage-Addons"
#define DEFAULTPHOTOSDIR "C:\medimage\photos"
#define DEFAULTAPPDIR "medimage\addons\resize"



[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{839177C5-0FC1-4E30-BF22-39D37A10556E}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=C:\{#DEFAULTAPPDIR}
DisableWelcomePage=no
DisableDirPage=no
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
;LicenseFile={#STARTDIR}\LICENSE.txt
OutputDir={#STARTDIR}
OutputBaseFilename={#MyAppShortName}Installer
SetupIconFile={#STARTDIR}\{#MyAppShortName}\winstaller\{#MyAppIcon}
Compression=lzma
SolidCompression=yes
UninstallDisplayIcon={#STARTDIR}\{#MyAppShortName}\winstaller\{#MyAppIcon}
PrivilegesRequired=admin



[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"


[Files]
Source: "{#STARTDIR}\{#MyAppShortName}\winstaller\{#MyAppIcon}"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#STARTDIR}\{#MyAppShortName}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files


[Icons]
 

; Here's an example of how you could use a start menu item for just Chrome, no batch file
;Name: "{group}\{#MyAppName}"; Filename: "{pf32}\Google\Chrome\Application\chrome.exe"; Parameters: "--app=http://localhost:5566 --user-data-dir=%APPDATA%\{#MyAppShortName}\"; IconFilename: "{app}\{#MyAppIcon}"


[Code]


function GetDir(Param: String);
begin
end;



procedure RegisterPreviousData(PreviousDataKey: Integer);
begin
end;


procedure BeforeMyProgInstall(S: String);
begin
end;

procedure DeinitializeSetup();
begin
  //Restart any existing services stopped in the BeforeMyProgInstall
end;

procedure ExecuteRealProgram();
var
    ResultCode: Integer;
begin
    if Exec(ExpandConstant('{pf64}\nodejs\node.exe'), ExpandConstant('{app}\install.js') + ' width=1200', '', SW_HIDE, ewWaitUntilTerminated, ResultCode)
    then
    begin
        if not (ResultCode = 0) then   
        begin
            MsgBox('Warning: There was a problem during installation.', mbCriticalError, MB_OK);
        end;
    end
    else 
    begin
        MsgBox('Warning: There was a problem during installation.', mbCriticalError, MB_OK);
    end;
end;



[Registry]


[Run]



; postinstall launch



; Write to config
Filename: "{sys}\net.exe"; WorkingDir: "{tmp}"; StatusMsg:"Trying to set your configuration. Please wait.";  AfterInstall: ExecuteRealProgram; Flags: runhidden runascurrentuser;


[UninstallRun]

; Remove all leftovers
Filename: "{sys}\rmdir"; Parameters: "-r ""{app}"""; Flags: runascurrentuser;