# Automação e Monitoramento de Sistemas com Shell Script

**Instituição:** Instituto Federal de Educação, Ciência e Tecnologia do Ceará (IFCE) - Campus Boa Viagem  
**Curso:** Análise e Desenvolvimento de Sistemas (ADS)  
**Disciplina:** DevOPS  
**Professor:** Renato William  
**Aluno:** Erlano  

Este repositório reúne um conjunto de scripts desenvolvidos para simplificar a administração de servidores Linux. O foco principal é a automação de rotinas de manutenção, monitoramento contínuo de recursos físicos e validação de disponibilidade de serviços web.

---

## Por que automatizar?

A automação via Shell Script é uma prática indispensável para equipes de TI e desenvolvedores. Ela deve ser aplicada prioritariamente em tarefas que exigem execução **frequente**, processos **críticos** de infraestrutura e operações complexas onde a intervenção manual eleva o risco de falhas humanas.

---

## Minha Proposta de Script (Próximos Passos)

**Script Automação de Deploy e Backup de Banco de Dados**
Uma ferramenta que eu criaria seria um script automatizado para rotinas de backup e deploy de aplicações web (como projetos em Node.js ou Laravel). Esse script faria o *dump* automático do banco de dados (ex: PostgreSQL), compactaria os arquivos essenciais do projeto para uma pasta segura e reiniciaria os serviços web, enviando um log de sucesso ou falha ao final do processo.

---

## A Relação com a Cultura DevOps

A criação desses scripts está diretamente ligada aos pilares do DevOps:

* **Monitoramento Proativo (Observabilidade e SRE):** A coleta constante de dados do sistema (como uso de RAM e CPU) e sua conversão em logs compreensíveis permite antecipar falhas e gargalos antes que impactem a aplicação e o usuário final.
* **Padronização (Infraestrutura como Código - IaC):** Garantir que rotinas de atualização e manutenção sejam scriptadas, versionadas e fáceis de replicar, eliminando a dependência de configurações manuais em diferentes servidores.
* **Validação Contínua (CI/CD):** A utilização de scripts de verificação (*health checks*) assegura que aplicações web permaneçam online e respondendo com o status HTTP correto após a integração de novas atualizações.

---

## Estrutura do Repositório (Scripts Desenvolvidos)

Abaixo estão os scripts incluídos neste projeto e suas respectivas funções:

* `monitor_disco.sh`: Laço de repetição contínuo para avaliação do espaço de armazenamento disponível na máquina.
* `users.sh`: Exibe de forma rápida os usuários logados no momento e o volume total de sessões ativas no terminal.
* `update_system.sh`: Rotina completa de atualização de pacotes (via `apt`) e higienização do sistema, removendo dependências ociosas.
* `file_explorer.sh`: Ferramenta interativa de navegação via terminal para listar diretórios, visualizar o conteúdo de arquivos e realizar execuções sem precisar digitar os caminhos absolutos.
* `monitor_acesso_livre.sh`: Realiza requisições HTTP periódicas via `curl` para validar se uma URL específica está online e acessível.
* `monitor_sistema.sh`: Script mestre para acompanhamento integrado de CPU, Memória RAM e Disco. Emite alertas visuais críticos e gera o histórico de eventos no arquivo `monitoramento_sistema.log`.