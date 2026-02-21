import 'package:flutter_test/flutter_test.dart';
import 'package:stock_trade_android/presentation/app/app.dart';

void main() {
  testWidgets('App renders main shell', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Market'), findsWidgets);
  });
}
