# 🧮 Calculadora Híbrida em Assembly (x86-64)

Uma calculadora escrita totalmente em Assembly NASM para Linux 64 bits, com suporte a números decimais, operações básicas e modo interativo de execução.  
O executável final pode ser usado como um **comando global** do sistema, digitando apenas `calculadora` no terminal. 🧠⚙️

---

## 🚀 Funcionalidades
- 🧩 Suporte a **operações matemáticas básicas** (`+`, `-`, `*`, `/`)
- 💧 Cálculo com **números inteiros e decimais**
- 🔁 **Modo interativo:** execute várias operações seguidas sem reiniciar o programa
- 🧱 Tratamento de erros (como **divisão por zero**)
- 🧮 Integração com `printf` e `scanf` da **libc** (C)

---

## ⚙️ Tecnologias Utilizadas
- **NASM** – Montador Assembly
- **GCC** – Linkagem com libc e criação do executável
- **x86-64 Linux**

---

## 🧩 Estrutura do Código
| Seção | Função |
|-------|---------|
| `.data` | Mensagens, strings e formatações (`printf`, `scanf`) |
| `.bss` | Variáveis não inicializadas |
| `.text` | Código principal da calculadora |
| `.note.GNU-stack` | Marca a pilha como não executável (corrige aviso do linker) |

> A linha abaixo deve ser adicionada ao final do arquivo `calc_hybrid.asm` para evitar o aviso de compilação:
> ```asm
> section .note.GNU-stack noalloc noexec nowrite progbits
> ```

---

## ⚡ Compilação e Instalação

### 1️⃣ Montar o código Assembly
bash
nasm -f elf64 calc_hybrid.asm -o calc_hybrid.o


2️⃣ Linkar com a libc e gerar o executável

"gcc -no-pie calc_hybrid.o -o calculadora"

3️⃣ Instalar como comando global

"sudo mv calculadora /usr/local/bin/"
🔹 Após isso, o comando calculadora pode ser executado de qualquer diretório no sistema.


▶️ Execução

Agora basta digitar: calculadora

Exemplo de uso:
Digite: <num> <op> <num> (ou q pra sair): 34 * 23
Resultado: 782.0000
Digite: <num> <op> <num> (ou q pra sair): q
Saindo... valeu!


🧠 Detalhes Técnicos

Operações realizadas com registradores SSE2 (XMM) para ponto flutuante.

Entrada e saída tratadas via funções C padrão (scanf, printf).

Modo de loop até o usuário digitar q.

Compatível com Ubuntu, Linux Mint, Debian e derivados.

🧑‍💻 Autor:
David Moura (SudoPinguim)
Estudante de Engenharia de Software | Entusiasta em Cibersegurança e Sistemas de Baixo Nível ⚙️

📜 Licença
Distribuído sob a Licença MIT — uso livre para estudo, modificação e distribuição.

💬 Créditos e Observação
Esse projeto foi desenvolvido com foco educacional e técnico, mostrando como integrar Assembly com bibliotecas C e criar utilitários executáveis diretamente no Linux.
