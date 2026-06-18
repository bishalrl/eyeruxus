import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewMessagesNotificationScreen extends StatefulWidget {
  const NewMessagesNotificationScreen({Key? key}) : super(key: key);

  @override
  State<NewMessagesNotificationScreen> createState() =>
      _NewMessagesNotificationScreenState();
}

class _NewMessagesNotificationScreenState
    extends State<NewMessagesNotificationScreen> {
  bool liveRoomOpening = true;
  bool messageNotificationSwitch = true;
  bool sound = true;
  bool vibrate = true;
  bool mutualFollowers = true;
  bool myFollowing = true;
  bool stranger = true;

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
        ),
        title: Text(
          'New messages notification',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Message notifications'),
            _buildSwitchItem(
              'Live room opening alerts',
              liveRoomOpening,
              (value) => setState(() => liveRoomOpening = value),
            ),
            _buildSwitchItem(
              'Message notification switch',
              messageNotificationSwitch,
              (value) => setState(() => messageNotificationSwitch = value),
            ),
            _buildSectionHeader('Message alert settings'),
            _buildSwitchItem(
              'Sound',
              sound,
              (value) => setState(() => sound = value),
            ),
            _buildSwitchItem(
              'Vibrate',
              vibrate,
              (value) => setState(() => vibrate = value),
            ),
            _buildSectionHeader('Who can send me a private message?'),
            _buildSwitchItem(
              'Mutual followers',
              mutualFollowers,
              (value) => setState(() => mutualFollowers = value),
            ),
            _buildSwitchItem(
              'My Following',
              myFollowing,
              (value) => setState(() => myFollowing = value),
            ),
            _buildSwitchItem(
              'Stranger',
              stranger,
              (value) => setState(() => stranger = value),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
      color: const Color(0xFFF5F5F5),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF888888),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildSwitchItem(
      String title, bool value, Function(bool) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF5F5F5), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: const Color(0xFFE8A76A),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFE0E0E0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}