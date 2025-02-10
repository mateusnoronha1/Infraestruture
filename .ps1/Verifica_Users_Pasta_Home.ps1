$OutputFile = "C:\resultado.txt"

$users = Get-ADUser -Filter "Enabled -eq 'True'" -Properties SamAccountName -SearchBase "OU=hospital unimed,DC=araruama,DC=unimed,DC=com,DC=br" | Select-Object -ExpandProperty SamAccountName

foreach ($user in $users) {
    $p = '\\10.0.28.14\d$\home\' + $user

    try {
        $acl = Get-Acl -Path $p -ErrorAction Stop | Select-Object -ExpandProperty AccessToString
        $output = "Pasta: $p`n" + $acl
        $output | Out-File -FilePath $OutputFile -Append -Encoding utf8
    }
    catch {
        Write-Host "A pasta de $user não existe!"
        New-Item -Path $p -ItemType Directory | Out-Null
    }
}
