:: Acessa o caminho do TighVNC
cd "C:\Program Files\TightVNC"
:: Instala o tvnserver.exe como servico
tvnserver.exe -install
:: Starta o servico do tvnserver
net start tvnserver
:: Configura o servico para iniciar automaticamente no iniciar do windows
sc config tvnserver start= auto