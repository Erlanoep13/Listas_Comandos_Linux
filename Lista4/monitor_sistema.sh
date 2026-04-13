#!/bin/bash

# definicao de limites para disparo do alerta
max_disco=90
min_ram_livre=15
arquivo_log="auditoria_sistema.log"

echo "Monitoramento ativo. Gravando em: $arquivo_log"
echo "Aperte CTRL+C para sair."
echo ""

while true; do
    agora=$(date +"%d/%m/%Y %H:%M:%S")
    tem_problema=0
    avisos=""

    # 1. uso do disco (extrai apenas a porcentagem da particao raiz)
    uso_disco=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
    
    if [[ "$uso_disco" -gt "$max_disco" ]]; then
        avisos+="[Disco cheio: ${uso_disco}%] "
        tem_problema=1
    fi

    # 2. ram livre (calcula a porcentagem direto no awk)
    ram_livre=$(free | awk '/Mem:/ {printf "%.0f", $4/$2 * 100}')
    
    if [[ "$ram_livre" -lt "$min_ram_livre" ]]; then
        avisos+="[RAM critica: ${ram_livre}% livre] "
        tem_problema=1
    fi

    # 3. carga do processador (le direto do arquivo nativo do linux)
    cpu_load=$(awk '{print $1}' /proc/loadavg)

    # 4. avalia se deu problema e joga na tela
    if [[ $tem_problema -eq 1 ]]; then
        estado="PERIGO"
        # imprime em vermelho no terminal (\033[31m)
        echo -e "\033[31m[$agora] $estado -> $avisos\033[0m"
    else
        estado="NORMAL"
        echo "[$agora] $estado | Disco: ${uso_disco}% | RAM Livre: ${ram_livre}% | Load: $cpu_load"
    fi

    # 5. salva no arquivo historico
    echo "[$agora] $estado | Disco:${uso_disco}% RAM:${ram_livre}% CPU:${cpu_load} | Detalhes: $avisos" >> "$arquivo_log"

    sleep 10
done