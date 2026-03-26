# Resolução da 1ª Lista de Exercícios: Comandos Linux

**Instituição:** Instituto Federal de Educação, Ciência e Tecnologia do Ceará (IFCE) - Campus Boa Viagem  
**Curso:** Análise e Desenvolvimento de Sistemas (ADS)  
**Disciplina:** DevOPS  
**Professor:** Renato William  
**Aluno:** Erlano  

Este repositório contém as resoluções da primeira lista de exercícios práticos e teóricos focados na administração e operação de sistemas Linux e fundamentos de redes.

---

## 1) Execute os comandos solicitados em cada item:

### (a) COMANDOS PARA REINICIALIZAR OU DESLIGAR O COMPUTADOR

**i) Execute dois comandos para reinicializar o computador de forma imediata.**
```bash
reboot
shutdown -r now
```

**ii) Agende o desligamento do seu PC em uma hora específica.**
```bash
shutdown 15:30
```

**iii) Desligue seu PC depois de alguns minutos ou horas.**
```bash
shutdown +60
```

**iv) Desligue seu PC em um prazo de cinco minutos e informe através de uma mensagem a todos os usuários do sistema.**
```bash
shutdown +5 "Atenção: O sistema será desligado em 5 minutos para manutenção. Por favor, salvem seus trabalhos!"
```

### (b) COMANDOS DE NAVEGAÇÃO

**i) Exiba o diretório corrente.**
```bash
pwd
```

**ii) Exiba o conteúdo do diretório do usuário corrente.**
```bash
ls ~
```

**iii) Exiba o Conteúdo do diretório corrente com uma listagem completa incluindo os arquivos ocultos.**
```bash
ls -a
```

**iv) Exiba a árvore de diretórios do /etc/network.**
```bash
tree /etc/network
```

**v) Exiba uma lista completa e recursiva do diretório /etc/network.**
```bash
ls -R /etc/network
```

**vi) Listagem longa do diretório home, com detalhes. O que significa cada coluna da listagem?**
```bash
ls -l ~
```

**vii) Listagem longa de "/etc", ordenada alfabeticamente.**
```bash
ls -l /etc
```

**viii) Listagem curta de "/usr", recursiva e ordenada por tamanho.**
```bash
ls -RS /usr
```

**ix) Suba um nível no diretório corrente.**
```bash
cd ..
```

**x) Retorne ao diretório do usuário.**
```bash
cd ~
```

**xi) Mude para o diretório raiz.**
```bash
cd /
```

**xii) Retorne de forma imediata ao diretório anterior.**
```bash
cd -
```

### (c) COMANDOS PARA LOCALIZAÇÃO DE ARQUIVOS

**i) Utilize o find para localizar um ou vários arquivos como o nome interfaces em /etc.**
```bash
find /etc -name "interfaces"
```

**ii) Use o comando find para encontrar todos os links simbólicos presentes em /usr.**
```bash
find /usr -type l
```

**iii) Repita o item anterior utilizando o comando locate.**
```bash
locate /usr | xargs ls -ld 2>/dev/null | grep "^l"
```

### (d) COMANDOS DE MANIPULAÇÃO DE ARQUIVOS E DIRETÓRIOS

**i e ii) De acordo com a figura 1, criar a estrutura de diretórios dentro do /home/seuusuario. Tente criar mais de um diretório com um único comando.**
```bash
mkdir -p ~/diretorio01/diretorio01_{1,2} ~/diretorio02/diretorio02_1 ~/diretorio02/diretorio02_2/diretorio02_2_{1,2,3}
```

**iii e iv) Criar um arquivo chamado numeros.txt e inserir os números:**
```bash
cat << 'EOF' > numeros.txt
10
100
50
34
25
1
2
56
EOF
```

**v e vi) Criar um arquivo chamado disciplinas.txt e inserir os nomes:**
```bash
cat << 'EOF' > disciplinas.txt
Gerência de Redes
Laboratório de Desenvolvimento de Sistemas
Lógica de Programação
Sistemas Operacionais
Governança de Tecnologia da Informação
Redes de Computadores
EOF
```

**vii) Criar um arquivo chamado ListaDisciplinas.txt:**
```bash
cat << 'EOF' > ListaDisciplinas.txt
1.
2.
4.
6.
5.
EOF
```

**viii) Duplicar o arquivo numeros.txt para numeros1.1.txt, numeros2.1.txt e numeros2.2.1.txt.**
```bash
cp numeros.txt numeros1.1.txt && cp numeros.txt numeros2.1.txt && cp numeros.txt numeros2.2.1.txt
```

**ix) Duplicar o arquivo numeros.txt para numeros1.1.num, numeros2.1.num e numeros2.2.1.num.**
```bash
cp numeros.txt numeros1.1.num && cp numeros.txt numeros2.1.num && cp numeros.txt numeros2.2.1.num
```

**x) Duplicar o arquivo disciplinas.txt para disciplinas1.txt, disciplinas2.txt e disciplinas2.2.3.txt.**
```bash
cp disciplinas.txt disciplinas1.txt && cp disciplinas.txt disciplinas2.txt && cp disciplinas.txt disciplinas2.2.3.txt
```

**xi, xii e xiii) Mova os arquivos gerados para os respectivos diretórios criados:**
```bash
mv numeros1.1.num numeros1.1.txt disciplinas1.txt ~/diretorio01/diretorio01_1/
mv numeros2.1.num numeros2.1.txt disciplinas2.txt ~/diretorio02/diretorio02_1/
mv numeros2.2.1.num numeros2.2.1.txt disciplinas2.2.3.txt ~/diretorio02/diretorio02_2/diretorio02_2_1/
```

