import 'package:flutter/material.dart';

// Replace with your constants
const Color kBg = Color(0xFFAF1D18);
const String kHostAvatar =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTA-m4D7gaOaHMGxxheIp_xF_OSzrba6G7MIA&s';
  const String kSmallAvatar =
    'https://i.pinimg.com/736x/6b/aa/98/6baa98cc1c3f4d76e989701746e322dd.jpg';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      titleSpacing: 3,
      backgroundColor: kBg,
      title: Container(
        color: kBg,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile pill
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.red.shade300,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(kHostAvatar),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:   [
                      _FlagAndName(),
                      Text(
                        'ID: 6736373839',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFac1214),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.add_circle,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Right cluster
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _MiniAvatar(url: kSmallAvatar),
                const _MiniAvatar(url: kSmallAvatar),
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color(0xffcd6866),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '19',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: close action
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


class _FlagAndName extends StatelessWidget {
  _FlagAndName();
  String kFlagIn = 'https://flagcdn.com/w20/in.png';
  @override
  Widget build(BuildContext context) {
    return Row(
      children:   [
        Image(
          image: NetworkImage(kFlagIn),
          width: 15,
          height: 14,
        ),
        SizedBox(width: 3),
        Text(
          'I am racer',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _MiniAvatar extends StatelessWidget {
  final String url;
  const _MiniAvatar({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      child: CircleAvatar(
        radius: 10,
        backgroundImage: NetworkImage(url),
        backgroundColor: Colors.grey.shade300,
      ),
    );
  }
}

