@echo off
:: BatchGotAdmin (Run as Admin code starts)

echo This application kills pc-client.exe, SmartAudio3.exe, and student.exe. These are the FollowMe Print Service, Bang and Olufsen Audio Service, and LanSchool respectively; these tasks are able to be closed and nothing will break. If this is the second time you see this message, press any key (The applications get closed the second time (Sorry, the way I get admin on this [to close the apps] does not allow it any other way) you do it) The apps may require a mouse-over in the system tray and notifacation area for them to dissapear.
pause

REM --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
	echo Requesting administrative privileges...
	goto UACPrompt
) else (
	goto gotAdmin
)

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
exit /B

:gotAdmin
if exist "%temp%\getadmin.vbs" (
	del "%temp%\getadmin.vbs"
)
pushd "%CD%"
CD /D "%~dp0"

:: BatchGotAdmin (Run as Admin code ends)

taskkill /im student.exe /f
taskkill /im pc-client.exe /f
taskkill /im SmartAudio3.exe /f
# taskkill /im sa3.exe /f
