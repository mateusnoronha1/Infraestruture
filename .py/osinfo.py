import os
import socket
import getpass


# Nome do Sistema Operacional
Nomemaq = socket.gethostname()

print(os.name)



print(Nomemaq)



hostname = socket.gethostname()       # Obtém o nome da máquina
ip_maquina = socket.gethostbyname(hostname)  # Obtém o IP associado ao nome da máquina

print(f"Endereço IP da máquina: {ip_maquina}")