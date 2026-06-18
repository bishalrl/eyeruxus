import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../CommonComponant/AppBar.dart';

class HomeScreen8 extends StatelessWidget {
  const HomeScreen8({super.key});

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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF9b111e), Color(0xFF7a0e18), Color(0xFF5c0a12)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // Top row: 3 large profiles with enhanced design
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 1st Place - Crown Winner
                    Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFFD700), Color(0xFFDAA520)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber.withValues(alpha: 0.5),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 32,
                                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
                              ),
                            ),
                            Positioned(
                              top: -8,
                              left: 0,
                              right: 0,
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  "👑",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "User1",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.amber, Colors.orange],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "115.9K",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 2nd Place - Silver
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFC0C0C0), Color(0xFF999999)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.4),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=2'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "User2",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "4",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    // 3rd Place - Bronze
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFCD7F32), Color(0xFF8B4513)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.brown.withValues(alpha: 0.4),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.brown[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "User3",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "0",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // 3rd Place - Bronze
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFCD7F32), Color(0xFF8B4513)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.brown.withValues(alpha: 0.4),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.brown[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "User4",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "0",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Divider
                Container(
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.transparent, Colors.white54, Colors.transparent],
                    ),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                const SizedBox(height: 10),

                // Second row: 4 medium profiles with glassmorphism
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (index) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.1),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${index + 4}'),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "User${index + 5}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "0",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 10),

                // Third row: 3 smaller profiles
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    final isEven = index % 2 == 0;
                    return Column(
                      children: [
                        Container(
                          width: 43,
                          height: 43,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isEven
                                  ? [const Color(0xffd64041), const Color(0xFFa83032)]
                                  : [const Color(0xFFe0bebf), const Color(0xFFc9a5a6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: (isEven ? Colors.red : Colors.pink).withValues(alpha: 0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.weekend_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "User${index + 10}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 10),


                // Beds Row 1 - 5 beds with gradient design
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    final isEven = index % 2 == 0;
                    return Column(
                      children: [
                        Container(
                          width: 43,
                          height: 43,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isEven
                                  ? [const Color(0xffd64041), const Color(0xFFa83032)]
                                  : [const Color(0xFFe0bebf), const Color(0xFFc9a5a6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: (isEven ? Colors.red : Colors.pink).withValues(alpha: 0.3),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.weekend_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "User${index + 15}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 10),



              ],
            ),
          ),
        ],
      )),
    );
  }
}
