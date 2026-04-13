#!/bin/bash

# Variaveis de mapeamento
LOG_APP="lab_logs/app.log"
LOG_DB="lab_logs/db.log"
LOG_DISCO="lab_logs/disk.log"

echo "=========================================="
echo " 🤖 SISTEMA DE AUTO-HEAL (AUTOCURA) ATIVO "
echo "=========================================="
echo ""

# Funcao inteligente para tratar incidentes de forma padronizada
executar_contingencia() {
    local arquivo_alvo=$1
    local comando_recuperacao=$2

    echo "[ AÇÃO ] Iniciando protocolo de recuperação..."
    echo "         -> Executando: $comando_recuperacao"
    
    # Simula o tempo que o sistema leva para reiniciar o servico
    sleep 2 
    
    # Rotaciona (esvazia) o log para zerar o status de erro e nao gerar falso positivo no futuro
    > "$arquivo_alvo"
    
    echo "[  OK  ] Incidente resolvido. Serviço restabelecido."
    echo "------------------------------------------"
}

# 1. Monitor de Integridade do Backend (Node.js)
if grep -q "PromiseRejection" "$LOG_APP"; then
    echo "[CRITICAL] Crash fatal detectado na API (Node.js)."
    executar_contingencia "$LOG_APP" "sudo systemctl restart node"
fi

# 2. Monitor de Banco de Dados (MySQL)
if grep -q "Lost connection" "$LOG_DB"; then
    echo "[CRITICAL] Conexão com o banco de dados perdida."
    executar_contingencia "$LOG_DB" "sudo systemctl restart mysql"
fi

# 3. Monitor de Armazenamento (Disco)
if grep -q "No space left" "$LOG_DISCO"; then
    echo "[CRITICAL] Esgotamento total de espaço em disco (100%)."
    executar_contingencia "$LOG_DISCO" "journalctl --vacuum-time=1d && rm -rf /tmp/cache/*"
fi

echo ">>> Ciclo de monitoramento ativo finalizado."