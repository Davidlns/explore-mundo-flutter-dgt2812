import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color actionColor = Colors.teal;

    final Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Pacote Alpes Nevados',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'Kandersteg, Suica',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.red,
          ),
          SizedBox(width: 4),
          Text('4.9'),
        ],
      ),
    );

    final Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(actionColor, Icons.place, 'DESTINOS'),
        _buildButtonColumn(actionColor, Icons.card_travel, 'PACOTES'),
        _buildButtonColumn(actionColor, Icons.mail, 'CONTATO'),
      ],
    );

    final Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'A Explore Mundo apresenta uma experiencia inspirada no roteiro do '
        'trabalho pratico, com destaque para um destino alpino e acesso rapido '
        'a destinos, pacotes de viagem e contato com a agencia. A proposta '
        'valoriza uma interface simples e organizada em Flutter, usando imagem '
        'de destaque, secao de titulo com avaliacao, botoes de navegacao e um '
        'bloco de texto descritivo sobre a oferta turistica.',
        softWrap: true,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explore Mundo',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: actionColor,
          foregroundColor: Colors.white,
          title: const Text('Explore Mundo'),
        ),
        body: ListView(
          children: [
            Image.asset(
              'images/lake.jpg',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }
}
