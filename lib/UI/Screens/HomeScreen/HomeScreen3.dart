import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../CommonComponant/AppBar.dart';

class HomeScreen3 extends StatelessWidget {
  const HomeScreen3({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            decoration: const BoxDecoration(color: Color(0xFF9b111e)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top row: 3 large profiles
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      children: [
                        CircleAvatar(radius: 28, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1')),
                        SizedBox(height: 4),
                        Text("User1", style: TextStyle(color: Colors.white)),
                        Text("115.9K", style: TextStyle(color: Colors.amber, fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(radius: 28, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=2')),
                        SizedBox(height: 4),
                        Text("User2", style: TextStyle(color: Colors.white)),
                        Text("4", style: TextStyle(color: Colors.amber, fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(radius: 28, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3')),
                        SizedBox(height: 4),
                        Text("User3", style: TextStyle(color: Colors.white)),
                        Text("0", style: TextStyle(color: Colors.amber, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Second row: 3 smaller profiles
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Column(
                      children: [
                        CircleAvatar(radius: 22, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=4')),
                        SizedBox(height: 4),
                        Text("User4", style: TextStyle(color: Colors.white)),
                        Text("0", style: TextStyle(color: Colors.amber, fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(radius: 22, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5')),
                        SizedBox(height: 4),
                        Text("User5", style: TextStyle(color: Colors.white)),
                        Text("0", style: TextStyle(color: Colors.amber, fontSize: 12)),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(radius: 22, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=6')),
                        SizedBox(height: 4),
                        Text("User6", style: TextStyle(color: Colors.white)),
                        Text("0", style: TextStyle(color: Colors.amber, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Beds Row 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    final colors = [Color(0xffd64041), Color(0xFFe0bebf)];
                    return Column(
                      children: [
                        Container(
                          width: 42.h,
                          height: 42.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: colors[index % 2],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(Icons.weekend_rounded, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "User ${index + 7}",
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(height: 8),

                // Beds Row 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    final colors = [ Color(0xFFe0bebf),Color(0xffd64041),];
                    return Column(
                      children: [
                        Container(
                          width: 40.h,
                          height: 40.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: colors[index % 2],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(Icons.weekend_rounded, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "User ${index + 12}",
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