**xiv) Faça uma cópia de todos os diretórios e arquivos do diretório /etc/network para o diretorio01.**
```bash
cp -r /etc/network ~/diretorio01/
```

**xv) Faça a renomeação do arquivo numeros.txt para numerosAtualizados.txt.**
```bash
mv numeros.txt numerosAtualizados.txt
```

**xvi) Execute o seguinte comando ping e salve o resultado:**
```bash
ping -c10 [www.google.com](https://www.google.com).br > request.txt
```

**xvii) Utilizando o comando rmdir tente remover o diretório1.2 e o diretório2.1.**
```bash
rmdir ~/diretorio01/diretorio01_2 ~/diretorio02/diretorio02_1
```

**xviii) Remova todos os arquivos que terminem com .num de forma recursiva e exibindo o nome de cada arquivo antes de eliminá-lo.**
```bash
find . -name "*.num" -exec rm -v {} \;
```

### (e) COMANDOS DE FILTRAGEM E PAGINAÇÃO

**i) Mostre o conteúdo total do arquivo request.txt.**
```bash
cat request.txt
```

**ii) Mostre as primeiras cinco linhas do arquivo request.txt.**
```bash
head -n 5 request.txt
```

**iii) Mostre apenas a última linha do arquivo request.txt.**
```bash
tail -n 1 request.txt
```

**iv) Conte o número de linhas do arquivo request.txt.**
```bash
wc -l request.txt
```

**v) Mostre a quantidade de palavras do arquivo request.txt.**
```bash
wc -w request.txt
```

**vi) Substitua letras minúsculas por maiúsculas no arquivo disciplinas.txt criando um novo arquivo na mesma linha de execução.**
```bash
tr '[:lower:]' '[:upper:]' < disciplinas.txt > disciplinasMaiusculas.txt
```

**vii) Organize na ordem crescente o arquivo numerosAtualizados.txt criando um novo arquivo.**
```bash
sort -n numerosAtualizados.txt > numerosOrdemCrescente.txt
```

**viii) Organize na ordem decrescente o arquivo numerosAtualizados.txt criando um novo arquivo.**
```bash
sort -nr numerosAtualizados.txt > numerosOrdemDesCrescente.txt
```

**ix) Organize na ordem crescente o arquivo disciplinas.txt criando um novo arquivo.**
```bash
sort disciplinas.txt > disciplinasOrdemCrescente.txt
```

**x) Organize na ordem crescente o arquivo ListaDisciplinas.txt criando um novo arquivo.**
```bash
sort -n ListaDisciplinas.txt > ListaDisciplinasAtualizada.txt
```

**xi) Cole o conteúdo do arquivo ListaDisciplinas.txt com o arquivo disciplinas.txt e gere listanumerada.txt.**
```bash
paste ListaDisciplinas.txt disciplinas.txt > listanumerada.txt
```

**xii) Mostre apenas a primeira coluna do arquivo request.txt.**
```bash
awk '{print $1}' request.txt
```

**xiii) Mostre apenas a coluna que contém os tempos de cada requisição ping do arquivo request.txt.**
```bash
awk '{print $7, $8}' request.txt
```

**xiv) Mostre apenas a coluna que contém o endereço ip do arquivo request.txt.**
```bash
awk '{print $4}' request.txt
```

---

## Questões Teóricas

**2) Nas distribuições Linux, as principais bibliotecas de sistema e os arquivos de configuração e scripts de inicialização ficam armazenados em quais diretórios?**
> Nas distribuições Linux, as principais **bibliotecas de sistema** ficam armazenadas nos diretórios `/lib` e `/usr/lib`. Já os **arquivos de configuração** globais e os **scripts de inicialização** ficam centralizados no diretório `/etc`.

**3) Descreva o que é o ping e em que casos ele é utilizado?**
> O **ping** é um utilitário de administração de rede que utiliza o protocolo ICMP para testar a conectividade entre equipamentos. Ele funciona enviando pacotes de requisição (*Echo Request*) e aguardando pacotes de resposta (*Echo Reply*). Ele é utilizado para:
> 1. Verificar se um dispositivo está acessível na rede.
> 2. Medir a latência (tempo de resposta) da comunicação.
> 3. Diagnosticar perda de pacotes ou falhas na conexão.

**4) Definição de Sub-redes e IPs para a LAN (192.168.100.0/24)**
> **1. Divisão do Bloco (Subnetting):**
> O bloco `/24` foi dividido em duas sub-redes utilizando a máscara `/25` (`255.255.255.128`), gerando fatias de 128 endereços.
> 
> **2. Definição de IPs para os Dispositivos Finais:**
> * **Sub-rede A (Computadores) - Rede 192.168.100.0/25**
>   * Computador 1: `192.168.100.10`
>   * Computador 2: `192.168.100.11`
>   * Notebook: `192.168.100.12`
>   * Máscara para todos: `255.255.255.128`
> 
> * **Sub-rede B (Telefonia) - Rede 192.168.100.128/25**
>   * Telefone IP: `192.168.100.130`
>   * Máscara: `255.255.255.128`
> 
> **3. Endereço do Servidor/Gateway:**
> Para comunicar com as duas redes através do switch, o servidor precisará de interfaces virtuais respondendo por um IP em cada sub-rede:
> * Interface 1 (Gateway Rede A): `192.168.100.1`
> * Interface 2 (Gateway Rede B): `192.168.100.129`
