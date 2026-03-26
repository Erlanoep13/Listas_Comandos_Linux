# Resolução da 3ª Lista de Exercícios: Filtros e Manipulação de Textos no Linux

**Instituição:** Instituto Federal de Educação, Ciência e Tecnologia do Ceará (IFCE) - Campus Boa Viagem  
**Curso:** Análise e Desenvolvimento de Sistemas (ADS)  
**Disciplina:** DevOPS  
**Professor:** Renato William  
**Aluno:** Erlano  

Este repositório contém as resoluções da terceira lista de exercícios focados na exploração de arquivos do sistema operacional e na manipulação de fluxos de texto utilizando ferramentas como `grep`, `sed`, `cut` e `wc`.

---

## 1) Descoberta de Hardware sem Interface Gráfica (/proc/cpuinfo)

**Cenário:** Inicialização de um laptop a partir de um pen drive USB sem interface gráfica. Descobrir a quantidade de processadores lendo o arquivo `/proc/cpuinfo`.

**(a) Usando os comandos grep e wc, exiba o número de processadores presentes.**
```bash
grep "^processor" /proc/cpuinfo | wc -l
```

**(b) Faça o mesmo com sed em vez de grep.**
```bash
sed -n '/^processor/p' /proc/cpuinfo | wc -l
```

---

## 2) Exploração do Arquivo de Usuários (/etc/passwd)

**Explore o arquivo local `/etc/passwd` com os comandos grep, sed, head e tail de acordo com as tarefas descritas abaixo:**

**(a) Quais usuários têm acesso a um shell Bash?**
```bash
grep "/bin/bash" /etc/passwd
```

**(b) Muitos dos usuários de seu sistema existem para lidar com programas específicos ou para fins administrativos. Eles não têm acesso a um shell. Quantos deles estão presentes no sistema?**
```bash
grep -E "nologin|false" /etc/passwd | wc -l
```

**(c) Quantos usuários e grupos existem em seu sistema (lembre-se: use apenas o arquivo /etc/passwd)?**
```bash
# Para contar o número de usuários (linhas do arquivo):
wc -l < /etc/passwd

# Para contar o número de grupos únicos:
cut -d: -f4 /etc/passwd | sort -u | wc -l
```

**(d) Liste apenas a primeira, a última e a décima linha do arquivo /etc/passwd.**
```bash
sed -n '1p;10p;$p' /etc/passwd
```

---

## 3) Filtragem Específica de Grupos e Nomes

**Considere um arquivo local chamado `mypasswd` baseado no `/etc/passwd` para este exercício.**

**(a) Liste todos os usuários no grupo 1000 (use sed para selecionar apenas o campo apropriado) do arquivo mypasswd.**
```bash
sed -n 's/^\([^:]*\):[^:]*:[^:]*:1000:.*/\1/p' mypasswd
```

**(b) Liste apenas o nome completo de todos os usuários deste grupo (use sed e cut).**
```bash
sed -n '/^[^:]*:[^:]*:[^:]*:1000:/p' mypasswd | cut -d: -f5
```

---

## 4) Sorteio de Rifa com Pipeline (O Grande Vencedor)

**Cenário:** Usando o arquivo `mypasswd`, crie um comando Bash que selecione um indivíduo do "Main Office" para ganhar uma rifa. Use `sed` para imprimir apenas as linhas do Main Office, `cut` para recuperar o primeiro nome, classifique aleatoriamente e imprima apenas o vencedor.

**Comando Completo (Pipeline):**
```bash
sed -n '/Main Office/p' mypasswd | cut -d: -f5 | cut -d, -f1 | cut -d' ' -f1 | sort -R | head -n 1
```