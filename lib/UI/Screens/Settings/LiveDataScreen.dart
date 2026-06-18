import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveDataScreen extends StatefulWidget {
  const LiveDataScreen({Key? key}) : super(key: key);

  @override
  State<LiveDataScreen> createState() => _LiveDataScreenState();
}

class _LiveDataScreenState extends State<LiveDataScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0; // 0: Daily, 1: Weekly, 2: Monthly
  int _topTab = 0; // 0: Live data, 1: PK data

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 22.sp),
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.zero,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _topTab = 0;
                });
              },
              child: Column(
                children: [
                  Text(
                    'Live data',
                    style: TextStyle(
                      color: _topTab == 0 ? Colors.black : Colors.grey,
                      fontSize: 15.sp,
                      fontWeight:
                      _topTab == 0 ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    height: 2.h,
                    width: 60.w,
                    color: _topTab == 0 ? Colors.black : Colors.transparent,
                  ),
                ],
              ),
            ),
            SizedBox(width: 24.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  _topTab = 1;
                });
              },
              child: Column(
                children: [
                  Text(
                    'PK data',
                    style: TextStyle(
                      color: _topTab == 1 ? Colors.black : Colors.grey,
                      fontSize: 15.sp,
                      fontWeight:
                      _topTab == 1 ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    height: 2.h,
                    width: 60.w,
                    color: _topTab == 1 ? Colors.black : Colors.transparent,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.black, size: 22.sp),
            onPressed: () {},
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTab = 0;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'Daily data',
                          style: TextStyle(
                            color:
                            _selectedTab == 0 ? Colors.black : Colors.grey,
                            fontSize: 14.sp,
                            fontWeight: _selectedTab == 0
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          height: 2.h,
                          width: 60.w,
                          color: _selectedTab == 0
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTab = 1;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'Weekly Data',
                          style: TextStyle(
                            color:
                            _selectedTab == 1 ? Colors.black : Colors.grey,
                            fontSize: 14.sp,
                            fontWeight: _selectedTab == 1
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          height: 2.h,
                          width: 60.w,
                          color: _selectedTab == 1
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTab = 2;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          'Monthly data',
                          style: TextStyle(
                            color:
                            _selectedTab == 2 ? Colors.black : Colors.grey,
                            fontSize: 14.sp,
                            fontWeight: _selectedTab == 2
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          height: 2.h,
                          width: 60.w,
                          color: _selectedTab == 2
                              ? Colors.black
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _selectedTab == 0
                  ? _buildDailyData()
                  : _selectedTab == 1
                  ? _buildWeeklyData()
                  : _buildMonthlyData(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyData() {
    return Container(
      margin: EdgeInsets.all(12.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F5),
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
                  Text(
                    '2025-12-01',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down,
                      size: 18.sp, color: Colors.black),
                ],
              ),
              Text(
                'ID:65695710',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.pink.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Center(
            child: Column(
              children: [
                Text(
                  '0',
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFE91E63),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Won points',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '00:00:00',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Live duration',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Live earnings',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Center(
            child: Column(
              children: [
                Text(
                  '0',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Average number of\nonline users today',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '00:00:00',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Party Duration',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Party Earnings',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Center(
            child: Column(
              children: [
                Text(
                  '00:00:00',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Party crown duration',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'The number of new fans',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'New members of fans\nclub',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.pink.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '👑',
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(width: 4.w),
                Text(
                  'will get more points rewards aft',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF5B5FFF), Color(0xFF7B7FFF)],
              ),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Center(
              child: Text(
                'Get more points',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyData() {
    return Container(
      margin: EdgeInsets.all(12.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
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
                        Text(
                          'Current Week',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down,
                            size: 18.sp, color: Colors.black),
                      ],
                    ),
                    Text(
                      'ID:65695710',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 120.h,
                  child: CustomPaint(
                    size: Size(double.infinity, 120.h),
                    painter: ChartPainter(),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('12-01',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                    Text('12-02',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                    Text('12-03',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                    Text('12-04',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                    Text('12-05',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                    Text('12-06',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                    Text('12-07',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE91E63),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Points',
                      style: TextStyle(fontSize: 11.sp, color: Colors.black54),
                    ),
                    SizedBox(width: 16.w),
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF5B5FFF),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Live broadcast duration (minutes)',
                      style: TextStyle(fontSize: 11.sp, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '00:00',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Total Duration(h/min)',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.monetization_on,
                                  size: 16.sp, color: const Color(0xFFE91E63)),
                              SizedBox(width: 4.w),
                              Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Total earnings',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Column(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Average number of online\nusers this week',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'The number of new fans',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'New members of fans\nclub',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyData() {
    return Container(
      margin: EdgeInsets.all(12.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'This month',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down,
                        size: 18.sp, color: Colors.black),
                  ],
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 120.h,
                  child: CustomPaint(
                    size: Size(double.infinity, 120.h),
                    painter: ChartPainter(),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('12-01',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                    Text('12-02',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                    Text('12-03',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                    Text('12-04',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                    Text('12-05',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                    Text('12-06',
                        style:
                        TextStyle(fontSize: 11.sp, color: Colors.black54)),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE91E63),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Income',
                      style: TextStyle(fontSize: 11.sp, color: Colors.black54),
                    ),
                    SizedBox(width: 16.w),
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF5B5FFF),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Duration',
                      style: TextStyle(fontSize: 11.sp, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '00:00',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Total Duration(h/min)',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.monetization_on,
                                  size: 16.sp, color: const Color(0xFFE91E63)),
                              SizedBox(width: 4.w),
                              Text(
                                '0',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Total earnings',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Total earnings in the past 3\nmonths (excluding\nplatform rewards):',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.monetization_on,
                            size: 16.sp, color: const Color(0xFFE91E63)),
                        SizedBox(width: 4.w),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintPink = Paint()
      ..color = const Color(0xFFE91E63)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final paintBlue = Paint()
      ..color = const Color(0xFF5B5FFF)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final circlePaint = Paint()..style = PaintingStyle.fill;

    // Draw horizontal line for both charts
    final pathPink = Path();
    final pathBlue = Path();
    final double y = size.height / 2;
    final double stepX = size.width / 6;

    pathPink.moveTo(0, y);
    pathBlue.moveTo(0, y);

    for (int i = 0; i <= 6; i++) {
      final x = i * stepX;
      pathPink.lineTo(x, y);
      pathBlue.lineTo(x, y);

      // Draw circles
      circlePaint.color = const Color(0xFFE91E63);
      canvas.drawCircle(Offset(x, y), 4, circlePaint);

      circlePaint.color = const Color(0xFF5B5FFF);
      canvas.drawCircle(Offset(x, y), 4, circlePaint);
    }

    canvas.drawPath(pathPink, paintPink);
    canvas.drawPath(pathBlue, paintBlue);

    // Draw "0" labels above the line
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    for (int i = 0; i <= 6; i++) {
      final x = i * stepX;
      textPainter.text = TextSpan(
        text: '0',
        style: TextStyle(
          color: Colors.black45,
          fontSize: 11.sp,
        ),
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(x - textPainter.width / 2, y - 20.h));
    }

    // Draw time labels
    final times = ['00:00', '00:00', '00:00', '00:00', '00:00', '00:00', '00:00'];
    for (int i = 0; i < times.length; i++) {
      final x = i * stepX;
      textPainter.text = TextSpan(
          text: times[i],
          style: TextStyle(
              color: i == 6 ? const Color(0xFF5B5FFF): Colors.black54,
            fontSize: 10.sp,
          ),
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(x - textPainter.width / 2, size.height - 15.h));
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}