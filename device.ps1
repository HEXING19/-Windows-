#���ýű�ִ�з�ʽ
Set-ExecutionPolicy RemoteSigned
#�л�Ŀ¼
Set-Location ��C:\Users\lg\Desktop\DeviceManagement\��
#��������
Import-Module .\DeviceManagement.psd1
#��ȡ�����豸�����ƴ���Network���豸
Get-Device -ControlOptions DIGCF_ALLCLASSES | Sort-Object -Property Name | Where-Object {($_.IsPresent -eq $false) -and ($_.Name -like ��*Network*��) } | ft Name, DriverVersion, DriverProvider, IsPresent, HasProblem, InstanceId -AutoSize
#�����������ֵ������
$hiddenHypVNics = Get-Device -ControlOptions DIGCF_ALLCLASSES | Sort-Object -Property Name | Where-Object {($_.IsPresent -eq $false) -and ($_.Name -like ��*Network*��) }
#�л�Ŀ¼
Set-Location "C:\Users\lg\AppData\Roaming\DevCon"
#����ɾ�������豸
ForEach ($hiddenNic In $hiddenHypVNics) { $deviceid = ��@" + $hiddenNic.InstanceId; .\devcon.exe /r remove $deviceid }