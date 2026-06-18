import 'package:flutter/material.dart';

import 'BuyGurdianTabs.dart';
import 'GuardMe.dart';
import 'MyGurdian.dart';

class GuardianScreen extends StatefulWidget {
  @override
  _GuardianScreenState createState() => _GuardianScreenState();
}

class _GuardianScreenState extends State<GuardianScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabItem(String title, int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        _tabController.animateTo(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D1B1B),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabItem('Buy guardian', 0),
                _buildTabItem('My guardian', 1),
                _buildTabItem('Guard me', 2),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                BuyGuardianScreen(),
                MyGuardianScreen(),
                GuardMeScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}