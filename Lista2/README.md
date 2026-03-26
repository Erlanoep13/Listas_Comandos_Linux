# Resolução da 2ª Lista de Exercícios: Administração de Usuários e Permissões Linux

**Instituição:** Instituto Federal de Educação, Ciência e Tecnologia do Ceará (IFCE) - Campus Boa Viagem  
**Curso:** Análise e Desenvolvimento de Sistemas (ADS)  
**Disciplina:** DevOPS  
**Professor:** Renato William  
**Aluno:** Erlano  

Este repositório contém as resoluções da segunda lista de exercícios práticos e teóricos focados na administração de usuários, grupos e gerenciamento de permissões de arquivos e diretórios no Linux.

---

## 1) Criação de Usuários, Diretórios e Grupos

**1. Cadastre os usuários alice, bob, carlos, daniel e erica.**
```bash
sudo useradd -m alice
sudo useradd -m bob
sudo useradd -m carlos
sudo useradd -m daniel
sudo useradd -m erica
```

**2. Crie no seu diretório home os diretórios producao, rh, financeiro e ti.**
```bash
mkdir ~/producao ~/rh ~/financeiro ~/ti
```

**3. Cadastre os grupos funcionarios, gerentes e informatica.**
```bash
sudo groupadd funcionarios
sudo groupadd gerentes
sudo groupadd informatica
```

---

## 2) Gerenciamento de Membros de Grupos

**Colocar os usuários dentro do grupo conforme abaixo:**
* **funcionarios:** alice, daniel, erica.
* **gerentes:** bob, carlos
* **informatica:** carlos, alice.

```bash
# Adicionando ao grupo funcionarios
sudo usermod -aG funcionarios alice
sudo usermod -aG funcionarios daniel
sudo usermod -aG funcionarios erica

# Adicionando ao grupo gerentes
sudo usermod -aG gerentes bob
sudo usermod -aG gerentes carlos

# Adicionando ao grupo informatica
sudo usermod -aG informatica carlos
sudo usermod -aG informatica alice
```

---

## 3) Alteração de Propriedade (Donos e Grupos)

**Alterar o usuário dono dos diretórios conforme abaixo:**

* **producao** - usuário dono bob e grupo funcionarios.
```bash
sudo chown bob:funcionarios ~/producao
```
* **rh** - usuário dono erica e grupo gerentes.
```bash
sudo chown erica:gerentes ~/rh
```
* **financeiro** - usuário dono bob e grupo gerentes.
```bash
sudo chown bob:gerentes ~/financeiro
```
* **ti** - usuário dono carlos e grupo informatica.
```bash
sudo chown carlos:informatica ~/ti
```

---

## 4) Alteração de Permissões de Acesso

**Altere as permissões dos diretórios conforme abaixo:**

* **producao:** Usuário e outros somente leitura. Grupo leitura, escrita e execução. *(Octal: 474)*
```bash
sudo chmod 474 ~/producao
```
* **rh:** Usuário e outros sem permissão. Grupo leitura, escrita e execução. *(Octal: 070)*
```bash
sudo chmod 070 ~/rh
```
* **financeiro:** Usuário somente leitura, grupo escrita e execução e outros nenhuma. *(Octal: 430)*
```bash
sudo chmod 430 ~/financeiro
```
* **ti:** Usuário leitura, escrita e execução, grupo leitura e outros nenhuma. *(Octal: 740)*
```bash
sudo chmod 740 ~/ti
```

---

## 5) Análise de Permissões e Diretórios (Comando ls -l)

Supondo os detalhes dos arquivos pertencentes a um determinado diretório (Figura 1), as respostas para a análise são:

**a) Quais os nomes dos diretórios contidos nessa relação? Qual o nome do arquivos contidos nesta relação?**
* **Diretórios:** `pgms`, `teste1`, `teste2`, `Faturamento`. *(Identificados pela letra 'd' no início da primeira coluna).*
* **Arquivos:** `Controle`, `mbox`, `exemplo`, `Linux`. *(Identificados pelo traço '-' no início da primeira coluna).*

**b) Existe algum usuário do mesmo grupo de Rui? Caso positivo, qual?**
* Sim. O usuário Rui pertence ao grupo "Contab". Os usuários **Pedro** e **Tiago** também pertencem a esse mesmo grupo.

**c) Qual o tamanho do arquivo Controle?**
* O tamanho do arquivo é de **1565 bytes**.

**d) Quais as permissões de acesso que os usuários do mesmo grupo de João possuem para acessar o arquivo Controle?**
* O grupo de João ("Financ") possui permissão de **leitura e gravação/escrita** (`rw-`) no arquivo Controle.

**e) Eu sou do grupo do usuário Pedro, que permissões tenho com relação ao arquivo exemplo?**
* Sendo do grupo "Contab" (mesmo de Pedro e dono do arquivo), você teria permissão de **leitura e execução** (`r-x`).

**f) Diga o comando completo para permitir que os usuários do mesmo grupo de Rui possam ler e gravar, mas não possam executar o arquivo Linux.**
* `chmod g=rw Linux` *(ou em octal: `chmod 764 Linux` para manter as demais)*.

**g) Qual o código octal para a permissão de acesso do arquivo exemplo?**
* O código octal é **755** (rwx = 7, r-x = 5, r-x = 5).

**h) Qual o código literal para a permissão de acesso do arquivo exemplo?**
* O código literal é **rwxr-xr-x**.

**i) Altere o dono do arquivo Linux para Rui.**
* `sudo chown Rui Linux`

**j) Altere o grupo do arquivo Linux para Staff.**
* `sudo chgrp staff Linux` *(ou `sudo chown :staff Linux`)*.