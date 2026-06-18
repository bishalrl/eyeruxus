import 'package:eye_rex_us/UI/CommonComponant/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeScreen6 extends StatelessWidget {
  const HomeScreen6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAF1D18),
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Make a wish
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30.h,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffcd6866),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.auto_fix_high, color: Colors.white, size: 20),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          'Make a\nWish',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
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
              ],
            ),

            // ▼ Stack now fills all remaining space so chat pins to screen bottom
            Expanded(
              child: Stack(
                children: [
                  // BACKGROUND MAIN CONTAINER
                  Container(
                    height: 480.h, // fill available screen space
                    width: double.infinity,
                    color: Colors.black,
                    child: Row(
                      children: [
                        // LEFT HALF — big image with icons
                        Expanded(
                          flex: 8,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  'https://images.pexels.com/photos/1172064/pexels-photo-1172064.jpeg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // top-left home
                              Positioned(
                                top: 8,
                                left: 8,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                      color: Colors.white24, shape: BoxShape.circle),
                                  child: const Icon(Icons.home_rounded,
                                      size: 18, color: Colors.white),
                                ),
                              ),
                              // top-right gift
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: const BoxDecoration(
                                          color: Colors.white24, shape: BoxShape.circle),
                                      child: const Icon(Icons.card_giftcard,
                                          size: 18, color: Colors.white),
                                    ),
                                    Positioned(
                                      right: -6,
                                      top: -6,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffd64041),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Text(
                                          '0',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // bottom-right mic
                              Positioned(
                                right: 1,
                                bottom: 1,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFF0652B), shape: BoxShape.circle),
                                  child: const Icon(Icons.mic, color: Colors.white),
                                ),
                              ),
                              // bottom-left name
                              const Positioned(
                                left: 10,
                                bottom: 10,
                                child: Row(
                                  children: [
                                    Icon(Icons.verified, size: 16, color: Colors.white),
                                    SizedBox(width: 6),
                                    Text('Daksh',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // RIGHT HALF — grid
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFF2A1B45), Color(0xFF180F2F)],
                              ),
                            ),
                            padding: const EdgeInsets.all(1),
                            child: Column(
                              children: [
                                Expanded(
                                  child: GridView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 1,
                                      crossAxisSpacing: 1,
                                      childAspectRatio: 1,
                                    ),
                                    itemCount: 8,
                                    itemBuilder: (context, i) {
                                      final label = i + 2;
                                      final isRed = (i == 1 || i == 2 || i == 5);
                                      final bg = isRed
                                          ? const Color(0xffd64041)
                                          : const Color(0xFFe0bebf);
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: bg,
                                          border: Border.all(
                                              color: Colors.red.shade300, width: 1),
                                          borderRadius: BorderRadius.circular(1),
                                        ),
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Icon(Icons.bed_rounded,
                                                  size: 25,
                                                  color: isRed
                                                      ? Colors.white
                                                      : Colors.black87),
                                            ),
                                            Positioned(
                                              top: 0,
                                              left: 0,
                                              child: Container(
                                                width: 15,
                                                height: 15,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFFFA34D),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '$label',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
