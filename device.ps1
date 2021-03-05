Set-ExecutionPolicy RemoteSigned

Set-Location ¡°C:\Users\lg\Desktop\DeviceManagement\¡±

Import-Module .\DeviceManagement.psd1

Get-Device -ControlOptions DIGCF_ALLCLASSES | Sort-Object -Property Name | Where-Object {($_.IsPresent -eq $false) -and ($_.Name -like ¡°*Network*¡±) } | ft Name, DriverVersion, DriverProvider, IsPresent, HasProblem, InstanceId -AutoSize

$hiddenHypVNics = Get-Device -ControlOptions DIGCF_ALLCLASSES | Sort-Object -Property Name | Where-Object {($_.IsPresent -eq $false) -and ($_.Name -like ¡°*Network*¡±) }

Set-Location "C:\Users\lg\AppData\Roaming\DevCon"

ForEach ($hiddenNic In $hiddenHypVNics) { $deviceid = ¡°@" + $hiddenNic.InstanceId; .\devcon.exe /r remove $deviceid }