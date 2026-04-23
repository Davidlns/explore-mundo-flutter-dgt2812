import 'package:explore_mundo_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Renderiza a experiencia interativa principal', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Explore Mundo'), findsWidgets);
    expect(find.text('Ver pacotes'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Destinos em destaque'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('Destinos em destaque'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Pacotes de viagem'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('Pacotes de viagem'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Compartilhe sua experiencia'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('Avaliacoes e comentarios'), findsOneWidget);
    expect(find.text('Compartilhe sua experiencia'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Contato da agencia'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('Contato da agencia'), findsOneWidget);

    await tester.enterText(
      find.byType(TextField).last,
      'Experiencia muito boa com os pacotes.',
    );
    await tester.ensureVisible(find.text('Enviar comentario'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enviar comentario'));
    await tester.pumpAndSettle();

    expect(find.text('Experiencia muito boa com os pacotes.'), findsOneWidget);
  });
}
