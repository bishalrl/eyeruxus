import 'package:eye_rex_us/app/app.dart';
import 'package:eye_rex_us/app/di/injection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    await configureDependencies();
  });

  testWidgets('EyeRexApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const EyeRexApp());
    await tester.pump();
    expect(find.byType(EyeRexApp), findsOneWidget);
  });
}
