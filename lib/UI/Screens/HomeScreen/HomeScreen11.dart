import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../CommonComponant/AppBar.dart';

class HomeScreen11 extends StatelessWidget {
  const HomeScreen11({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAF1D18),
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 22.h,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xffcd6866),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'Assets/share.png',
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                      'Assets/textpad.png',
                      height: 22,
                      color: Colors.white,

                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.menu, color: Colors.white,size: 25,)
                  ],
                ),
              ),
            ),
            5.verticalSpace,


            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width - 32,
                  height: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.brown[400]!, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // Row 1 (40% height)
                      Expanded(
                        flex: 40,
                        child: Row(
                          children: [
                            // Red Home Area (40% width)
                            Expanded(
                              flex: 40,
                              child: _buildHomeArea(Colors.red),
                            ),
                            // Top Path (20% width)
                            Expanded(
                              flex: 20,
                              child: _buildVerticalPath(Colors.green, isTopPath: true),
                            ),
                            // Green Home Area (40% width)
                            Expanded(
                              flex: 40,
                              child: _buildHomeArea(Colors.green),
                            ),
                          ],
                        ),
                      ),
                      // Row 2 - Middle (20% height)
                      Expanded(
                        flex: 20,
                        child: Row(
                          children: [
                            // Left Path (40% width)
                            Expanded(
                              flex: 40,
                              child: _buildHorizontalPath(Colors.red, isLeftPath: true),
                            ),
                            // Center Area (20% width)
                            Expanded(
                              flex: 20,
                              child: _buildCenterArea(),
                            ),
                            // Right Path (40% width)
                            Expanded(
                              flex: 40,
                              child: _buildHorizontalPath(Colors.orange, isLeftPath: false),
                            ),
                          ],
                        ),
                      ),
                      // Row 3 (40% height)
                      Expanded(
                        flex: 40,
                        child: Row(
                          children: [
                            // Blue Home Area (40% width)
                            Expanded(
                              flex: 40,
                              child: _buildHomeArea(Colors.blue),
                            ),
                            // Bottom Path (20% width)
                            Expanded(
                              flex: 20,
                              child: _buildVerticalPath(Colors.blue, isTopPath: false),
                            ),
                            // Yellow Home Area (40% width)
                            Expanded(
                              flex: 40,
                              child: _buildHomeArea(Colors.orange),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ..._buildPlayerAvatars(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeArea(Color color) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black54, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(6),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(8),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: List.generate(4, (index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildVerticalPath(Color homeColor, {required bool isTopPath}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: Column(
        children: List.generate(6, (row) {
          return Expanded(
            child: Row(
              children: List.generate(3, (col) {
                bool isHomeColumn = col == 1;
                bool isSafeSpot = false;

                if (isTopPath && isHomeColumn && row == 5) {
                  isSafeSpot = true; // Green safe spot
                } else if (!isTopPath && isHomeColumn && row == 0) {
                  isSafeSpot = true; // Blue safe spot
                }

                Color cellColor = Colors.white;
                if (isHomeColumn && ((isTopPath && row >= 1) || (!isTopPath && row <= 4))) {
                  cellColor = homeColor.withValues(alpha: 0.6);
                }

                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: cellColor,
                      border: Border.all(color: Colors.grey[400]!, width: 0.5),
                    ),
                    child: isSafeSpot
                        ? Icon(Icons.star, color: Colors.white, size: 12)
                        : null,
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHorizontalPath(Color homeColor, {required bool isLeftPath}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: Row(
        children: List.generate(6, (col) {
          return Expanded(
            child: Column(
              children: List.generate(3, (row) {
                bool isHomeRow = row == 1;
                bool isSafeSpot = false;
                bool isStartSpot = false;

                // Safe spots and start spots based on the reference image
                if (isLeftPath) {
                  if (col == 1 && row == 0) isSafeSpot = true; // Red safe spot
                  if (col == 5 && row == 1) isStartSpot = true; // Red start spot
                } else {
                  if (col == 4 && row == 2) isSafeSpot = true; // Yellow safe spot
                  if (col == 0 && row == 1) isStartSpot = true; // Yellow start spot
                }

                Color cellColor = Colors.white;

                // Color the home row
                if (isHomeRow) {
                  if (isLeftPath && col >= 1 && col <= 5) {
                    cellColor = Colors.red.withValues(alpha: 0.6);
                  } else if (!isLeftPath && col >= 0 && col <= 4) {
                    cellColor = Colors.orange.withValues(alpha: 0.6);
                  }
                }

                // Special coloring for safe spots
                if (isSafeSpot) {
                  cellColor = isLeftPath ? Colors.red.withValues(alpha: 0.8) : Colors.orange.withValues(alpha: 0.8);
                }

                // Special coloring for start spots
                if (isStartSpot) {
                  cellColor = isLeftPath ? Colors.red : Colors.orange;
                }

                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: cellColor,
                      border: Border.all(color: Colors.grey[400]!, width: 0.5),
                    ),
                    child: Stack(
                      children: [
                        // Safe spot star
                        if (isSafeSpot)
                          Center(
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        // Start spot arrow
                        if (isStartSpot)
                          Center(
                            child: Icon(
                              isLeftPath ? Icons.arrow_forward : Icons.arrow_back,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCenterArea() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: Stack(
        children: [
          // Center triangular areas
          CustomPaint(
            size: Size.infinite,
            painter: LudoCenterPainter(),
          ),
          // PLAY button in center
          Center(
            child: Container(
              width: 50,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'PLAY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPlayerAvatars() {
    return [
      // Top-left (Red player)
      Positioned(
        top: 0,
        left: 0,
        child: _buildAvatar(Colors.red),
      ),
      // Top-right (Green player)
      Positioned(
        top: 0,
        right: 0,
        child: _buildAvatar(Colors.green),
      ),
      // Bottom-left (Blue player)
      Positioned(
        bottom: 0,
        left: 0,
        child: _buildAvatar(Colors.blue),
      ),
      // Bottom-right (Yellow player)
      Positioned(
        bottom: 0,
        right: 0,
        child: _buildAvatar(Colors.orange),
      ),
    ];
  }

  Widget _buildAvatar(Color borderColor) {
    return Container(
      width: 50.w, // or 40.w if using ScreenUtil
      height: 50.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          'https://i.pravatar.cc/100', // dummy profile avatar service
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}

class LudoCenterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final center = Offset(size.width / 2, size.height / 2);

    // Red triangle (top-left)
    paint.color = Colors.red.withValues(alpha: 0.3);
    final redPath = Path();
    redPath.moveTo(0, 0);
    redPath.lineTo(center.dx, center.dy);
    redPath.lineTo(0, size.height);
    redPath.close();
    canvas.drawPath(redPath, paint);

    // Green triangle (top-right)
    paint.color = Colors.green.withValues(alpha: 0.3);
    final greenPath = Path();
    greenPath.moveTo(size.width, 0);
    greenPath.lineTo(center.dx, center.dy);
    greenPath.lineTo(0, 0);
    greenPath.close();
    canvas.drawPath(greenPath, paint);

    // Blue triangle (bottom-left)
    paint.color = Colors.blue.withValues(alpha: 0.3);
    final bluePath = Path();
    bluePath.moveTo(0, size.height);
    bluePath.lineTo(center.dx, center.dy);
    bluePath.lineTo(size.width, size.height);
    bluePath.close();
    canvas.drawPath(bluePath, paint);

    // Yellow triangle (bottom-right)
    paint.color = Colors.orange.withValues(alpha: 0.3);
    final yellowPath = Path();
    yellowPath.moveTo(size.width, size.height);
    yellowPath.lineTo(center.dx, center.dy);
    yellowPath.lineTo(size.width, 0);
    yellowPath.close();
    canvas.drawPath(yellowPath, paint);

    // Draw triangle borders with thicker lines
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    paint.color = Colors.grey[700]!;

    canvas.drawPath(redPath, paint);
    canvas.drawPath(greenPath, paint);
    canvas.drawPath(bluePath, paint);
    canvas.drawPath(yellowPath, paint);

    // Draw center lines
    paint.strokeWidth = 1.5;
    paint.color = Colors.grey[600]!;

    // Horizontal center line
    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), paint);

    // Vertical center line
    canvas.drawLine(Offset(center.dx, 0), Offset(center.dx, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}