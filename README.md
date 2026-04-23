# Explore Mundo Flutter

Projeto desenvolvido em Flutter como trabalho pratico da disciplina `DGT2812 Desenvolvimento de Aplicativos Moveis com Flutter`.

## Autor

- David Lins do Amaral
- Projeto desenvolvido por David Lins do Amaral

## O que foi implementado

- Estrutura inicial com `MaterialApp`, `Scaffold` e `AppBar`
- Banner interativo com destaque visual e navegacao por acoes
- Interface responsiva para mobile, tablet e desktop
- Secao de destinos com filtro interativo
- Secao de pacotes com pesquisa e botoes de reserva
- Secao de avaliacoes com media de estrelas e comentarios
- Formulario para envio de novos comentarios
- Imagem de destaque carregada via `pubspec.yaml`
- Organizacao final do corpo em `ListView`

## Aderencia ao roteiro do projeto

O desenvolvimento foi realizado com base no passo a passo descrito no material da pratica.
Foram seguidos os elementos centrais do roteiro:

- criacao do aplicativo em Flutter
- estruturacao com `MaterialApp` e `Scaffold`
- montagem da secao de titulo
- montagem da secao de botoes
- definicao da secao de texto
- adicao da imagem `lake.jpg`
- organizacao final do conteudo em `ListView`

Depois de cumprir essa base, o projeto recebeu melhorias intencionais de interatividade
e responsividade para aproximar a aplicacao do resultado esperado descrito no proprio
enunciado. Essas melhorias nao substituem o que foi pedido; elas expandem a solucao de
forma coerente com o tema da agencia Explore Mundo.

## Estrutura relevante

- `lib/main.dart`: implementacao principal da interface
- `images/lake.jpg`: imagem adicionada como ativo do app
- `docs/documentacao_projeto.md`: fonte textual da documentacao
- `docs/documentacao_projeto.pdf`: documentacao em PDF para entrega

## Como executar

1. Garanta que o Flutter esteja instalado e acessivel no terminal.
2. Entre na pasta do projeto.
3. Execute `flutter pub get`.
4. Execute `flutter run`.

## Como validar

- `flutter analyze`
- `flutter test`
- `flutter build web`

## Experiencia da aplicacao

O app agora vai alem de uma tela estatica. A interface inclui navegacao entre secoes,
filtro por destino, cards de pacotes, widgets de avaliacao e envio de comentarios,
atendendo melhor ao resultado esperado descrito no enunciado da pratica.

## Entrega

O material da pratica pede:

- projeto armazenado em repositorio Git
- documentacao do projeto em PDF no repositorio
- compartilhamento do link do repositorio com o tutor

Este repositorio ja contem a documentacao em PDF para atender a essa exigencia.
