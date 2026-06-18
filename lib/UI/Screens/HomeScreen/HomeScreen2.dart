import 'package:eye_rex_us/UI/CommonComponant/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAF1D18),
      appBar: CustomAppBar(),
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Make a wish
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
          Container(
            height: 300.h,
            width: double.infinity,
            color: Colors.black,
            child: Row(
              children: [
                // LEFT HALF — full-height vertical image with corner icons
                Expanded(
                  flex: 6,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          'https://media.istockphoto.com/id/670026216/photo/sunset-over-the-fishing-pier-at-the-lake-in-finland.jpg?s=1024x1024&w=is&k=20&c=FEdONUrq6N7Gw8QujCkYWIph0MyvpgdB7URz5JN1Gzo=',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // top-left: home
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                              color: Colors.white24, shape: BoxShape.circle),
                          child: const Icon(Icons.home_rounded, size: 18, color: Colors.white),
                        ),
                      ),
                      // top-right: gift + small count badge
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
                              child: const Icon(Icons.card_giftcard, size: 18, color: Colors.white),
                            ),
                            Positioned(
                              right: -6, top: -6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xffd64041),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text('0',
                                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // center-right: mic/floating
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
                      // bottom-left: name
                      const Positioned(
                        left: 10,
                        bottom: 10,
                        child: Row(
                          children: [
                            Icon(Icons.verified, size: 16, color: Colors.white),
                            SizedBox(width: 6),
                            Text('Daksh', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // RIGHT HALF — item #2 full-width row, then 3..8 as 2-per-row grid
                Expanded(
                  flex: 3,
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
                        // ----- ITEM 2 (single tile occupying full width of this half) -----
                        Container(
                          height: 105.h, // same feel as one grid row

                          decoration: BoxDecoration(
                            color: const Color(0xffd64041), // refer sample (occupied/red)

                            borderRadius: BorderRadius.circular(1),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(Icons.weekend_rounded, size: 50, color: Colors.white.withValues(alpha: 0.95)),
                              ),
                              Positioned(
                                top: 6,
                                left: 6,
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFA34D),
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text('2',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ----- ITEMS 3..8 (2 per row) -----
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: 6, // 3..8
                            itemBuilder: (context, i) {
                              final label = i + 3; // 3..8
                              // Color rule referencing your example: red for indices 0,2,4 (-> labels 3,5,7)
                              final isRed = (i == 1 || i == 2 || i == 5);
                              final bg = isRed ? const Color(0xffd64041) : const Color(0xFFe0bebf);
                              return Container(
                                decoration: BoxDecoration(
                                  color: bg,
                                  border: Border.all(color: Colors.red.shade300, width: 1),
                                  borderRadius: BorderRadius.circular(1),
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Icon(Icons.bed_rounded,
                                          size: 25, color: Colors.white),
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
                                        child: Text('$label',
                                            style: const TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
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
      )),
    );
  }
}
