# Mata o processo do Firefox, caso esteja em execução
Write-Host "Finalizando processos do Firefox..."
Stop-Process -Name "firefox" -Force -ErrorAction SilentlyContinue

# Verifica se o desinstalador existe e executa a desinstalação silenciosa
Write-Host "Verificando e executando o desinstalador do Firefox..."

if (Test-Path "C:\Program Files\Mozilla Firefox\uninstall\helper.exe") {
    Write-Host "Executando desinstalador em 'C:\Program Files\Mozilla Firefox\uninstall'..."
    Start-Process -FilePath "C:\Program Files\Mozilla Firefox\uninstall\helper.exe" -ArgumentList "/S" -NoNewWindow -Wait
} else {
    Write-Host "O desinstalador não foi encontrado em 'C:\Program Files\Mozilla Firefox\uninstall'."
}

if (Test-Path "C:\Program Files (x86)\Mozilla Firefox\uninstall\helper.exe") {
    Write-Host "Executando desinstalador em 'C:\Program Files (x86)\Mozilla Firefox\uninstall'..."
    Start-Process -FilePath "C:\Program Files (x86)\Mozilla Firefox\uninstall\helper.exe" -ArgumentList "/S" -NoNewWindow -Wait
} else {
    Write-Host "O desinstalador não foi encontrado em 'C:\Program Files (x86)\Mozilla Firefox\uninstall'."
}

# Aguarda 20 segundos para garantir que o processo de desinstalação seja concluído
Write-Host "Aguardando 20 segundos para concluir a desinstalação..."
Start-Sleep -Seconds 20

# Remove manualmente a pasta de instalação, caso o desinstalador não tenha feito isso
Write-Host "Verificando e removendo pastas residuais do Firefox..."

if (Test-Path "C:\Program Files\Mozilla Firefox\") {
    Write-Host "Removendo pasta 'C:\Program Files\Mozilla Firefox'..."
    Remove-Item -Path "C:\Program Files\Mozilla Firefox" -Recurse -Force
    Write-Host "Pasta 'Mozilla Firefox' removida de 'C:\Program Files'."
}

if (Test-Path "C:\Program Files (x86)\Mozilla Firefox\") {
    Write-Host "Removendo pasta 'C:\Program Files (x86)\Mozilla Firefox'..."
    Remove-Item -Path "C:\Program Files (x86)\Mozilla Firefox" -Recurse -Force
    Write-Host "Pasta 'Mozilla Firefox' removida de 'C:\Program Files (x86)'."
}

# Remove o atalho do Firefox na área de trabalho pública
Write-Host "Verificando e removendo atalho do Firefox na área de trabalho pública..."

$publicDesktop = "C:\Users\Public\Desktop"
$firefoxShortcut = Join-Path -Path $publicDesktop -ChildPath "Mozilla Firefox.lnk"

if (Test-Path $firefoxShortcut) {
    Remove-Item -Path $firefoxShortcut -Force
    Write-Host "Atalho 'Mozilla Firefox.lnk' removido de 'C:\Users\Public\Desktop'."
} else {
    Write-Host "Nenhum atalho do Firefox encontrado em 'C:\Users\Public\Desktop'."
}