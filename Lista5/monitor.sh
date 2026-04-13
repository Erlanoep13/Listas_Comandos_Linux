#!/bin/bash

# Mapeamento dos arquivos alvo
log_app="lab_logs/app.log"
log_ssh="lab_logs/auth.log"

echo ">>> Iniciando Verificação de Anomalias <<<"
echo "------------------------------------------"

# 1. Checagem de integridade da API
# Conta direto quantas vezes a palavra aparece, ignorando maiusculas/minusculas (-i)
erros_backend=$(grep -i -c "error" "$log_app")

if [[ "$erros_backend" -gt 0 ]]; then
    echo "[AVISO] Ocorreram $erros_backend erros de execução no serviço Node.js!"
else
    echo "[OK] Backend íntegro. Sem registro de falhas."
fi

echo "------------------------------------------"

# 2. Checagem de seguranca de rede
invasoes=$(grep -i -c "failed password" "$log_ssh")

if [[ "$invasoes" -gt 0 ]]; then
    echo "[ALERTA] Foram bloqueadas $invasoes tentativas de acesso não autorizado (SSH)."
else
    echo "[OK] Perímetro seguro. Sem tentativas de invasão."
fi

echo "------------------------------------------"
echo "Verificação concluída."