import 'package:eye_rex_us/UI/CommonComponant/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomeScreen5 extends StatelessWidget {
    HomeScreen5({super.key});
    final List<String> avatars = [
      'https://i.pravatar.cc/150?img=1', // public PNG avatar API
      'https://i.pravatar.cc/150?img=1', // public PNG avatar API
      'https://i.pravatar.cc/150?img=1', // public PNG avatar API
      'https://i.pravatar.cc/150?img=1', // public PNG avatar API
    ];

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
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFFAF1D18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                         color: Colors.white.withValues(alpha: 0.30),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            'https://img.icons8.com/emoji/48/trophy-emoji.png',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Live',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 11),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            '1000+',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.30),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                Image.network(
                                  'https://img.icons8.com/color/48/coins.png',
                                  width: 14,
                                  height: 14,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  '6',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          50.horizontalSpace,
                          const Text(
                            '28.78%',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 64,
                      width: 120,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                         color: Colors.white.withValues(alpha: 0.30),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.network(
                                'https://img.icons8.com/emoji/48/wrapped-gift.png',
                                width: 14,
                                height: 14,
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Gift Gallary',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '2/5',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          LayoutBuilder(builder: (context, c) {
                            final w = c.maxWidth;
                            final filled = w * 0.4;
                            return Stack(
                              children: [
                                Container(
                                  height: 4,
                                  width: w,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                Container(
                                  height: 4,
                                  width: filled,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFE082),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 64,
                      width: 64,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                         color: Colors.white.withValues(alpha: 0.30),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://img.icons8.com/fluency/96/treasure-chest.png',
                            width: 22,
                            height: 22,
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '01:17',
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
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
              ],
            ),
          ),
          Container(
            height: 240.h,
            width: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1.3,
                    ),
                    itemCount: avatars.length,
                    itemBuilder: (context, i) {
                      final label = i + 3;
                      final isRed = (i == 0 || i == 2); // example condition
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8), // soft rounded
                                child: Image.network(
                                  avatars[i],
                                  width: 200.w,
                                  height: 150.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFA34D),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    '$label',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left:10,
                              child: Container(
                                width: 40,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFd2d2d2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Icon(Icons.star,
                                    color: Color(0xFFFFA34D),size: 16,),
                                    5.horizontalSpace,
                                    Text(
                                      '30',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
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
        ],
      )),
    );
  }
}
