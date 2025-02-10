# Definir o caminho da OU
$OUPath = "OU=hospital unimed,DC=araruama,DC=unimed,DC=com,DC=br"

# Obter todos os usuários desativados na OU especificada sem descrição preenchida,
# exceto aqueles na OU que começa com "Inativos_"
$usuariosDesativadosSemDescricao = Get-ADUser -Filter {Enabled -eq $false -and Description -notlike "*"} -SearchBase $OUPath | Where-Object { $_.DistinguishedName -notlike "*,OU=Inativos_*" }

# Caminho do arquivo CSV de saída
$exportFilePath = "C:\temp\usuarios_desativados_sem_descricao.csv"

# Criar um array para armazenar os resultados com a descrição "Inativo"
$resultados = @()

# Iterar/repetir pelos usuários desativados sem descrição
foreach ($usuario in $usuariosDesativadosSemDescricao) {
    $ouDoUsuario = ($usuario.DistinguishedName -split ",", 2)[1] # Obtém a primeira parte do DistinguishedName (a OU)

    # Definir a descrição como "Inativo" e atualizar o usuário no Active Directory
    Set-ADUser -Identity $usuario -Description "Inativo"

    $resultado = [PSCustomObject]@{
        "Nome do Usuario" = $usuario.Name
        "Nome de Usuario (SamAccountName)" = $usuario.SamAccountName
        "OU do Usuario" = $ouDoUsuario
        "Descricao" = "Inativo"
    }

    $resultados += $resultado
}

# Exportar os resultados para um arquivo CSV
$resultados | Export-Csv -Path $exportFilePath -NoTypeInformation