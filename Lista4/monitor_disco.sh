#!/bin/bash

# configuracoes basicas do script
tempo_total=20
pausa=1

echo "Iniciando verificação de disco..."
sleep 1

# loop de repeticao para atualizar a tela
for (( i=0; i<$tempo_total; i++ )); do
    clear
    echo "Verificando uso do disco | Tempo corrido: ${i}s de ${tempo_total}s"
    echo "Aperte CTRL+C para cancelar."
    echo ""
    
    # exibe o armazenamento de forma legivel
    df -h
    
    sleep $pausa
done

echo ""
echo "Fim da verificação."