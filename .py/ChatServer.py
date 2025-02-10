import socket
import threading

# Configurações do servidor
HOST = '192.168.1.10'  # Endereço IP do servidor
PORT = 555        # Porta do servidor

# Lista para armazenar clientes conectados
clientes = []

def gerenciar_cliente(conn, addr):
    print(f"Nova conexão: {addr}")
    clientes.append(conn)
    try:
        while True:
            # Recebe a mensagem do cliente
            msg = conn.recv(1024).decode('utf-8')
            if not msg:
                break
            print(f"Mensagem de {addr}: {msg}")
            
            # Envia a mensagem para todos os outros clientes
            for cliente in clientes:
                if cliente != conn:
                    cliente.send(f"{addr}: {msg}".encode('utf-8'))
    except ConnectionResetError:
        print(f"Conexão perdida com {addr}")
    finally:
        # Remove cliente ao desconectar
        clientes.remove(conn)
        conn.close()

def iniciar_servidor():
    servidor = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    servidor.bind((HOST, PORT))
    servidor.listen(5)
    print(f"Servidor iniciado em {HOST}:{PORT}")
    
    while True:
        conn, addr = servidor.accept()
        threading.Thread(target=gerenciar_cliente, args=(conn, addr)).start()

if __name__ == "__main__":
    iniciar_servidor()
