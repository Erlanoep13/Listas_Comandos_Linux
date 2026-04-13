#!/bin/bash

# site que sera monitorado
alvo="https://www.youtube.com"
espera=5

echo "Iniciando ping HTTP no alvo: $alvo"
echo "Para parar, aperte CTRL+C."
echo ""

while true; do
    # pega a hora primeiro para formatar o log
    hora=$(date +"%H:%M:%S - %d/%m/%Y")

    # o -w extrai apenas o numero do status (ex: 200, 404)
    # o -o /dev/null joga o html do site fora para nao sujar a tela
    status=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "$alvo")

    # avalia o numero recebido
    case $status in
        200)
            echo "[$hora] ONLINE (Status: 200 OK)"
            ;;
        000)
            echo "[$hora] OFFLINE/TIMEOUT (Sem resposta)"
            ;;
        *)
            echo "[$hora] ATENÇÃO (Status inesperado: $status)"
            ;;
    esac

    sleep $espera
done