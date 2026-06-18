import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VIPData {
  final String title;
  final String price;
  final String privileges;
  final String coinCollection;
  final String coinCollectionDetail;
  final String liveFloatTag;
  final String platformSpeaker;
  final String platformFloatTag;
  final String greetings;
  final String buttonText;
  final List<Color> gradientColors;
  final Color badgeColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color iconColor;

  const VIPData({
    required this.title,
    required this.price,
    required this.privileges,
    required this.coinCollection,
    required this.coinCollectionDetail,
    required this.liveFloatTag,
    required this.platformSpeaker,
    required this.platformFloatTag,
    required this.greetings,
    required this.buttonText,
    required this.gradientColors,
    required this.badgeColor,
    required this.backgroundColor,
    required this.cardColor,
    required this.iconColor,
  });
}

class VIPScreen extends StatefulWidget {
  const VIPScreen({super.key});

  @override
  State<VIPScreen> createState() => _VIPScreenState();
}

class _VIPScreenState extends State<VIPScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  int _currentIndex = 0;

  final List<VIPData> vipData = [
    // Normal VIP
    VIPData(
      title: 'VIP',
      price: '95,000/M',
      privileges: '8/22',
      coinCollection: '+3,500/d',
      coinCollectionDetail: '+3,500/d',
      liveFloatTag: '+1/d',
      platformSpeaker: '+1/d',
      platformFloatTag: '+1/d',
      greetings: '30/d',
      buttonText: 'Open Normal VIP',
      gradientColors: [Color(0xFF2D3748), Color(0xFF1A202C)],
      badgeColor: Color(0xFF4299E1),
      backgroundColor: Color(0xFF1A202C),
      cardColor: Color(0xFF2D3748),
      iconColor: Color(0xFF4299E1),
    ),
    // Super VIP
    VIPData(
      title: 'VIP',
      price: '450,000/M',
      privileges: '10/22',
      coinCollection: '+16,000/d',
      coinCollectionDetail: '+16,000/d',
      liveFloatTag: '+2/d',
      platformSpeaker: '+1/d',
      platformFloatTag: '+1/d',
      greetings: '99/d',
      buttonText: 'Open Super VIP',
      gradientColors: [Color(0xFFea30eb), Color(0xFFdda4d7)],
      badgeColor: Color(0xFFEC4899),
      backgroundColor: Color(0xFFdda4d7),
      cardColor: Color(0xFFea30eb),
      iconColor: Color(0xFFea30eb),
    ),
    // Diamond VIP
    VIPData(
      title: 'VIP',
      price: '1,000,000/M',
      privileges: '20/22',
      coinCollection: '+35,000/d',
      coinCollectionDetail: '+35,000/d',
      liveFloatTag: '+5/d',
      platformSpeaker: '+2/d',
      platformFloatTag: '+2/d',
      greetings: '199/d',
      buttonText: 'Open Diamond VIP',
      gradientColors: [Color(0xFF553C9A), Color(0xFF2D1B69)],
      badgeColor: Color(0xFF553C9A),
      backgroundColor: Color(0xFF2D1B69),
      cardColor: Color(0xFF553C9A),
      iconColor: Color(0xFF553C9A),
    ),
    // SVIP
    VIPData(
      title: 'SVIP',
      price: '12,990,000/Y',
      privileges: '22/22',
      coinCollection: '+35,000/d',
      coinCollectionDetail: '+35,000/d',
      liveFloatTag: '+5/d',
      platformSpeaker: '+2/d',
      platformFloatTag: '+2/d',
      greetings: '199/d',
      buttonText: 'Open SVIP',
      gradientColors: [Color(0xFF7C2D12), Color(0xFF451A03)],
      badgeColor: Color(0xFFEAB308),
      backgroundColor: Color(0xFF451A03),
      cardColor: Color(0xFF7C2D12),
      iconColor: Color(0xFFEAB308),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _pageController = PageController();
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      color: vipData[_currentIndex].backgroundColor,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        backgroundColor: Colors.transparent,
        floatingActionButton: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          height: 70.h,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4299E1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 8,
              shadowColor: vipData[_currentIndex].badgeColor.withValues(alpha: 0.3),
            ),
            child: Text(
              vipData[_currentIndex].buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        body: Container(
          color: vipData[_currentIndex].backgroundColor,
          child: Column(
            children: [
              // TabBar container (previously in AppBar)
              Container(
                color: vipData[_currentIndex].backgroundColor,
                child: TabBar(
                  controller: _tabController,
                  padding: EdgeInsets.zero, // remove TabBar outer padding
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  labelPadding: EdgeInsets.only(right: 0, left: 0), // 👈 spacing only between tabs
                  tabs: const [
                    Tab(text: 'Normal VIP'),
                    Tab(text: 'Super VIP'),
                    Tab(text: 'Diamond VIP'),
                    Tab(text: 'SVIP'),
                  ],
                ),
              ),
              // PageView content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                    _tabController.animateTo(index);
                  },
                  itemCount: vipData.length,
                  itemBuilder: (context, index) {
                    return _buildVIPContent(vipData[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVIPContent(VIPData data) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: data.gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: data.badgeColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        data.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      data.privileges,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  data.price,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Privileges',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          _privilegeTile('Coin collection', data.coinCollection, data),
          _privilegeTile('Live float tag', data.liveFloatTag, data),
          _privilegeTile('Platform speaker', data.platformSpeaker, data),
          _privilegeTile('Platform float tag', data.platformFloatTag, data),
          _privilegeTile('Greetings', data.greetings, data),
          SizedBox(height: 80.h),
        ],
      ),
    );
  }

  Widget _privilegeTile(String label, String value, VIPData data) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: data.cardColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(Icons.star, color: data.iconColor, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: data.iconColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

