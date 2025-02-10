import tkinter as tk
from tkinter import scrolledtext
import subprocess
import threading

# Função para executar comandos via PsExec com -s (sem usuário e senha)
def execute_psexec(command, remote_ip):
    try:
        # Comando para abrir uma sessão interativa do PowerShell com -NoExit
        psexec_command = [
            'psexec.exe', '-s', f'\\\\{remote_ip}', 
              # Executar como SYSTEM
            'powershell.exe', '-Command', command
        ]
        
        # Exibir o comando no console para depuração
        print(f"Comando PsExec: {' '.join(psexec_command)}")

        # Execute o comando e capture a saída
        process = subprocess.Popen(psexec_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        stdout, stderr = process.communicate()

        # Exibir a saída ou erro no console para depuração
        if stdout:
            print(f"Saída do comando:\n{stdout}")
        if stderr:
            print(f"Erro do comando:\n{stderr}")

        # Retorna a saída ou erro para a interface gráfica
        return stdout if stdout else stderr
    except Exception as e:
        # Exibir erro no console para depuração
        print(f"Erro ao executar PsExec: {e}")
        return str(e)

# Função para mostrar o terminal na interface gráfica
def run_command():
    command = command_entry.get()
    if command:
        output_text.insert(tk.END, f'Comando: {command}\n')
        
        # Executar comando em uma thread separada para evitar travamento da interface
        def threaded_execution():
            output = execute_psexec(command, remote_ip_entry.get())
            output_text.insert(tk.END, output + '\n')
            output_text.yview(tk.END)  # Rolar automaticamente para o fim

        threading.Thread(target=threaded_execution, daemon=True).start()

# Interface Gráfica
root = tk.Tk()
root.title("Conectar via PsExec")

# Configurar expansão flexível da interface
root.grid_rowconfigure(0, weight=0)  # Linha para o IP
root.grid_rowconfigure(1, weight=0)  # Linha para o comando
root.grid_rowconfigure(2, weight=0)  # Linha para o botão
root.grid_rowconfigure(3, weight=1)  # Linha para o terminal (expansível)
root.grid_columnconfigure(0, weight=1)  # Coluna expansível
root.grid_columnconfigure(1, weight=1)  # Coluna expansível

# Labels
tk.Label(root, text="IP da Máquina Remota:").grid(row=0, column=0, padx=10, pady=5, sticky="e")
tk.Label(root, text="Comando a Executar:").grid(row=1, column=0, padx=10, pady=5, sticky="e")

# Entradas
remote_ip_entry = tk.Entry(root, width=25)
remote_ip_entry.grid(row=0, column=1, padx=10, pady=5, sticky="ew")
command_entry = tk.Entry(root, width=50)
command_entry.grid(row=1, column=1, padx=10, pady=5, sticky="ew")

# Botão para rodar o comando
run_button = tk.Button(root, text="Executar", command=run_command)
run_button.grid(row=2, column=0, columnspan=2, pady=10)

# Terminal para exibir a saída
output_text = scrolledtext.ScrolledText(root, width=60, height=15)
output_text.grid(row=3, column=0, columnspan=2, padx=10, pady=5, sticky="nsew")

# Rodar a interface gráfica
root.mainloop()