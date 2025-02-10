@echo off
:x

	echo Digite o IP/Nome da maquina.
		set /p input= 
		
		
		qwinsta /server:%input%
:y		
	echo Digite o ID do usuario a ser deslogado
		set /p input2=
		
		
		psexec -s \\%input% logoff %input2%

	echo Existe usuario a ser deslogado S/N ?
		set /p input3=	



if "%input3%" == "s" (
	 goto y 
) else if "%input3%" == "n" ( cls
	goto x 
) else ( 
	goto z 
)
	


:z
echo Favor inserir uma resposta valida.
goto y 
	
pause


cls


goto y
