import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  final ScrollController _scrollController = ScrollController();
  int _selectedTab = 0;

  final List<String> _tabs = ['PK Mission', 'Activity', 'Fan Club', 'Invite'];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTab = index;
    });
    // Calculate scroll position based on tab index
    double scrollPosition = 0;
    if (index == 0) {
      scrollPosition = 0;
    } else if (index == 1) {
      scrollPosition = 600.h;
    } else if (index == 2) {
      scrollPosition = 1200.h;
    } else if (index == 3) {
      scrollPosition = 1800.h;
    }
    _scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Reward',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.black, size: 20.sp),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Purple banner
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF9D4EDD), Color(0xFFD946EF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Text(
                  'Live Task Level Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Click here for details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // Tabs
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_tabs.length, (index) {
                return GestureDetector(
                  onTap: () => _onTabSelected(index),
                  child: Column(
                    children: [
                      Text(
                        _tabs[index],
                        style: TextStyle(
                          color: _selectedTab == index
                              ? Colors.black
                              : Colors.grey,
                          fontSize: 13.sp,
                          fontWeight: _selectedTab == index
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      if (_selectedTab == index)
                        Container(
                          width: 24.w,
                          height: 2.h,
                          color: Colors.black,
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // PK Mission Section
                  _buildPKMissionSection(),

                  // Activity Section
                  _buildActivitySection(),

                  // Fan Club Section
                  _buildFanClubSection(),

                  // Invite Section
                  _buildInviteSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPKMissionSection() {
    return Column(
      children: [
        // PK Record Card
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE0E0E0), width: 1.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('🎉', style: TextStyle(fontSize: 14.sp)),
                      SizedBox(width: 4.w),
                      Text(
                        "Today's PK record",
                        style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                      ),
                    ],
                  ),
                  Text(
                    'PK record>>',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Color(0xFF9D4EDD),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Highest effective winning\nstreak',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40.h,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Effective wins',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Colors.grey[600],
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

        // Team PK Task
        _buildTaskCard(
          icon: '🎭',
          iconBg: Color(0xFFFFE4E1),
          title: 'Complete a round of Team PK',
          subtitle: 'can only be achieved once',
          reward: '+100',
          progress: '(0/1)',
        ),

        // Rocket Host Video
        _buildExpandableSection(
          icon: '🎬',
          iconBg: Color(0xFFD4EDDA),
          title: 'Rocket Host Video Collection',
          reward: '+10000',
          children: [
            _buildTaskCard(
              icon: '🔵',
              iconBg: Colors.transparent,
              title: 'Upload video and pass review',
              subtitle: '',
              reward: '+10000',
              progress: '(0/1)',
              showIcon: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActivitySection() {
    return Column(
      children: [
        // Same content as PK Mission for demo
        _buildPKMissionSection(),
      ],
    );
  }

  Widget _buildFanClubSection() {
    return Column(
      children: [
        // Fan Club Challenges
        _buildExpandableSection(
          icon: '💎',
          iconBg: Color(0xFFFCE4EC),
          title: 'Fan Club Challenges',
          reward: '+500',
          subtitle:
          'Tips for Hosts:\n1. Send Lucky Boxes in LIVE room to grow your Fan Club.\n2. Set Party room seats for Fan Club members only.',
          children: [
            _buildTaskCard(
              icon: '🔵',
              iconBg: Colors.transparent,
              title: 'Daily Fan Power Points Increased by 10',
              subtitle: '',
              reward: '+100',
              progress: '(0/10)',
              showIcon: false,
            ),
            _buildTaskCard(
              icon: '🔵',
              iconBg: Colors.transparent,
              title: 'Daily Fan Power Points Increased by 50',
              subtitle: '',
              reward: '+200',
              progress: '(0/50)',
              showIcon: false,
            ),
            _buildTaskCard(
              icon: '🔵',
              iconBg: Colors.transparent,
              title: 'Daily Fan Power Points Increased by 100',
              subtitle: '',
              reward: '+200',
              progress: '(0/100)',
              showIcon: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInviteSection() {
    return Column(
      children: [
        _buildTaskCard(
          icon: '🔵',
          iconBg: Colors.transparent,
          title: 'Daily Fan Power Points Increased by 100',
          subtitle: '',
          reward: '+200',
          progress: '(0/100)',
          showIcon: false,
        ),

        // Invite Task
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.person_add, color: Colors.red, size: 18.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invite one person can earn up to \$14',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'The more you invite, the more rewards you will get',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text('💰', style: TextStyle(fontSize: 12.sp)),
                        SizedBox(width: 2.w),
                        Text(
                          '+140000',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Color(0xFFE8E4F3),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'GO',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Color(0xFF7C4DFF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // VIP Daily Rewards
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9D4EDD), Color(0xFF7C4DFF)],
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    'VIP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'VIP daily rewards',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF9D4EDD), Color(0xFF7C4DFF)],
                        ),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'VIP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF6B9D), Color(0xFFFF8E53)],
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.diamond, color: Colors.white, size: 14.sp),
                    SizedBox(width: 2.w),
                    Text(
                      'VIP',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // On-Mic Tasks
        _buildExpandableSection(
          icon: '🎤',
          iconBg: Color(0xFFF3E5F5),
          title: 'On-Mic Tasks',
          reward: '+500',
          children: [
            _buildTaskCard(
              icon: '🔵',
              iconBg: Colors.transparent,
              title: 'On the mic for 30 mins',
              subtitle: 'Time in party and live rooms both count',
              reward: '+200',
              progress: '(0/30)',
              showIcon: false,
            ),
            _buildTaskCard(
              icon: '🔵',
              iconBg: Colors.transparent,
              title: 'On the mic for 60 mins',
              subtitle: 'Send 5 lucky gifts.',
              reward: '+300',
              progress: '(0/60, 0/5)',
              showIcon: false,
            ),
          ],
        ),

        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildTaskCard({
    required String icon,
    required Color iconBg,
    required String title,
    required String subtitle,
    required String reward,
    required String progress,
    bool showIcon = true,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          if (showIcon)
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: Text(icon, style: TextStyle(fontSize: 16.sp)),
              ),
            )
          else
            Container(
              width: 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: Color(0xFF7C4DFF),
                shape: BoxShape.circle,
              ),
            ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text('💰', style: TextStyle(fontSize: 11.sp)),
                    SizedBox(width: 2.w),
                    Text(
                      reward,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Color(0xFFE8E4F3),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'GO',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Color(0xFF7C4DFF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (progress.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  progress,
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String icon,
    required Color iconBg,
    required String title,
    required String reward,
    String? subtitle,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Row(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Text(icon, style: TextStyle(fontSize: 16.sp)),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text('💰', style: TextStyle(fontSize: 11.sp)),
                          SizedBox(width: 2.w),
                          Text(
                            reward,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  'Hide',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Color(0xFF7C4DFF),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_up,
                  color: Color(0xFF7C4DFF),
                  size: 16.sp,
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}