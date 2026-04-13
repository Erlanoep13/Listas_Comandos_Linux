#!/bin/bash

caminho=$(pwd)

while true; do
    clear
    echo ">> Navegador de Arquivos <<"
    echo "Local: $caminho"
    echo "--------------------------"

    # le os itens da pasta e salva no array
    readarray -t lista_itens < <(ls -1)

    echo "0) [Voltar diretório / Sair]"

    # imprime a lista com os numeros
    for i in "${!lista_itens[@]}"; do
        echo "$((i+1))) ${lista_itens[$i]}"
    done

    echo ""
    read -p "Digite o numero do item: " input_usuario

    # logica de saida ou retorno
    if [[ "$input_usuario" -eq 0 ]]; then
        if [[ "$caminho" == "/" ]]; then
            break
        else
            cd ..
            caminho=$(pwd)
            continue
        fi
    fi

    # descobre qual arquivo foi selecionado na lista
    index_real=$((input_usuario-1))
    item_alvo="${lista_itens[$index_real]}"

    if [[ -z "$item_alvo" ]]; then
        echo "Opção inexistente."
        sleep 1
        continue
    fi

    # checa se eh pasta
    if [[ -d "$item_alvo" ]]; then
        cd "$item_alvo" || exit
        caminho=$(pwd)
        
    # checa se eh arquivo
    elif [[ -f "$item_alvo" ]]; then
        echo ""
        echo "-> Selecionado: $item_alvo"
        echo "1 - Ler conteudo"
        echo "2 - Executar script"
        echo "3 - Cancelar"
        read -p "O que fazer? " acao

        if [[ "$acao" -eq 1 ]]; then
            echo ""
            cat "$item_alvo"
            echo ""
            read -p "Aperte Enter para continuar..."
            
        elif [[ "$acao" -eq 2 ]]; then
            echo "Dando permissão e rodando..."
            chmod +x "$item_alvo"
            ./"$item_alvo"
            read -p "Aperte Enter para voltar..."
            
        else
            echo "Cancelando..."
            sleep 1
        fi
    fi
done