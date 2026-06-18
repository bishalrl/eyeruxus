import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MakeMoneyScreen extends StatelessWidget {
  const MakeMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileHeader(),
                    SizedBox(height: 12.h),
                    _buildTabBar(),
                    SizedBox(height: 12.h),
                    _buildEarningsSection(),
                    SizedBox(height: 8.h),
                    _buildPromoBanner(),
                    SizedBox(height: 12.h),
                    _buildMoneyMakingTools(),
                    SizedBox(height: 12.h),
                    _buildEarnMoneySection(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios, size: 20.sp, color: Colors.black),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: Colors.pink[100],
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Icon(Icons.card_giftcard, size: 14.sp, color: Colors.orange),
                SizedBox(width: 2.w),
                Text('FREE', style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: Colors.red)),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Stack(
            children: [
              Icon(Icons.notifications_outlined, size: 24.sp, color: Colors.black),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(3.r),
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Text('3', style: TextStyle(fontSize: 8.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage('https://flagcdn.com/w320/us.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              SizedBox(width: 6.w),
              Text('blind_gifter', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.black)),
              SizedBox(width: 4.w),
              Icon(Icons.verified, size: 16.sp, color: Colors.blue),
              SizedBox(width: 2.w),
              Text('🪷', style: TextStyle(fontSize: 16.sp)),
              SizedBox(width: 4.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF9CCC65),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text('D', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('4', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.blue)),
                    Text('%', style: TextStyle(fontSize: 10.sp, color: Colors.blue)),
                    SizedBox(width: 16.w),
                    Row(
                      children: [
                        Icon(Icons.trending_up, size: 12.sp, color: Colors.red),
                        Text('C: 8%', style: TextStyle(fontSize: 10.sp, color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
                Text('Earnings require 🔥', style: TextStyle(fontSize: 9.sp, color: Colors.black54)),
                Text('1,999,973>>', style: TextStyle(fontSize: 9.sp, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Column(
            children: [
              Text('Make money', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black)),
              SizedBox(height: 2.h),
              Container(width: 60.w, height: 2.h, color: Colors.black),
            ],
          ),
          SizedBox(width: 20.w),
          Text('Manage', style: TextStyle(fontSize: 14.sp, color: Colors.black38)),
          SizedBox(width: 20.w),
          Text('Data', style: TextStyle(fontSize: 14.sp, color: Colors.black38)),
        ],
      ),
    );
  }

  Widget _buildEarningsSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Earned Today', style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
                        SizedBox(width: 4.w),
                        Icon(Icons.help_outline, size: 14.sp, color: Colors.black54),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text('0', style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                  ],
                ),
              ),
              Container(width: 1.w, height: 50.h, color: Colors.grey[300]),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Points', style: TextStyle(fontSize: 12.sp, color: Colors.black54)),
                        SizedBox(width: 4.w),
                        Icon(Icons.token, size: 14.sp, color: Colors.pink),
                        SizedBox(width: 4.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text('Withdraw', style: TextStyle(fontSize: 9.sp, color: Colors.white, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text('13,294', style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4FF),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Text('Accumulated Earnings:', style: TextStyle(fontSize: 11.sp, color: Colors.black54)),
                Text('72,345', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 120.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF9C27B0), Color(0xFFE91E63), Color(0xFFFF9800)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text('IND BGD PAK NPL', style: TextStyle(fontSize: 8.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'My Agent Invitation\nLeaderboard',
                          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white, height: 1.1),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7B1FA2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text('1 August - 31 August', style: TextStyle(fontSize: 9.sp, color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 140.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFF5252),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: Center(
              child: Text(
                'Upgrade',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoneyMakingTools() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Money-making tools', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox(height: 8.h),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 6.h,
            crossAxisSpacing: 6.w,
            childAspectRatio: 0.85,
            children: [
              _buildToolItem(Icons.person_add_alt_1, 'Add Host', Colors.pink),
              _buildToolItem(Icons.person_add, 'Invite Agent', Colors.blue),
              _buildToolItem(Icons.monetization_on, 'Coins Trading', Colors.orange),
              _buildToolItem(Icons.emoji_events, 'Ranking', Colors.purple, badge: 'AGENT'),
              _buildToolItem(Icons.card_giftcard, 'Reward', Colors.purple, badge: 'AGENT'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolItem(IconData icon, String label, Color color, {String? badge}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Center(
                child: Icon(icon, size: 24.sp, color: color),
              ),
            ),
            if (badge != null)
              Positioned(
                bottom: -2.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE91E63), Color(0xFF9C27B0)],
                      ),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      badge,
                      style: TextStyle(fontSize: 7.sp, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9.sp, color: Colors.black87, height: 1.2),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildEarnMoneySection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Earn Money - Learn Promotion', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7B1FA2), Color(0xFFE91E63)],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(Icons.music_note, size: 32.sp, color: Colors.white),
                      ),
                      Positioned(
                        top: 4.h,
                        left: 4.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Row(
                            children: [
                              Text('TikTok', style: TextStyle(fontSize: 8.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 4.h,
                        left: 4.w,
                        right: 4.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'TikTok Posting to Attract Users',
                            style: TextStyle(fontSize: 7.sp, color: Colors.white, fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'TikTok Posting to Attract Users',
                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.black),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text('Original', style: TextStyle(fontSize: 9.sp, color: Colors.blue, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Guide users to WhatsApp groups and invit...',
                        style: TextStyle(fontSize: 11.sp, color: Colors.black54),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Icon(Icons.remove_red_eye, size: 14.sp, color: Colors.orange),
                          SizedBox(width: 3.w),
                          Text('35,507', style: TextStyle(fontSize: 11.sp, color: Colors.black54)),
                          SizedBox(width: 12.w),
                          Icon(Icons.thumb_up_alt_outlined, size: 14.sp, color: Colors.blue),
                          SizedBox(width: 3.w),
                          Text('9,869', style: TextStyle(fontSize: 11.sp, color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}