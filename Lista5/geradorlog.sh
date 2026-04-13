#!/bin/bash

# Diretorio e variaveis de destino
pasta_alvo="./lab_logs"
arq_sys="$pasta_alvo/syslog.log"
arq_auth="$pasta_alvo/auth.log"
arq_app="$pasta_alvo/app.log"
arq_db="$pasta_alvo/db.log"
arq_disk="$pasta_alvo/disk.log"

# Cria a pasta caso nao exista
mkdir -p "$pasta_alvo"

# Esvazia logs antigos para comecar o lab do zero
> "$arq_sys"; > "$arq_auth"; > "$arq_app"; > "$arq_db"; > "$arq_disk"

echo ">>> Simulador de Tráfego e Incidentes Iniciado <<<"
echo "O servidor está gerando logs... Pressione [CTRL+C] para interromper."

# Funcao para gerar a data no padrao oficial de logs do Linux
carimbo() {
  date "+%b %d %H:%M:%S"
}

# Loop infinito injetando logs a cada 2 segundos
while true; do
  agora=$(carimbo)
  echo "$agora srv-principal systemd[1]: [INFO] Executando checagem de rotina..." >> "$arq_sys"

  # Sorteia um incidente de 0 a 4
  incidente=$((RANDOM % 5))

  case $incidente in
    # 0 - Sem falhas
    0)
      echo "$agora srv-principal systemd[1]: [OK] Todos os serviços operacionais." >> "$arq_sys"
      ;;

    # 1 - Falha na aplicacao Node.js
    1)
      echo "$agora srv-principal nodejs[3001]: [FATAL] Exceção não tratada: PromiseRejectionWarning" >> "$arq_app"
      echo "$agora srv-principal nodejs[3001]: [ERROR] Falha de segmentação - Propriedade 'data' inacessível" >> "$arq_app"
      echo "$agora srv-principal systemd[1]: [CRITICAL] Serviço 'node.service' encerrou com falha." >> "$arq_sys"
      ;;

    # 2 - Queda no Banco de Dados
    2)
      echo "$agora srv-principal mariadb[2200]: [ERROR] Conexão com o pool de dados perdida." >> "$arq_db"
      echo "$agora srv-principal mariadb[2200]: [ERROR] Código 2002 (HY000): Host de banco indisponível." >> "$arq_db"
      echo "$agora srv-principal systemd[1]: [CRITICAL] Serviço 'mysql.service' inativo." >> "$arq_sys"
      ;;

    # 3 - Esgotamento de Disco
    3)
      echo "$agora srv-principal kernel: [WARN] Capacidade do volume montado em / atingiu 98%." >> "$arq_disk"
      echo "$agora srv-principal kernel: [FATAL] Erro de I/O: No space left on device." >> "$arq_disk"
      echo "$agora srv-principal systemd[1]: [ERROR] Interrupção na gravação de logs (Disco Cheio)." >> "$arq_sys"
      ;;

    # 4 - Invasao via SSH (Forca Bruta)
    4)
      # Gera um IP falso na rede local
      ip_falso="192.168.1.$((RANDOM % 255))"
      echo "$agora srv-principal sshd[2222]: [ALERT] Falha de autenticação (password) para usuário root via $ip_falso porta 22 ssh2" >> "$arq_auth"
      ;;
  esac

  sleep 2
done