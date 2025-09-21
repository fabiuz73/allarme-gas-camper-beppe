import 'package:flutter_test/flutter_test.dart';
import 'package:allarme_gas_beppe/main.dart';

void main() {
  testWidgets('App loads without errors', (WidgetTester tester) async {
    await tester.pumpWidget(GasAlarmApp());
    expect(find.byType(GasAlarmApp), findsOneWidget);
  });
}