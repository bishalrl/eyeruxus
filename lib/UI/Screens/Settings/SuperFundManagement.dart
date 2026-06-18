import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuperFundsManagementScreen extends StatelessWidget {
  const SuperFundsManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 22.sp),
          onPressed: () {},
          padding: EdgeInsets.zero,
        ),
        title: Text(
          'Super Funds management',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.black, size: 22.sp),
            onPressed: () {},
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Super Funds Card
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5B9FEE), Color(0xFF6BA8F5)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.account_balance_wallet,
                                color: Colors.orange, size: 16.sp),
                            SizedBox(width: 4.w),
                            Text(
                              'Super Funds:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Icon(Icons.help_outline,
                                color: Colors.white, size: 14.sp),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Text(
                            'Top Up',
                            style: TextStyle(
                              color: const Color(0xFF4A90E2),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.account_balance_wallet,
                                      color: Colors.orange, size: 14.sp),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'Platform Rewards:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 3.w),
                                  Icon(Icons.help_outline,
                                      color: Colors.white, size: 12.sp),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.ac_unit,
                                      color: Colors.orange, size: 14.sp),
                                  SizedBox(width: 3.w),
                                  Text(
                                    'Frozen Funds:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      width: double.infinity,
                      height: 1.h,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '0 Funds, expires within 7 days > >',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
        
              // Super Salary Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                child: Column(
                  children: [
                    Text(
                      'Super Salary',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F7FA),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoItem('0', 'Super salary list >'),
                              ),
                              Container(
                                width: 1.w,
                                height: 50.h,
                                color: Colors.grey.shade300,
                              ),
                              Expanded(
                                child: _buildInfoItem('0', 'Participating host >'),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            width: double.infinity,
                            height: 1.h,
                            color: Colors.grey.shade300,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoItem(
                                    '0', 'This week\'s expenditure', true),
                              ),
                              Container(
                                width: 1.w,
                                height: 50.h,
                                color: Colors.grey.shade300,
                              ),
                              Expanded(
                                child: _buildInfoItem(
                                    '0', 'The host has received the Funds', true),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        
              // Data/Manage Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF4A90E2)),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Text(
                            'Data',
                            style: TextStyle(
                              color: const Color(0xFF4A90E2),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4A90E2), Color(0xFF7B6FED)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Text(
                            'Manage',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        
              // Super Rank Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                child: Column(
                  children: [
                    Text(
                      'Super Rank',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F7FA),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoItem('0', 'Ongoing rank >'),
                              ),
                              Container(
                                width: 1.w,
                                height: 50.h,
                                color: Colors.grey.shade300,
                              ),
                              Expanded(
                                child: _buildInfoItem('0', 'Listed host', true),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            width: double.infinity,
                            height: 1.h,
                            color: Colors.grey.shade300,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoItem(
                                    '0', 'Received Funds this week', true),
                              ),
                              Container(
                                width: 1.w,
                                height: 50.h,
                                color: Colors.grey.shade300,
                              ),
                              Expanded(
                                child: _buildInfoItem(
                                    '0', 'Cumulative Funds received', true),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        
              // Data/Manage Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF4A90E2)),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Text(
                            'Data',
                            style: TextStyle(
                              color: const Color(0xFF4A90E2),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4A90E2), Color(0xFF7B6FED)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: Text(
                            'Manage',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        
              // Super Party Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                child: Column(
                  children: [
                    Text(
                      'Super Party',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F7FA),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoItem('0', 'Ongoing rank >'),
                              ),
                              Container(
                                width: 1.w,
                                height: 50.h,
                                color: Colors.grey.shade300,
                              ),
                              Expanded(
                                child:
                                _buildInfoItem('0', 'Users on the rank', true),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8.h),
                            width: double.infinity,
                            height: 1.h,
                            color: Colors.grey.shade300,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoItem(
                                    '0', 'Received Funds this week', true),
                              ),
                              Container(
                                width: 1.w,
                                height: 50.h,
                                color: Colors.grey.shade300,
                              ),
                              Expanded(
                                child: _buildInfoItem(
                                    '0', 'Cumulative Funds received', true),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        
              // Bottom Manage Button
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 16.h),
                child: Container(
                  width: double.infinity,
                  height: 44.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF7B6FED)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(22.r),
                  ),
                  child: Center(
                    child: Text(
                      'Manage',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String value, String label, [bool hasIcon = false]) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (hasIcon) ...[
              SizedBox(width: 3.w),
              Icon(Icons.help_outline, color: Colors.grey.shade600, size: 12.sp),
            ],
          ],
        ),
      ],
    );
  }
}