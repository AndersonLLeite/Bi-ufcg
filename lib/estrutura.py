import os

def listar_diretorios(raiz, nivel=0):
    texto = ""
    prefixo = "│   " * (nivel - 1) + "├── " if nivel > 0 else ""
    try:
        for item in os.listdir(raiz):
            caminho = os.path.join(raiz, item)
            if os.path.isdir(caminho):
                texto += f"{prefixo}{item}/\n"
                texto += listar_diretorios(caminho, nivel + 1)
            else:
                texto += f"{prefixo}{item}\n"
    except PermissionError:
        texto += f"{prefixo}[PERMISSION DENIED]\n"
    return texto

def gerar_texto_estrutura_diretorios():
    caminho_inicial = os.getcwd()  # Pega o diretório atual
    return listar_diretorios(caminho_inicial)

if __name__ == "__main__":
    estrutura = gerar_texto_estrutura_diretorios()

    # Imprime a estrutura no console
    print(estrutura)

    # Salva a estrutura em um arquivo
    with open("estrutura_diretorios.txt", "w", encoding="utf-8") as f:
        f.write(estrutura)

    print("\nEstrutura de diretórios salva em 'estrutura_diretorios.txt'.")
