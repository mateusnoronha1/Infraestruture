import subprocess
import os

# Verifica se o PsExec está disponível no caminho especificado
psexec_path = r"C:\Windows\System32\psexec.exe"
if not os.path.exists(psexec_path):
    raise FileNotFoundError(f"O PsExec não foi encontrado no caminho: {psexec_path}")

# Solicita o nome ou IP do host
host = input("Nome ou IP do Host: ").strip()

# Verifica se o usuário inseriu um host válido
if not host:
    raise ValueError("Nome ou IP do Host não pode ser vazio!")

# Parâmetros para o PsExec
param = "-s"  # Executa como 'SYSTEM'
app = "powershell.exe"  # Aplicação a ser executada no host remoto (PowerShell)

# Monta o comando completo do PsExec
cmd = [psexec_path, f"\\\\{host}", param, app]

try:
    # Executa o comando e captura a saída e erros
    result = subprocess.run(cmd, capture_output=True, text=True, check=True)
    
    # Exibe a saída do comando (stdout)
    print("Comando executado com sucesso:")
    print(result.stdout)

except subprocess.CalledProcessError as e:
    # Em caso de erro, exibe o código de retorno e a mensagem de erro
    print(f"Ocorreu um erro ao executar o PsExec. Código de retorno: {e.returncode}")
    print(f"Saída do erro: {e.stderr}")

except Exception as e:
    # Captura quaisquer outras exceções
    print(f"Ocorreu um erro inesperado: {e}")
