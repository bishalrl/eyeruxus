import 'package:eye_rex_us/UI/CommonComponant/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeScreen4 extends StatelessWidget {
  const HomeScreen4({super.key});

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
            child: Column(
              children: [


                // ----- ITEMS 3..8 (2 per row) -----
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: 12, // 3..8
                    itemBuilder: (context, i) {
                      final label = i + 3; // 3..8
                      // Color rule referencing your example: red for indices 0,2,4 (-> labels 3,5,7)
                      final isRed = (i == 0 || i == 3 || i == 2 || i == 6 || i == 8 || i==5 || i == 9 || i == 11);
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
                              child: Icon(Icons.weekend_rounded,
                                  size: 30, color:  Colors.white38),
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
        ],
      )),
    );
  }
}
