# caminho do arquivo de log
$logFilePath = "C:\TempCleanupLog.txt"

# Inicializar o arquivo de log
"Log de Limpeza de TEMP - $(Get-Date)" | Out-File -FilePath $logFilePath -Append

# Obter a lista de diretórios TEMP de todos os usuarios
$usersTempDirectories = Get-ChildItem -Path "C:\Users" -Directory | ForEach-Object {
    $tempPath = Join-Path -Path $_.FullName -ChildPath "AppData\Local\Temp"
    if (Test-Path -Path $tempPath) {
        $tempPath
    }
}

# Iterar sobre cada diretorio TEMP e apagar arquivos
foreach ($tempDir in $usersTempDirectories) {
    Write-Output "Processando diretório: $tempDir"
    
    # Obter todos os arquivos no diretorio TEMP
    $files = Get-ChildItem -Path $tempDir -File -Recurse -ErrorAction SilentlyContinue
    
    foreach ($file in $files) {
        try {
            # Registrar o arquivo que sera removido
            "Removendo arquivo: $($file.FullName)" | Out-File -FilePath $logFilePath -Append
            
            # Remover o arquivo
            Remove-Item -Path $file.FullName -Force -ErrorAction Stop
        } catch {
            # Registrar erros durante a remoçao
            "Erro ao remover o arquivo: $($file.FullName) - $($_.Exception.Message)" | Out-File -FilePath $logFilePath -Append
        }
    }
    
    # Apagar subpastas, se necessario
    $dirs = Get-ChildItem -Path $tempDir -Directory -Recurse -ErrorAction SilentlyContinue
    foreach ($dir in $dirs) {
        try {
            # Registrar a pasta que sera removida
            "Removendo pasta: $($dir.FullName)" | Out-File -FilePath $logFilePath -Append
            
            # Remover a pasta
            Remove-Item -Path $dir.FullName -Recurse -Force -ErrorAction Stop
        } catch {
            # Registrar erros durante a remoçao
            "Erro ao remover a pasta: $($dir.FullName) - $($_.Exception.Message)" | Out-File -FilePath $logFilePath -Append
        }
    }
}