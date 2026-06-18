import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HostManagementScreen extends StatelessWidget {
  const HostManagementScreen({Key? key}) : super(key: key);

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
                    _buildHostIncentiveTools(),
                    SizedBox(height: 12.h),
                    _buildHostManagement(),
                    SizedBox(height: 12.h),
                    _buildInviteAgent(),
                    SizedBox(height: 12.h),
                    _buildPlatformRewards(),
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
          Text('Make money', style: TextStyle(fontSize: 14.sp, color: Colors.black38)),
          SizedBox(width: 20.w),
          Column(
            children: [
              Text('Manage', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black)),
              SizedBox(height: 2.h),
              Container(width: 40.w, height: 2.h, color: Colors.black),
            ],
          ),
          SizedBox(width: 20.w),
          Text('Data', style: TextStyle(fontSize: 14.sp, color: Colors.black38)),
        ],
      ),
    );
  }

  Widget _buildHostIncentiveTools() {
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
          Text('Host incentive tools', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox(height: 10.h),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8.h,
            crossAxisSpacing: 8.w,
            childAspectRatio: 0.85,
            children: [
              _buildGridItem('0', Icons.attach_money, 'Super Funds\nmanagement', Colors.orange),
              _buildGridItem('', Icons.monetization_on, 'Super Salary', Colors.orange),
              _buildGridItem('', Icons.emoji_events, 'Super Rank', Colors.orange),
              _buildGridItem('', null, 'Super Party', Colors.orange, customIcon: '🎊'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHostManagement() {
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
          Text('Host Management', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox(height: 10.h),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8.h,
            crossAxisSpacing: 8.w,
            childAspectRatio: 0.85,
            children: [
              _buildGridItem('5', Icons.person_outline, 'My Host', Colors.pink),
              _buildGridItem('0', Icons.credit_card, 'Base Salary\nHost', Colors.pink),
              _buildGridItem('', Icons.description, 'Host\nApplication', Colors.pink),
              _buildGridItem('', Icons.person_add_alt_1, 'Add Host', Colors.pink),
              _buildGridItem('', Icons.group, 'Host Group', Colors.pink),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInviteAgent() {
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
          Text('Invite Agent', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox(height: 10.h),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8.h,
            crossAxisSpacing: 8.w,
            childAspectRatio: 0.85,
            children: [
              _buildGridItem('0', Icons.business_center, 'My Agency', Colors.blue),
              _buildGridItem('', Icons.person_add, 'Invite Agent', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformRewards() {
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
          Text('Platform rewards', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.black)),
          SizedBox(height: 10.h),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8.h,
            crossAxisSpacing: 8.w,
            childAspectRatio: 0.85,
            children: [
              _buildGridItem('', Icons.emoji_events, 'Ranking', Colors.purple),
              _buildGridItem('', Icons.card_giftcard, 'Reward', Colors.purple),
              _buildGridItem('', Icons.local_activity, 'Activity Centre', Colors.purple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(String count, IconData? icon, String label, Color color, {String? customIcon}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Center(
                child: customIcon != null
                    ? Text(customIcon, style: TextStyle(fontSize: 24.sp))
                    : Icon(icon, size: 26.sp, color: color),
              ),
            ),
            Positioned(
              top: -3.h,
              right: -3.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text('Hot', style: TextStyle(fontSize: 8.sp, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            if (count.isNotEmpty)
              Positioned(
                top: -3.h,
                right: -3.w,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    count,
                    style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.white),
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
}