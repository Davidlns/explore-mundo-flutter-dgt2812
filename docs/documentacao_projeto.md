# Documentacao do Projeto

## Identificacao

- Disciplina: DGT2812 Desenvolvimento de Aplicativos Moveis com Flutter
- Projeto: Explore Mundo Flutter
- Tipo: Trabalho pratico individual

## Objetivo

Desenvolver uma aplicacao Flutter seguindo o roteiro apresentado no material da pratica. O projeto foi construindo com base na sequencia proposta no documento: criacao do app, estrutura inicial, secao de titulo, secao de botoes, secao de texto, inclusao de imagem e organizacao final com `ListView`.

## Solucao desenvolvida

Foi criada uma interface unica para a agencia de viagens Explore Mundo. A tela apresenta:

- uma imagem de destaque na parte superior
- uma secao de titulo com nome do pacote, localizacao e avaliacao
- uma linha de botoes para destinos, pacotes e contato
- um bloco de texto descritivo da proposta turistica

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

## Validacao executada

Foram executadas as seguintes verificacoes:

- `flutter analyze`
- `flutter test`
- `flutter build web`

Todas as validacoes passaram com sucesso.

## Conclusao

O projeto foi entregue de acordo com a orientacao do material, contemplando a estrutura pedida no roteiro e incluindo a documentacao em PDF dentro do repositorio para apoiar a entrega final.
