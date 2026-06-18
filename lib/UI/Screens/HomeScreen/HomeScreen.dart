import 'package:eye_rex_us/UI/CommonComponant/AppBar.dart';
import 'package:eye_rex_us/UI/Screens/HomeScreen/Componant/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Componant/seatTile.dart';


class LiveRoomScreen extends StatelessWidget {
  const LiveRoomScreen({super.key});

  // ---- Theme & constants ----
  static const Color kBg = Color(0xFFAF1D18);
  static const double kPad = 10;
  static const String kHostAvatar =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTA-m4D7gaOaHMGxxheIp_xF_OSzrba6G7MIA&s';
  static const String kFlagIn = 'https://flagcdn.com/w20/in.png';
  static const String kSmallAvatar =
      'https://i.pinimg.com/736x/6b/aa/98/6baa98cc1c3f4d76e989701746e322dd.jpg';
  static const String kBanner =
      'https://wallpapers.com/images/featured/heroine-b9ste23c1zfuxnbz.jpg';
  // Use a bed icon PNG **with transparent background** for proper tinting:
  static const String kBedPngTransparent =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Font_Awesome_5_solid_bed.svg/1024px-Font_Awesome_5_solid_bed.svg.png';
  // ^ This URL is SVG rendered as PNG by Wikimedia; still has transparent bg in most sizes.
  // If you face issues, host your own transparent PNG, or use an SVG with flutter_svg.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAF1D18),
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: kBg,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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

                ],
              ),
            ),


            // Banner
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10),
            //   child: Container(
            //     height: 200,
            //     padding: EdgeInsets.all(5),
            //     width: double.infinity,
            //     decoration: const BoxDecoration(color: Colors.white24),
            //     child: YoutubePlayer(
            //       controller: YoutubePlayerController(
            //         initialVideoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=nfNc0XJdZWk')!,
            //         flags: YoutubePlayerFlags(
            //           autoPlay: false,
            //           mute: false,
            //           enableCaption: false,
            //           loop: false,
            //         ),
            //       ),
            //       showVideoProgressIndicator: true,
            //       progressIndicatorColor: Colors.red,
            //       progressColors: ProgressBarColors(
            //         playedColor: Colors.red,
            //         handleColor: Colors.redAccent,
            //       ),
            //       onReady: () {
            //         // Video is ready
            //       },
            //       onEnded: (data) {
            //         // Video ended
            //       },
            //     ),
            //   ),
            // ),


            // Seats grid
            CompactVideoPlayer(
              videoUrl: 'https://www.youtube.com/watch?v=Mmu-tj-psuk',
              height: 180.h,
            ),




            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1.3,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                final bool isOccupied = index == 0; // sample occupied seat
                return SeatTile(
                  index: index,
                  occupied: isOccupied,
                  bgColor:
                  isOccupied || index==2 || index==4? Color(0xffd64041) : Color(0xFFe0bebf),
                  borderColor: Colors.red.shade300,
                  // White icon on transparent PNG:
                  emptyIcon:  Icon(Icons.weekend_rounded, size: 50,color: Colors.white,),
                );
              },
            ),



          ],
        ),
      ),
    );
  }
}

// --- Small widgets ---

