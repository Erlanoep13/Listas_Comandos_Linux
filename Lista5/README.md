# Relatório de Laboratório: Monitoramento, Análise de Logs e Resposta a Incidentes

**Instituição:** Instituto Federal de Educação, Ciência e Tecnologia do Ceará (IFCE) - Campus Boa Viagem  
**Curso:** Análise e Desenvolvimento de Sistemas (ADS)  
**Disciplina:** DevOPS  
**Professor:** Renato William  
**Aluno:** Erlano Benevides de Sousa  

Este documento detalha os processos de investigação de incidentes em servidores Linux através da análise de logs, desde a observação manual até a criação de rotinas automatizadas de *Auto-Heal* (Autocura).

---

## Fase 1: Exploração e Observação

**Comandos base utilizados:**
* **Listagem detalhada do diretório:** `ls -lah lab_logs/`
* **Monitoramento contínuo (ao vivo):** `tail -f lab_logs/*.log`

**Compreensão dos Serviços Monitorados:**
* **systemd:** O "coração" do Linux moderno. Responsável por iniciar e gerenciar todos os serviços e processos do sistema opercional.
* **node:** O motor de execução em tempo real (runtime) onde a aplicação backend ou API está rodando.
* **mysql:** O Sistema de Gerenciamento de Banco de Dados Relacional (RDBMS) utilizado pela aplicação.
* **sshd:** O daemon do OpenSSH, responsável por escutar e autenticar conexões remotas seguras no servidor.

---

## Fase 2: Investigação de Falhas (Filtros Estáticos)

Utilizamos o comando `grep` para filtrar anomalias isoladas nos arquivos de log:

* **Aplicação (Erros no código):** `grep -i "error" lab_logs/app.log`
* **Banco de Dados (Conexão e operações):** `grep -i "error" lab_logs/db.log`
* **Segurança (Tentativas de Força Bruta):** `grep "Failed password" lab_logs/auth.log`
* **Infraestrutura (Armazenamento):** `grep "No space left" lab_logs/disk.log`

---

## Fase 3: Correlação de Eventos e Efeito Cascata

**(a) Visão do Sistema vs. Aplicação:** O arquivo `syslog` fornece uma visão macro da infraestrutura (avisando, por exemplo, que um serviço parou). Já o `app.log` desce a nível de código, detalhando a causa raiz exata (como um erro de lógica `Cannot read property`).

**(b) O Efeito Dominó (Falhas em Cascata):** Ficou claro na análise que falhas estruturais derrubam o resto. Quando o disco atinge 100% de uso, o banco de dados (MySQL) não consegue mais gravar ou ler dados e trava. Consequentemente, a aplicação (Node.js) perde a conexão com o banco de dados e também sofre "crash", resultando em inatividade total.

**(c) Incidência Principal:** O incidente de maior impacto e repetição nos logs foi o esgotamento total do espaço de armazenamento (71 ocorrências).

---

## Fase 4: Automação do Monitoramento (Shell Script)

Para otimizar o trabalho do SysAdmin, foram desenvolvidas duas soluções em Bash:
1.  **Auditoria Passiva (`monitor.sh`):** Realiza uma varredura combinando `grep -q` e `grep -c` para contar e estruturar relatórios de tentativas de invasão e falhas no backend.
2.  **Auditoria Ativa (`tempo_real.sh`):** Utiliza o `tail -F` com expressões regulares para monitorar todos os logs simultaneamente, mudando a cor do terminal para vermelho sempre que palavras-chave críticas (ERROR, WARNING, FATAL) aparecem.

---

## Fase 5: Plano de Ação e Resposta a Incidentes

**(a) Medidas de Mitigação:**
* **Backend / Banco de Dados:** Reinicialização imediata dos processos afetados via `sudo systemctl restart node` e `sudo systemctl restart mysql`.
* **Gargalo de Armazenamento:** Liberação emergencial de espaço rotacionando logs antigos (`journalctl --vacuum-time=1d`) e redimensionamento futuro do volume do disco.
* **Ataques SSH:** Bloqueio dos IPs agressores no Firewall (`ufw deny`), alteração da porta padrão do SSH, obrigatoriedade de chaves criptográficas (desabilitando senhas) e implementação do `Fail2Ban`.

**(b) Rastreamento de Invasores (Top 5 IPs Ofensores):**
Comando utilizado para extrair, agrupar e classificar os IPs que mais tentaram invadir o servidor:
`awk '{print $13}' lab_logs/auth.log | sort | uniq -c | sort -nr | head -n 5`

---

## Desafio Final: Implementação de Auto-Heal (Autocura)

Foi criado o script `auto-heal.sh` para atuar como um vigia autônomo. Em vez de apenas emitir alertas, ele detecta a anomalia (como a queda do Node.js) e toma a iniciativa de executar comandos de recuperação sem necessidade de intervenção humana.

---

## Questões para Discussão (Conclusão)

* **Qual tipo de falha é mais crítica?** Ambas são fatais de formas diferentes. Falhas de disco geram indisponibilidade total em cascata. Falhas de segurança (como quebra de SSH) podem ser silenciosas e comprometer completamente o sigilo dos dados e a integridade da máquina.
* **Os logs ajudam na prevenção?** Absolutamente. O monitoramento contínuo de `warnings` (avisos) permite detectar que um disco está chegando a 85%, dando tempo para a equipe agir dias antes de ele atingir os 100% e derrubar o sistema.
* **Como automatizar a resposta?** Por meio de diretrizes nativas de reinício de serviços (`Restart=always` no systemd), scripts de automação como os desenvolvidos neste laboratório, e ferramentas de defesa ativa como o `Fail2Ban` para banir invasores em tempo real.