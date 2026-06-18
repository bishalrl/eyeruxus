import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IdInviteScreen extends StatelessWidget {
  const IdInviteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8E0F5),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Link invite',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 30.w),
            Column(
              children: [
                Text(
                  'ID invite',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  width: 50.w,
                  height: 2.h,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Container(
              width: 28.w,
              height: 28.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Center(
                child: Text(
                  '📋',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFF9E6), Color(0xFFFFE8CC)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Center(
                child: Text(
                  'Share links and IDs to invite friends n',
                  style: TextStyle(
                    color: const Color(0xFFFF6B35),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // Main Card
            Container(
              margin: EdgeInsets.fromLTRB(12.w, 15.h, 12.w, 12.h),
              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile Avatar
                  Container(
                    width: 70.w,
                    height: 70.h,
                    decoration: const BoxDecoration(
                      color: Color(0xFF6B9B4E),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'P',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Username
                  Text(
                    'PrathameshSaraf',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // User ID
                  Text(
                    'ID:65695710',
                    style: TextStyle(
                      color: const Color(0xFF5E6FE5),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Copy Button
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5E6FE5),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Center(
                      child: Text(
                        'COPY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tutorial Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Tutorial Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 25.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade200,
                              Colors.grey.shade400
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          'Share ID Invitation Tutorial',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: 25.w,
                        height: 2.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade400,
                              Colors.grey.shade200
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Tutorial Steps
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTutorialStep(
                        '1.Click the "Copy User ID" button above to copy your user ID.',
                      ),
                      SizedBox(height: 6.h),
                      _buildTutorialStep(
                        '2.Send the copied ID to your friend.',
                      ),
                      SizedBox(height: 6.h),
                      _buildTutorialStep(
                        '3.During registration, your friend must enter your ID and complete sign-up. (See image below)',
                      ),
                      SizedBox(height: 6.h),
                      _buildTutorialStep(
                        '4.Make sure your friend hasn\'t registered before, Otherwise, the binding entry won\'t be shown.',
                      ),
                      SizedBox(height: 12.h),
                      // Note Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  height: 1.4,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Note: ',
                                    style: TextStyle(
                                      color: const Color(0xFFE53935),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                    'The inviter\'s ID must be entered before completing registration. Binding or modifications are not allowed after confirmation.',
                                    style: TextStyle(
                                      color: const Color(0xFFE53935),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          // Tutorial Image
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF5E6FE5),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6.r),
                                        topRight: Radius.circular(6.r),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '📱',
                                        style: TextStyle(fontSize: 35.sp),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(6.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(6.r),
                                        bottomRight: Radius.circular(6.r),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Complete personal data',
                                          style: TextStyle(
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3.h, horizontal: 4.w),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                            BorderRadius.circular(3.r),
                                          ),
                                          child: Text(
                                            'Bess Yang',
                                            style: TextStyle(
                                              fontSize: 7.sp,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3.h, horizontal: 4.w),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                            BorderRadius.circular(3.r),
                                          ),
                                          child: Text(
                                            '****',
                                            style: TextStyle(
                                              fontSize: 7.sp,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 3.h, horizontal: 4.w),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius:
                                            BorderRadius.circular(3.r),
                                          ),
                                          child: Text(
                                            '3984-09-18',
                                            style: TextStyle(
                                              fontSize: 7.sp,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTutorialStep(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey.shade700,
        fontSize: 11.sp,
        height: 1.4,
      ),
    );
  }
}