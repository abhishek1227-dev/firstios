import 'package:flutter_test/flutter_test.dart';

import 'package:firstios/main.dart';

void main() {
  testWidgets('Welcome screen shows first app message', (WidgetTester tester) async {
    await tester.pumpWidget(const FirstIosApp());

    expect(find.text('hey its my first ios app'), findsOneWidget);
    expect(find.text('Built with Flutter for Android and iOS.'), findsOneWidget);
  });
}
