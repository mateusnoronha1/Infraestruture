import socket
import threading

# Configurações do cliente
HOST = '192.168.1.10'  # IP do servidor
PORT = 555        # Porta do servidor

def receber_mensagens(conn):
    while True:
        try:
            msg = conn.recv(1024).decode('utf-8')
            if not msg:
                break
            print(msg)
        except:
            print("Conexão encerrada.")
            break

def iniciar_cliente():
    cliente = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    cliente.connect((HOST, PORT))
    print("Conectado ao servidor!")
    
    # Thread para receber mensagens
    threading.Thread(target=receber_mensagens, args=(cliente,)).start()

    # Enviar mensagens
    try:
        while True:
            msg = input("Digite sua mensagem: ")
            cliente.send(msg.encode('utf-8'))
    except KeyboardInterrupt:
        print("\nSaindo do chat.")
        cliente.close()

if __name__ == "__main__":
    iniciar_cliente()
