#!/bin/bash

echo ">>> Iniciando rotina de manutenção do sistema..."
sleep 1

# 1. sincroniza a lista de pacotes
echo "[1/3] Buscando novas atualizações..."
sudo apt update

# 2. baixa e instala os pacotes pendentes (modo silencioso)
echo "[2/3] Aplicando atualizações..."
sudo apt upgrade -y

# 3. faxina pesada (junta autoremove e autoclean na mesma linha)
echo "[3/3] Removendo lixo e cache antigo..."
sudo apt autoremove -y && sudo apt autoclean

echo ""
echo ">>> Manutenção concluída! Máquina atualizada."