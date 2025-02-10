@echo off
:x

	echo Digite o IP/Nome da maquina.
		set /p input= 
		
		
		qwinsta /server:%input%
		
pause


cls


goto x
