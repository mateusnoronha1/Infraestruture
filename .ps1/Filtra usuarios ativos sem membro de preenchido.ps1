# Define o nome do controlador de dominio
$domainController = "araruama.unimed.com.br"
# Define o caminho completo para a OU especifica
$ouPath = "OU=hospital unimed,DC=araruama,DC=unimed,DC=com,DC=br"

# Busca todos os usuarios da OU especifica com status de conta ativo
$users = Get-ADUser -Filter {(Enabled -eq $true)} -SearchBase $ouPath -Server $domainController -Properties MemberOf

# Cria um array para armazenar os usuarios ativos sem "membro de"
$activeUsersWithoutMemberOf = @()

# Verifica cada usuario ativo
foreach ($user in $users) {
    if ($user.MemberOf.Count -eq 0) {
        # Se o usuario nao tiver "membro de", adiciona a lista
        $activeUsersWithoutMemberOf += $user
    }
}

# Exibe a lista de usuarios ativos sem "membro de"
if ($activeUsersWithoutMemberOf.Count -eq 0) {
    Write-Host "Todos os usuarios ativos na OU - Hospital Unimed tem o atributo 'membro de' preenchido."
} else {
    Write-Host "Usuarios ativos na OU sem 'membro de':"
    $activeUsersWithoutMemberOf | Select-Object Name, SamAccountName, DistinguishedName | Format-Table -AutoSize
	
	#Exporta os resultados para um arquivo CSV
     $csvFilePath = "C:/Scripts/Inatividade/Usuarios_Ativos_MembroDe_Nao_Preenchido.csv"
     $activeUsersWithoutMemberOf | Select-Object Name, SamAccountName, DistinguishedName | Export-Csv -Path $csvFilePath -NoTypeInformation
     Write-Host "Resultados exportados para $csvFilePath"
}
