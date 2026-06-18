import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinsScreen extends StatelessWidget {
  const CoinsScreen({Key? key}) : super(key: key);

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Coins',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 40.w),
            Text(
              'Points',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFA94D), Color(0xFFFFB84D)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD580),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.stars_rounded,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '100',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Remaining coins',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Top Up',
                        style: TextStyle(
                          color: const Color(0xFFFFA94D),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'All',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: const Color(0xFF6B7AED),
                          size: 16.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '2025-11-29',
                          style: TextStyle(
                            color: const Color(0xFF6B7AED),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Center(
              child: Text(
                'No more',
                style: TextStyle(
                  color: const Color(0xFFAAAAAA),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}