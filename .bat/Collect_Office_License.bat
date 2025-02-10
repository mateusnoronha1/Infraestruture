@echo off
:x

	echo Digite o IP/Nome da maquina.
		set /p input= 
			 
						
				xcopy "\\SERVER_SHARE\ospp.vbs" \\%input%\c$\
		
					
				
				( psexec \\%input%  cscript "c:\ospp.vbs" /dstatus
				
				del "\\%input%\c$\ospp.vbs"
				
					

					echo ###################################################################################################																					
					echo #
					echo #
					echo #
					echo #
					
					echo #################------------- O relatorio acima da maquina: %input% -------------#################
					
					echo #
					echo #
					echo #
					echo #
					echo ###################################################################################################
					
					) >> c:\relatorio.txt
	
			
			 
		


pause

		

			cls

goto x