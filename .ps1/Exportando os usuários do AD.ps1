#Exportando os usuarios do AD na UO Definida.
​
$usuarios_F = Get-ADUser -Filter "Enabled -eq 'False'" -Properties SamAccountName,Name,Created,whenChanged,Department,Enabled -SearchBase "OU=XXX,DC=XXX,DC=XXX,DC=com,DC=br" | select SamAccountName,Name,Created,@{N='Inatived';E={$_.whenChanged}},Department,Enabled
​
$usuarios_F| Export-Csv -Path "C:\temp\usuarios_ad.csv" -Force -NoTypeInformation
​
$usuarios_T = Get-ADUser -Filter "Enabled -eq 'True'" -Properties SamAccountName,Name,Created,whenChanged,Department,Enabled -SearchBase "OU=XXX,DC=XXX,DC=XXX,DC=com,DC=br" | select SamAccountName,Name,Created,{"NAN"},Department,Enabled 
​
$usuarios_T| Export-Csv -Path "C:\temp\usuarios_ad.csv" -Force -NoTypeInformation -Append