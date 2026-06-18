import 'package:flutter/material.dart';


class MyGuardianScreen extends StatelessWidget {
  const MyGuardianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A3728), // Brown tone at top
              Color(0xFF2B1F17), // Darker brown at bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [


              // Empty State Illustration
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Illustration
                    SizedBox(
                      width: size.width * 0.6,
                      height: size.width * 0.4,
                      child: CustomPaint(
                        painter: EmptyStatePainter(),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Text
                    const Text(
                      'You haven\'t guarded someone yet.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabText extends StatelessWidget {
  final String text;
  final bool isSelected;

  const _TabText(this.text, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: isSelected ? Colors.white : Colors.white54,
        fontSize: 16,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      ),
    );
  }
}

class EmptyStatePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final center = Offset(size.width / 2, size.height / 2);

    // Draw ground/hill
    paint.color = const Color(0xFF8B7355); // Brown ground color
    paint.style = PaintingStyle.fill;

    final groundPath = Path();
    groundPath.moveTo(0, size.height * 0.7);
    groundPath.quadraticBezierTo(
      size.width / 2, size.height * 0.5,
      size.width, size.height * 0.7,
    );
    groundPath.lineTo(size.width, size.height);
    groundPath.lineTo(0, size.height);
    groundPath.close();

    canvas.drawPath(groundPath, paint);

    // Draw clouds
    paint.color = const Color(0xFF6B6B6B); // Gray clouds

    // Left cloud
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.3),
      20,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.32),
      15,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.32),
      12,
      paint,
    );

    // Right cloud
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.25),
      18,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.27),
      12,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.7, size.height * 0.27),
      10,
      paint,
    );

    // Draw tent/house structure
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    // Main tent body (trapezoid)
    final tentPath = Path();
    tentPath.moveTo(size.width * 0.35, size.height * 0.65); // Bottom left
    tentPath.lineTo(size.width * 0.65, size.height * 0.65); // Bottom right
    tentPath.lineTo(size.width * 0.6, size.height * 0.45);  // Top right
    tentPath.lineTo(size.width * 0.4, size.height * 0.45);  // Top left
    tentPath.close();

    canvas.drawPath(tentPath, paint);

    // Tent roof/top
    final roofPath = Path();
    roofPath.moveTo(size.width * 0.4, size.height * 0.45);  // Left
    roofPath.lineTo(size.width * 0.5, size.height * 0.35);  // Peak
    roofPath.lineTo(size.width * 0.6, size.height * 0.45);  // Right
    roofPath.close();

    canvas.drawPath(roofPath, paint);

    // Add some shading to tent
    paint.color = const Color(0xFFE0E0E0);
    final shadePath = Path();
    shadePath.moveTo(size.width * 0.5, size.height * 0.45);
    shadePath.lineTo(size.width * 0.65, size.height * 0.65);
    shadePath.lineTo(size.width * 0.6, size.height * 0.45);
    shadePath.close();

    canvas.drawPath(shadePath, paint);

    // Draw small tree
    paint.color = const Color(0xFF8B7355); // Tree trunk color
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.72,
        size.height * 0.55,
        6,
        15,
      ),
      paint,
    );

    // Tree leaves
    paint.color = const Color(0xFF90EE90); // Light green
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.75, size.height * 0.5),
        width: 20,
        height: 15,
      ),
      paint,
    );

    // Draw flag pole
    paint.color = const Color(0xFF8B7355);
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.4),
      Offset(size.width * 0.3, size.height * 0.15),
      paint,
    );

    // Draw flag
    paint.style = PaintingStyle.fill;
    paint.color = const Color(0xFFDDDDDD);

    final flagPath = Path();
    flagPath.moveTo(size.width * 0.3, size.height * 0.15);
    flagPath.lineTo(size.width * 0.38, size.height * 0.18);
    flagPath.lineTo(size.width * 0.35, size.height * 0.22);
    flagPath.lineTo(size.width * 0.38, size.height * 0.26);
    flagPath.lineTo(size.width * 0.3, size.height * 0.29);
    flagPath.close();

    canvas.drawPath(flagPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}