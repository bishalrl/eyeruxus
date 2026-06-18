import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentAccountScreen extends StatefulWidget {
  const AgentAccountScreen({Key? key}) : super(key: key);

  @override
  State<AgentAccountScreen> createState() => _AgentAccountScreenState();
}

class _AgentAccountScreenState extends State<AgentAccountScreen> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 16.sp,
          ),
        ),
        title: Text(
          'Agent account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
        
              // Coins Trading Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF9A56), Color(0xFFFF7A2D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Coins trading',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B6B),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.swap_horiz,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                'Exchange',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Text(
                            'Top Up',
                            style: TextStyle(
                              color: const Color(0xFFFF7A2D),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        
              SizedBox(height: 20.h),
        
              // Transfer To Section
              Row(
                children: [
                  Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Transfer To',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
        
              SizedBox(height: 8.h),
        
              // User ID Input
              Container(
                height: 44.h,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  controller: _userIdController,
                  decoration: InputDecoration(
                    hintText: 'User ID',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    suffixIcon: Icon(
                      Icons.person_outline,
                      color: const Color(0xFF6366F1),
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
        
              SizedBox(height: 16.h),
        
              // Transfer Amount Section
              Row(
                children: [
                  Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Transfer Amount',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
        
              SizedBox(height: 8.h),
        
              // Amount Input
              Container(
                height: 44.h,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Please enter coins amount',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    prefixIcon: Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.orange,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
        
              const Spacer(),
        
              // Transfer Button
              Container(
                width: double.infinity,
                height: 44.h,
                margin: EdgeInsets.only(bottom: 24.h),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle transfer action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9C9FFF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Transfer',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
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
}