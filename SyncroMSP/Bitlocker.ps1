#TODO - Make sure you setup a custom field Bitlocker_Key_<drive>" for each drive as a "Text Field".
#Repeat for "Bitlocker Volume Status", "Bitlocker Protection Status" and "Bitlocker Encryption %" 
# Syncro Device asset type. Assets -> Manage Types -> Syncro Device -> New Field.
# Based on the Syncro Staff product keys script.

Import-Module $env:SyncroModule

#Query all the ID's and Keys and place into variable
$C_Drive_Status = (Get-BitLockerVolume -MountPoint C) |  Select-Object -Property VolumeStatus,EncryptionPercentage,ProtectionStatus
$C_Drive = (Get-BitLockerVolume -MountPoint C).KeyProtector | where {$_.RecoveryPassword -ne ""} | Select-Object -Property KeyProtectorID,RecoveryPassword

#Gets keys from Variable
[string] $KeyProtectorIDC = $C_Drive.KeyProtectorID
[string] $RecoveryPasswordC = $C_Drive.RecoveryPassword

#Add status to Syncro
Set-Asset-Field -Subdomain "xxxx" -Name "Bitlocker Volume Status" -Value $C_Drive_Status.VolumeStatus
Set-Asset-Field -Subdomain "xxxx" -Name "Bitlocker Protection Status" -Value $C_Drive_Status.ProtectionStatus
Set-Asset-Field -Subdomain "xxxx" -Name "Bitlocker Encryption %" -Value $C_Drive_Status.EncryptionPercentage

#Adds keys to Syncro
Set-Asset-Field -Subdomain "xxxx" -Name "Bitlocker ID C" -Value $KeyProtectorIDC
Set-Asset-Field -Subdomain "xxxx" -Name "Bitlocker Key C" -Value $RecoveryPasswordC```