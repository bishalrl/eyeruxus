import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InviteMoreHostsScreen extends StatelessWidget {
  const InviteMoreHostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8A4E8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 24.sp,
                      ),
                    ),
                    10.horizontalSpace,
                    Text(
                      'Invite more hosts',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 24.w),
                  ],
                ),
              ),

              // Illustration
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Image.network(
                  'https://via.placeholder.com/300x200',
                  height: 200.h,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200.h,
                    width: 300.w,
                    color: Colors.white.withValues(alpha: 0.3),
                    child: Icon(Icons.people, size: 80.sp, color: Colors.white),
                  ),
                ),
              ),

              // Form Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Invite friends to join my agency',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Colors.black,
                            size: 20.sp,
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(height: 10.h),

                      // User ID Field
                      Row(
                        children: [
                          Text(
                            '*User ID',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.help_outline,
                            color: Colors.grey,
                            size: 16.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'User ID',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Host Code Field
                      Row(
                        children: [
                          Text(
                            '*Host Code',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.help_outline,
                            color: Colors.grey,
                            size: 16.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Host code No..xxx',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14.sp,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Helper Text
                      Text(
                        'User ID and code provided by the host',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Send Button
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF9B8FE8), Color(0xFFB3A8F5)],
                          ),
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                          ),
                          child: Text(
                            'Send invitation',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Share Download Link Card
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF9B5FD8),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      Text(
                        'If a friend has not downloaded or registered',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          children: [
                            Container(
                              width: 90.w,
                              height: 140.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.network(
                                  'https://via.placeholder.com/90x140',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    color: Colors.grey.shade300,
                                    child: Icon(Icons.phone_android, size: 40.sp),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Share download link',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    'If a friend successfully registers, you can get up to \$14.',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Row(
                                    children: [
                                      Container(
                                        height: 24.h,
                                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(4.r),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.apple, color: Colors.white, size: 14.sp),
                                            SizedBox(width: 2.w),
                                            Text(
                                              'App Store',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      Container(
                                        height: 24.h,
                                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(4.r),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.play_arrow, color: Colors.white, size: 14.sp),
                                            SizedBox(width: 2.w),
                                            Text(
                                              'Google Play',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFFA855F7), Color(0xFF9333EA)],
                                      ),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      'Share Now',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
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
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}