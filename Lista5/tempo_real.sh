#!/bin/bash

# Variaveis de configuracao
pasta_logs="lab_logs/*.log"
termos_criticos="error|failed|warning|fatal"

echo ">>> Radar de Logs Ativado <<<"
echo "Aguardando eventos críticos na rede... [Aperte CTRL+C para sair]"
echo "---------------------------------------------------------------"

# tail -F acompanha os arquivos continuamente
# read -r le a linha de forma segura sem interpretar barras invertidas
tail -F $pasta_logs | while read -r linha; do
    
    # O truque mestre: ${linha,,} converte tudo para minusculo
    # =~ compara diretamente com os termos usando o motor interno do bash
    if [[ "${linha,,}" =~ $termos_criticos ]]; then
        # Imprime o alerta em vermelho negrito
        echo -e "\033[1;31m[ URGENTE ]\033[0m -> $linha"
    fi

done