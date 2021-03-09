#设置脚本执行方式
Set-ExecutionPolicy RemoteSigned
#切换目录
Set-Location “C:\Users\lg\Desktop\DeviceManagement\”
#导入命令
Import-Module .\DeviceManagement.psd1
#获取隐藏设备中名称带有Network的设备
Get-Device -ControlOptions DIGCF_ALLCLASSES | Sort-Object -Property Name | Where-Object {($_.IsPresent -eq $false) -and ($_.Name -like “*Network*”) } | ft Name, DriverVersion, DriverProvider, IsPresent, HasProblem, InstanceId -AutoSize
#将上述结果赋值给变量
$hiddenHypVNics = Get-Device -ControlOptions DIGCF_ALLCLASSES | Sort-Object -Property Name | Where-Object {($_.IsPresent -eq $false) -and ($_.Name -like “*Network*”) }
#切换目录
Set-Location "C:\Users\lg\AppData\Roaming\DevCon"
#批量删除隐藏设备
ForEach ($hiddenNic In $hiddenHypVNics) { $deviceid = “@" + $hiddenNic.InstanceId; .\devcon.exe /r remove $deviceid }