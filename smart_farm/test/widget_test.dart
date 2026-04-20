import 'package:flutter_test/flutter_test.dart';
import 'package:smart_farm/main.dart';

/// Teste de widget básico que verifica se a aplicação inicializa e exibe
/// a saudação esperada na tela inicial.
void main() {
  testWidgets('App loads and shows greeting', (WidgetTester tester) async {
    await tester.pumpWidget(const SmartFarmApp());
    await tester.pumpAndSettle();

    expect(find.text('Olá LITA'), findsOneWidget);
  });
}
