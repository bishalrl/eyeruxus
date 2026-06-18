import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({Key? key}) : super(key: key);

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          padding: EdgeInsets.zero,
        ),
        title: Text(
          'Friends(0)',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black, size: 24.sp),
            onPressed: () {},
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: const Color(0xFFAAAAAA),
              labelStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              indicatorColor: Colors.black,
              indicatorWeight: 2.h,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.zero,
              tabs: const [
                Tab(text: 'Friends'),
                Tab(text: 'Following'),
                Tab(text: 'Followers'),
                Tab(text: 'Visitors'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEmptyState(),
                _buildEmptyState(),
                _buildEmptyState(),
                _buildEmptyState(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty_state.png', // Replace with your actual asset
            width: 200.w,
            height: 200.h,
            color: const Color(0xFFE5E5E5),
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.inbox_outlined,
                size: 100.sp,
                color: const Color(0xFFE5E5E5),
              );
            },
          ),
          SizedBox(height: 16.h),
          Text(
            'No more data',
            style: TextStyle(
              color: const Color(0xFFAAAAAA),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}