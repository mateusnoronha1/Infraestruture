Write-Host 'Este Script tem como finalidade deslogar os usuarios inativos conectados no computador informado'
Write-Host 'Informe o computador que deseja deslogar os usuarios'
$server = Read-Host 'Informe o hostname ou ip'
​
query user /server:$server 2>&1 | Select-String "Disc" | ForEach{'Logoff de ' + ($_.tostring() -split ' +')[1]; logoff /server:$server ($_.tostring() -split ' +')[2]}