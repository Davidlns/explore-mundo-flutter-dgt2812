# Documentacao do Projeto

## Identificacao

- Disciplina: DGT2812 Desenvolvimento de Aplicativos Moveis com Flutter
- Projeto: Explore Mundo Flutter
- Tipo: Trabalho pratico individual
- Autor: David Lins do Amaral

## Autoria

Este projeto foi desenvolvido por David Lins do Amaral.

## Objetivo

Desenvolver uma aplicacao Flutter seguindo o roteiro apresentado no material da pratica. O projeto foi construindo com base na sequencia proposta no documento: criacao do app, estrutura inicial, secao de titulo, secao de botoes, secao de texto, inclusao de imagem e organizacao final com `ListView`.

## Solucao desenvolvida

Foi criada uma aplicacao responsiva para a agencia de viagens Explore Mundo. A experiencia apresenta:

- banner interativo com destaque visual e CTA
- secao de destinos com filtro por escolha do usuario
- secao de pacotes com pesquisa textual e acao de reserva
- area de avaliacoes com media de estrelas
- formulario para envio de comentarios
- secao de contato com botoes de acao

## Tecnologias utilizadas

- Flutter
- Dart
- Git

## Arquivos principais

- `lib/main.dart`
- `pubspec.yaml`
- `images/lake.jpg`

## Passos aplicados do roteiro

1. Criacao de um novo aplicativo Flutter.
2. Substituicao do conteudo de `lib/main.dart`.
3. Definicao da estrutura inicial com `MaterialApp` e `Scaffold`.
4. Construcao da secao de titulo com `Container`, `Row`, `Column` e `Expanded`.
5. Construcao da secao de botoes com o metodo `_buildButtonColumn()`.
6. Definicao da secao de texto com `Container` e `Text`.
7. Adicao da imagem `images/lake.jpg` como ativo no `pubspec.yaml`.
8. Organizacao final do corpo da aplicacao com `ListView`.
9. Expansao da solucao para incluir interatividade, responsividade e compartilhamento de comentarios.

## Recursos interativos adicionados

- navegacao entre secoes da pagina
- filtragem de destinos
- pesquisa de pacotes
- acao simulada de reserva
- exibicao de media de avaliacoes
- envio de comentarios pelo usuario

## Validacao executada

Foram executadas as seguintes verificacoes:

- `flutter analyze`
- `flutter test`
- `flutter build web`

Todas as validacoes passaram com sucesso.

## Conclusao

O projeto foi entregue de acordo com a orientacao do material, contemplando a estrutura pedida no roteiro e incluindo a documentacao em PDF dentro do repositorio para apoiar a entrega final.
