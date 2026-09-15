import 'package:flutter_test/flutter_test.dart';

import 'package:ashwanth_portfolio/main.dart';

void main() {
  testWidgets('Portfolio app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const AshwanthPortfolioApp());

    expect(find.text('Ashwanth Portfolio'), findsOneWidget);
  });
}
