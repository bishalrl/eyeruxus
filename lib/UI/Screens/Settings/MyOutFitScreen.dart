import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOutfitScreen extends StatefulWidget {
  const MyOutfitScreen({Key? key}) : super(key: key);

  @override
  State<MyOutfitScreen> createState() => _MyOutfitScreenState();
}

class _MyOutfitScreenState extends State<MyOutfitScreen> {
  bool _showCategoryMenu = false;
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'icon': '🎒', 'label': 'Backpack Gifts'},
    {'icon': '👤', 'label': 'Avatar Frame'},
    {'icon': '🎨', 'label': 'Party Theme'},
    {'icon': '🚗', 'label': 'Rides'},
    {'icon': '🆔', 'label': 'Rare ID'},
    {'icon': '🎫', 'label': 'Profile card'},
    {'icon': '💬', 'label': 'Chat bubble'},
    {'icon': '🎭', 'label': 'Props'},
  ];

  final List<String> _tabs = ['Backpack Gifts', 'Avatar Frame', 'Party Theme'];

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildCategoryBottomSheet(),
    );
  }

  Widget _buildCategoryBottomSheet() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8.h),
          Container(
            width: 35.w,
            height: 3.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 15.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.85,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 12.h,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              return _buildCategoryItem(
                _categories[index]['icon'],
                _categories[index]['label'],
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String emoji, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Center(
            child: Text(
              emoji,
              style: TextStyle(fontSize: 24.sp),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey.shade700,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
          'My outfit',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Category Menu or Tabs
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: _showCategoryMenu
                ? Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 8.h),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.85,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 12.h,
                    ),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return _buildCategoryItem(
                        _categories[index]['icon'],
                        _categories[index]['label'],
                      );
                    },
                  ),
                ],
              ),
            )
                : Container(
              color: Colors.white,
              padding:
              EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
              child: Row(
                children: [
                  ..._tabs.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String tab = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = idx;
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              tab,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: _selectedCategoryIndex == idx
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: _selectedCategoryIndex == idx
                                    ? Colors.black
                                    : Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            if (_selectedCategoryIndex == idx)
                              Container(
                                width: 30.w,
                                height: 2.h,
                                color: Colors.black,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const Spacer(),
                  GestureDetector(
                    onTap: _showBottomSheet,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      child: Icon(
                        Icons.menu,
                        size: 20.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content Area
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Empty illustration
                  Container(
                    width: 120.w,
                    height: 100.h,
                    child: CustomPaint(
                      painter: EmptyGiftPainter(),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'No backpack gift yet',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyGiftPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE8E0D5)
      ..style = PaintingStyle.fill;

    // Draw gift box
    final boxRect = Rect.fromLTWH(
      size.width * 0.3,
      size.height * 0.4,
      size.width * 0.4,
      size.height * 0.35,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(boxRect, const Radius.circular(4)),
      paint,
    );

    // Draw lid
    final lidRect = Rect.fromLTWH(
      size.width * 0.25,
      size.height * 0.32,
      size.width * 0.5,
      size.height * 0.12,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(lidRect, const Radius.circular(4)),
      paint,
    );

    // Draw tree
    final treePaint = Paint()
      ..color = const Color(0xFFD4C4B0)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.55),
      size.width * 0.08,
      treePaint,
    );

    final trunkRect = Rect.fromLTWH(
      size.width * 0.72,
      size.height * 0.6,
      size.width * 0.06,
      size.height * 0.15,
    );
    canvas.drawRect(trunkRect, treePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}