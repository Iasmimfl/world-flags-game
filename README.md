# Flag Game

## Descrição do Aplicativo

O **Flag Game** é um aplicativo móvel interativo e educativo desenvolvido com Flutter e Dart, cujo objetivo é testar e aprimorar os conhecimentos dos jogadores sobre as bandeiras dos países ao redor do mundo.

O projeto foi desenvolvido com foco em desempenho, usabilidade e design moderno, oferecendo funcionamento **100% offline**, sem dependência de conexão com a internet durante a utilização.

O aplicativo permite personalizar as partidas, escolhendo o tempo de jogo, o nível de dificuldade e a região geográfica das bandeiras. Também possui um sistema de recordes locais e suporte a múltiplos idiomas.

## Funcionalidades

### Modos de Jogo

- **Modo Aleatório (Global):** apresenta bandeiras de países de diferentes partes do mundo.
- **Modo por Continente:** permite selecionar bandeiras de um continente específico: África, América, Ásia, Europa ou Oceania.

### Configurações da Partida

- **Tempo de jogo:** opções de 30 segundos, 60 segundos, 3 minutos e 5 minutos.
- **Nível de dificuldade:** modo fácil, com países mais conhecidos, e modo difícil, que inclui países menos conhecidos.

### Funcionalidades Adicionais

- **Recorde local:** armazena a maior pontuação do jogador no dispositivo.
- **Suporte a múltiplos idiomas:** interface e nomes dos países disponíveis em português, inglês e espanhol.
- **Modo Estudo:** disponibiliza uma galeria de bandeiras com recurso de pesquisa para revisar os conteúdos antes de jogar.
- **Feedback visual:** apresenta indicações visuais imediatas para respostas corretas e incorretas.
- **Painel de resultados:** exibe o desempenho da partida, incluindo um gráfico circular de aproveitamento.

## Tecnologias e Recursos Utilizados

O projeto utiliza as seguintes tecnologias, bibliotecas e recursos:

- **Flutter:** framework utilizado para o desenvolvimento da interface e da aplicação móvel.
- **Dart:** linguagem de programação utilizada no desenvolvimento da lógica do aplicativo.
- **JSON:** arquivo utilizado para armazenar os dados dos países e permitir o acesso às informações offline.
- **Shared Preferences:** pacote utilizado para armazenar dados localmente, como o recorde do jogador.
- **Flutter SVG:** pacote utilizado para renderizar as imagens vetoriais das bandeiras no formato SVG.
- **Assets locais:** recursos integrados ao projeto para garantir o funcionamento sem conexão com a internet.

### Fonte das Bandeiras

As imagens das bandeiras utilizadas no projeto foram obtidas no repositório de código aberto [hampusborgos/country-flags](https://github.com/hampusborgos/country-flags).

## Pré-requisitos

Antes de executar o projeto, é necessário ter:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e configurado.
- [Git](https://git-scm.com/) instalado para clonar o repositório.
- [Visual Studio Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio) configurado para desenvolvimento Flutter.
- Um dispositivo Android conectado ao computador ou um emulador Android configurado.

## Instalação e Execução

Siga os passos abaixo para executar o aplicativo em seu ambiente de desenvolvimento.

### 1. Clone o repositório

```bash
git clone https://github.com/Iasmimfl/world-flags-game.git
```

### 2. Acesse a pasta do projeto

```bash
cd world-flags-game
```

### 3. Instale as dependências

```bash
flutter pub get
```

### 4. Verifique a configuração do ambiente

```bash
flutter doctor
```

### 5. Execute o aplicativo

Com um dispositivo Android conectado ou um emulador em execução, utilize:

```bash
flutter run
```

## Autora

**Iasmim Ferreira de Lima**

GitHub: [Iasmimfl](https://github.com/Iasmimfl)

## Repositório

O código-fonte do projeto está disponível no GitHub:
[https://github.com/Iasmimfl/world-flags-game](https://github.com/Iasmimfl/world-flags-game)

Link de vídeo demonstrativo no Youtube.
https://youtube.com/shorts/cSZG-HeetXU?is=y4OFePy7CmHXaJeV