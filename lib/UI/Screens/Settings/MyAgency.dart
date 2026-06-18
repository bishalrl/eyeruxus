import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAgencyScreen extends StatelessWidget {
  const MyAgencyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
        ),
        title: Text(
          'My Agency',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 25.h),
              child: Column(
                children: [
                  Text(
                    'Choose',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Method 1',
                        style: TextStyle(
                          color: const Color(0xFFFFEB3B),
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        ' or ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        'Method 2',
                        style: TextStyle(
                          color: const Color(0xFFFFEB3B),
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Method 1 Card
            Container(
              margin: EdgeInsets.fromLTRB(10.w, 15.h, 10.w, 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE53935),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 8.h,
                    left: 12.w,
                    child: Container(
                      width: 12.w,
                      height: 12.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 12.w,
                    child: Container(
                      width: 12.w,
                      height: 12.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12.w),
                    padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFDE7),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Method 1',
                          style: TextStyle(
                            color: const Color(0xFFE53935),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          'Join agent',
                          style: TextStyle(
                            color: const Color(0xFFE53935),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'Agent ID will be provided by agent',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 11.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            'Please enter agent\'s ID',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF9A9A),
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: Center(
                            child: Text(
                              'Please enter agent\'s ID',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Method 2 Card
            Container(
              margin: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE53935),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 8.h,
                    left: 12.w,
                    child: Container(
                      width: 12.w,
                      height: 12.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 12.w,
                    child: Container(
                      width: 12.w,
                      height: 12.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12.w),
                    padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFDE7),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Method 2',
                          style: TextStyle(
                            color: const Color(0xFFE53935),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Text(
                          'Waiting for agent invitation',
                          style: TextStyle(
                            color: const Color(0xFFE53935),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'You are required to provide the agent with\nyour ID and host code',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                                color: const Color(0xFFE53935), width: 1.5),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'User ID: ',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Text(
                                    '65695710',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE53935),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Text(
                                      'Copy',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Host Code: No. ',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Text(
                                    '109odef',
                                    style: TextStyle(
                                      color: const Color(0xFFE53935),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE53935),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Text(
                                      'Copy',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
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
            ),

            // Note Section
            Container(
              margin: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 20.h),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40.w,
                        height: 1.h,
                        color: Colors.grey.shade300,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          'Note',
                          style: TextStyle(
                            color: const Color(0xFFE53935),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: 40.w,
                        height: 1.h,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  _buildNoteItem(
                      '1. After joining the agency, host cannot leave agency without valid reason.'),
                  SizedBox(height: 5.h),
                  _buildNoteItem('2. Host cannot join multiple agents!'),
                  SizedBox(height: 5.h),
                  _buildNoteItem('3. Agent cannot join other agents!'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteItem(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 10.sp,
          height: 1.4,
        ),
      ),
    );
  }
}