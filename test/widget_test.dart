import 'package:explore_mundo_flutter/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Renderiza a estrutura principal do trabalho pratico', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Explore Mundo'), findsOneWidget);
    expect(find.text('Pacote Alpes Nevados'), findsOneWidget);
    expect(find.text('DESTINOS'), findsOneWidget);
    expect(find.text('PACOTES'), findsOneWidget);
    expect(find.text('CONTATO'), findsOneWidget);
    expect(find.text('4.9'), findsOneWidget);
  });
}
