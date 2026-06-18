import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  testWidgets('GoogleFonts can be used without crashing', (WidgetTester tester) async {
    // This test verifies that the google_fonts package is correctly integrated
    // and doesn't cause a constant evaluation error or runtime crash.
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'Hello Google Fonts',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );

    final textWidget = tester.widget<Text>(find.text('Hello Google Fonts'));
    expect(textWidget.style?.fontFamily, contains('Poppins'));
    expect(textWidget.style?.fontWeight, FontWeight.bold);
  });

  test('GoogleFonts config can be accessed', () {
    // Another quick check to ensure the library is loaded correctly
    expect(GoogleFonts.config.allowRuntimeFetching, isTrue);
  });
}
