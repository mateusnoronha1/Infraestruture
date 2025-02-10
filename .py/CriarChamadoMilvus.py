import requests

# Token de autenticação
token = "DIGITE_SEU_TOKEN_API_AQUI"  # Substitua pelo token real

# URLs da API
url_criar_chamado = "https://apiintegracao.milvus.com.br/api/chamado/criar"
url_anexo_chamado = "https://apiintegracao.milvus.com.br/api/chamado/anexo/criar/"

# Dados do chamado (substitua pelos valores reais)
payload_chamado = {
    "cliente_id": "TOKEN",
    "chamado_assunto": "Teste com anexo",
    "chamado_descricao": "Teste detalhado com anexo",
    "chamado_email": "teste@milvus.com.br",
    "chamado_telefone": "9597",
    "chamado_contato": "mateus.noronha",
    "chamado_mesa": "Mesa padrão",
    "chamado_setor": "Setor padrão",
}

# Cabeçalhos da requisição
headers = {
    "Authorization": token  # Envia o token diretamente
}

# Caminho do arquivo a ser anexado
file_path = "DIRETORIO"  # Substitua pelo caminho real do arquivo

try:
    # Passo 1: Criar o chamado
    response_chamado = requests.post(url_criar_chamado, json=payload_chamado, headers=headers)

    if response_chamado.status_code == 200:
        chamado_id = response_chamado.json()  # Obtém o ID do chamado na resposta
        print(f"Chamado criado com sucesso! ID: {chamado_id}")

        # Passo 2: Anexar arquivo ao chamado
        with open(file_path, "rb") as file:
            files = {
                "anexo": (file_path.split("/")[-1], file, "application/octet-stream"),
            }
            url_anexo = url_anexo_chamado + str(chamado_id)  # Completa a URL com o ID do chamado
            response_anexo = requests.post(url_anexo, files=files, headers=headers)

        if response_anexo.status_code == 200:
            print("Anexo enviado com sucesso!")
        else:
            print(f"Erro ao enviar anexo: {response_anexo.status_code}")
            print("Detalhes:", response_anexo.text)
    else:
        print(f"Erro ao criar chamado: {response_chamado.status_code}")
        print("Detalhes:", response_chamado.text)

except FileNotFoundError:
    print(f"Arquivo não encontrado: {file_path}")
except Exception as e:
    print("Erro ao conectar com a API:", str(e))
