#!/bin/bash

# armazena a quantidade de conexoes antes de exibir na tela
qtd_conexoes=$(who | wc -l)

echo ">> Controle de Acessos <<"
echo ""
echo "Usuários conectados no momento:"

# usa o awk para ler a saida do 'who' e deixar o texto mais limpo
who | awk '{print " -> " $1 " (Terminal: " $2 " | Desde: " $3 " " $4 ")"}'

echo "-----------------------------------"
echo "Resumo: $qtd_conexoes sessão(ões) ativa(s)."