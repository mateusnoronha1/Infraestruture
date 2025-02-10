Import-Module ActiveDirectory

# Busca todos os computadores no AD que sejam servidores e tenham Windows Server 2012
$servidores = Get-ADComputer -Filter {OperatingSystem -like "*Windows Server 2012*"} -Property Name, OperatingSystem, OperatingSystemVersion

# Exibir os resultados
if ($servidores.Count -gt 0) {
    Write-Host "Servidores com Windows Server 2012 encontrados:" -ForegroundColor Green
    $servidores | Select-Object Name, OperatingSystem, OperatingSystemVersion | Format-Table -AutoSize
} else {
    Write-Host "Nenhum servidor com Windows Server 2012 foi encontrado no AD." -ForegroundColor Red
}
