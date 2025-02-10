::Acessa o modulo WMIC da máquina
wmic
::Remove o software Trend Micro com o comando Uninstall e o torna não interativo, fazendo a remoção silenciosamente
product where name=”Trend Micro Worry-Free Business Security Agent” call uninstall /nointeractive