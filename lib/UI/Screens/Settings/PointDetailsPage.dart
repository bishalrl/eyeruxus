import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PointDetailsPage extends StatefulWidget {
  const PointDetailsPage({Key? key}) : super(key: key);

  @override
  State<PointDetailsPage> createState() => _PointDetailsPageState();
}

class _PointDetailsPageState extends State<PointDetailsPage> {
  String selectedTab = 'All'; // Track selected tab

  // All transactions data
  final List<Map<String, dynamic>> allTransactions = [
    {
      'title': 'Transfer to 🇺🇸blind_gifter🎯🧁',
      'subtitle': 'ID:54134939 (Coins account)',
      'date': '2025-07-11 17:53:19',
      'amount': '-108,000',
      'balance': '0',
      'isNegative': true,
    },
    {
      'title': '🎊NIKSBABY🟠COINSELLER🎉',
      'subtitle': 'transfer to me\nID:3039307 (Agent account)',
      'date': '2025-07-11 17:52:37',
      'amount': '+104,000',
      'balance': '108,000',
      'isNegative': false,
    },
    {
      'title': 'Transfer to SU|C|DE"🔥_',
      'subtitle': 'ID:54493891 (Coins account)',
      'date': '2025-07-11 13:55:01',
      'amount': '-100,000',
      'balance': '4,000',
      'isNegative': true,
    },
    {
      'title': '🎊NIKSBABY🟠COINSELLER🎉',
      'subtitle': 'transfer to me\nID:3039307 (Agent account)',
      'date': '2025-07-11 13:44:35',
      'amount': '+104,000',
      'balance': '104,000',
      'isNegative': false,
    },
    {
      'title': 'Transfer to 🇺🇸blind_gifter🎯🧁',
      'subtitle': 'ID:54134939 (Coins account)',
      'date': '2025-07-02 22:57:56',
      'amount': '-108,000',
      'balance': '0',
      'isNegative': true,
    },
    {
      'title': 'NC 🔥 transfer to me',
      'subtitle': 'ID:3485528 (Agent account)',
      'date': '2025-07-01 23:55:58',
      'amount': '+104,000',
      'balance': '108,000',
      'isNegative': false,
    },
    {
      'title': 'Transfer to SU|C|DE"🔥_',
      'subtitle': 'ID:54493891 (Coins account)',
      'date': '',
      'amount': '-100,000',
      'balance': '4,000',
      'isNegative': true,
    },
  ];

  // Get filtered transactions based on selected tab
  List<Map<String, dynamic>> get filteredTransactions {
    if (selectedTab == 'Gains') {
      return allTransactions.where((t) => !t['isNegative']).toList();
    } else if (selectedTab == 'Expenses') {
      return allTransactions.where((t) => t['isNegative']).toList();
    }
    return allTransactions; // All
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tab Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTab('All'),
                  _buildTab('Gains'),
                  _buildTab('Expenses'),
                ],
              ),
            ),
            // Select Date Button
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Select a Date',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          CalendarDatePicker(
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            onDateChanged: (date) {
                              Navigator.pop(context, date);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today, size: 16.sp, color: Colors.black87),
                    SizedBox(width: 6.w),
                    Text(
                      'Select date',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            // Transaction List - Filtered based on selected tab
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = filteredTransactions[index];
                  return _buildTransactionItem(
                    title: transaction['title'],
                    subtitle: transaction['subtitle'],
                    date: transaction['date'],
                    amount: transaction['amount'],
                    balance: transaction['balance'],
                    isNegative: transaction['isNegative'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text) {
    bool isActive = selectedTab == text;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = text;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? Colors.black : Colors.grey,
            ),
          ),
          SizedBox(height: 4.h),
          if (isActive)
            Container(
              height: 2.h,
              width: 20.w,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(1.r),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String subtitle,
    required String date,
    required String amount,
    required String balance,
    required bool isNegative,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
                if (date.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 18.w,
                    height: 18.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'C',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isNegative ? Colors.black : Colors.black,
                    ),
                  ),
                ],
              ),
              Text(
                balance,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}