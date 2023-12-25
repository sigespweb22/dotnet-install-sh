#!/bin/bash

# Script to install a specific version of .NET SDK on Linux and macOS

echo "Iniciando a instalação do .NET SDK..."

# Baixa o script dotnet-install.sh da Microsoft
echo "Baixando o dotnet-install.sh script direto no site da microsoft..."
wget https://dot.net/v1/dotnet-install.sh

# Torna o script baixado executável
echo "Tornando o script baixado executável..."
chmod +x dotnet-install.sh

# Solicita ao usuário a versão do .NET SDK a ser instalada
read -p "Informe a versão que deseja instalar do .NET SDK (e.g., 7.0.404): " version

# Instala a versão específica do .NET SDK
echo "Instalando o .NET SDK versão $version..."
./dotnet-install.sh --version $version

# Tenta detectar o shell do usuário
user_shell=$(echo $SHELL)

# Verifica se o Oh My Zsh está instalado
if [ -n "$ZSH_VERSION" ] && [ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
    echo "Oh My Zsh detectado. Adicionando o .NET SDK ao caminho do Zsh..."
    echo "export PATH=\$HOME/.dotnet:\$PATH" >> "$HOME/.zshrc"
    shell_reload_command="source $HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    echo "Bash detectado. Adicionando o .NET SDK ao caminho do Bash..."
    echo "export PATH=\$HOME/.dotnet:\$PATH" >> "$HOME/.bashrc"
    shell_reload_command="source $HOME/.bashrc"
else
    echo "Shell não suportado. Por favor, use Bash ou Zsh com Oh My Zsh."
    exit 1
fi

# Recarrega o arquivo de configuração do shell
echo "Recarregando o ambiente do shell..."
eval $shell_reload_command

# Imprime as versões do SDK do .NET instaladas
echo "Listando os SDKs instalados na máquina, verifique se a versão instalada nesse processo está sendo listada..."
dotnet --list-sdks

echo "Instalação concluída com sucesso!"
echo "Script criado por Alan Rezende."