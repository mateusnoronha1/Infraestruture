# Caminho para o arquivo TXT
$txtPath = "C:\Users\mateus.noronhaadm\Desktop\reservas.txt"

# Verifica se o arquivo TXT existe
if (-Not (Test-Path $txtPath)) {
    Write-Host "Erro: Arquivo TXT não encontrado em $txtPath" -ForegroundColor Red
    exit
}

# Lê o arquivo linha por linha
$reservas = Get-Content -Path $txtPath

# Processa cada linha do arquivo
foreach ($linha in $reservas) {
    # Divide os dados usando a vírgula como delimitador
    $dados = $linha -split ","

    # Verifica se há pelo menos 5 colunas
    if ($dados.Length -lt 5) {
        Write-Host "Erro: Linha mal formatada: $linha" -ForegroundColor Red
        continue
    }

    $scopeId = $dados[0].Trim()
    $ipAddress = $dados[1].Trim()
    $clientId = $dados[2].Trim()
    $description = $dados[3].Trim()
    $reservationName = $dados[4].Trim()  # O nome da reserva agora vem do arquivo

    Write-Host "Adicionando reserva: $ipAddress para $clientId no escopo $scopeId com o nome de reserva '$reservationName'..."

    try {
        # Adiciona a reserva no DHCP, incluindo o nome da reserva (Reservation Name)
        Add-DhcpServerv4Reservation -ScopeId $scopeId -IPAddress $ipAddress -ClientId $clientId -Description "$description" -Name $reservationName

        Write-Host "Reserva adicionada com sucesso." -ForegroundColor Green
    } catch {
        Write-Host ("Erro ao adicionar a reserva para {0}: {1}" -f $clientId, $_.Exception.Message) -ForegroundColor Red
    }
}

Write-Host "Processo concluído!"
