from netmiko import ConnectHandler
import re

def format_mac(mac):
    """
    Converte um MAC address no formato Cisco (803e.0c18.bfe7)
    para o formato padrÃ£o 00:00:00:00:00:00.
    """
    mac_clean = mac.replace('.', '')  # Remove os pontos
    mac_formatted = ':'.join(mac_clean[i:i+2] for i in range(0, len(mac_clean), 2))  # Insere os ':'
    return mac_formatted.upper()  # Retorna o MAC em minÃºsculas para padronizaÃ§Ã£o

def extract_port_number(port):
    """
    Extrai o nÃºmero da porta para facilitar a ordenaÃ§Ã£o (ex: Gi1/0/10 â†’ 10).
    """
    match = re.search(r'(\d+)/(\d+)/(\d+)', port)  # Exemplo: Gi1/0/10
    if match:
        return tuple(map(int, match.groups()))  # Retorna (1, 0, 10)
    match = re.search(r'(\d+)/(\d+)', port)  # Exemplo: Fa0/24
    if match:
        return tuple(map(int, match.groups()))  # Retorna (0, 24)
    return (9999,)  # Se nÃ£o conseguir extrair, joga para o final da lista

# Conectar ao switch Cisco
switch = {
    'device_type': 'cisco_ios',
    'host': 'IP_HOST',
    'username': 'USERNAME',
    'password': 'PASS',
}

connection = ConnectHandler(**switch)
output = connection.send_command('show mac address-table vlan 118')
#print(output)
connection.disconnect()

# ExpressÃ£o regular para capturar MACs e portas
pattern = re.compile(r'([0-9a-fA-F]{4}\.[0-9a-fA-F]{4}\.[0-9a-fA-F]{4})\s+\w+\s+(\S+)')

# Encontrar todas as correspondÃªncias de MAC e porta
matches = pattern.findall(output)

# Transformar e ordenar os dados
sorted_data = sorted(matches, key=lambda x: extract_port_number(x[1]))

# Exibir os MACs formatados e suas portas associadas ordenadas
print("EndereÃ§os MAC e Portas (Ordenados por Porta):")
for mac, port in sorted_data:
    if port.strip().lower() == "cpu" or port.strip().startswith("Po"):
    	continue  # Ignora portas CPU e PoX
    formatted_mac = format_mac(mac)
    print(f"MAC: {formatted_mac} - Porta: {port}")