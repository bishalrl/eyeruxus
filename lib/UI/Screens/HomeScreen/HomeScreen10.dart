import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../CommonComponant/AppBar.dart';

class HomeScreen10 extends StatelessWidget {
  const HomeScreen10({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAF1D18),
      appBar: CustomAppBar(),
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   width: double.infinity,
          //   height: 300.h,
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.centerLeft,
          //       end: Alignment.centerRight,
          //       colors: [
          //         Color(0xFF0F172A), // Dark blue/navy
          //         Color(0xFF4A1D1D), // Dark maroon
          //       ],
          //     ),
          //   ),
          //   child: Column(
          //     children: [
          //       // Header with PK badge
          //       Container(
          //         height: 50,
          //         margin: EdgeInsets.all(20),
          //         child: Stack(
          //           children: [
          //             // Background gradient for header
          //             Row(
          //               children: [
          //                 Expanded(
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                       gradient: LinearGradient(
          //                         colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
          //                       ),
          //                     ),
          //                     alignment: Alignment.center,
          //                     child: Text(
          //                       'Frost',
          //                       style: TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 24,
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Expanded(
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                       gradient: LinearGradient(
          //                         colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
          //                       ),
          //                     ),
          //                     alignment: Alignment.center,
          //                     child: Text(
          //                       'Blaze',
          //                       style: TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 24,
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             // PK Badge in center
          //             Center(
          //               child: Container(
          //                 width: 80,
          //                 height: 50,
          //                 decoration: BoxDecoration(
          //                   gradient: LinearGradient(
          //                     begin: Alignment.centerLeft,
          //                     end: Alignment.centerRight,
          //                     colors: [Color(0xFF3B82F6), Color(0xFFEF4444)],
          //                   ),
          //                   borderRadius: BorderRadius.circular(8),
          //                   border: Border.all(color: Color(0xFFFFD700), width: 2),
          //                 ),
          //                 child: Stack(
          //                   children: [
          //                     // Shield shape background
          //                     ClipPath(
          //                       child: Container(
          //                         decoration: BoxDecoration(
          //                           gradient: LinearGradient(
          //                             begin: Alignment.centerLeft,
          //                             end: Alignment.centerRight,
          //                             colors: [Color(0xFF3B82F6), Color(0xFFEF4444)],
          //                           ),
          //                           borderRadius: BorderRadius.circular(8),
          //                         ),
          //                       ),
          //                     ),
          //                     Center(
          //                       child: Text(
          //                         'PK',
          //                         style: TextStyle(
          //                           color: Colors.white,
          //                           fontSize: 20,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             // Question mark icon
          //             Positioned(
          //               top: 10,
          //               right: 15,
          //               child: Container(
          //                 width: 30,
          //                 height: 30,
          //                 decoration: BoxDecoration(
          //                   color: Color(0xFF64748B),
          //                   shape: BoxShape.circle,
          //                 ),
          //                 child: Center(
          //                   child: Text(
          //                     '?',
          //                     style: TextStyle(
          //                       color: Colors.white,
          //                       fontSize: 18,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       // Player cards grid
          //       Expanded(
          //         child: Row(
          //           children: [
          //             // Frost team (left side) - 4 grid view
          //             Expanded(
          //               child: Column(
          //                 children: [
          //                   // Row 1
          //                   Expanded(
          //                     child: Row(
          //                       children: [
          //                         // Player 1 - Saraf
          //                         Expanded(
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                               color: Color(0xFF1E3A8A).withValues(alpha: 0.4),
          //                               borderRadius: BorderRadius.circular(12),
          //                               border: Border.all(color: Color(0xFF3B82F6), width: 2),
          //                             ),
          //                             child: Column(
          //                               children: [
          //                                 Expanded(
          //                                   flex: 1,
          //                                   child: Container(
          //                                     margin: EdgeInsets.all(8),
          //                                     child: Stack(
          //                                       children: [
          //                                         // Profile image with gradient border
          //                                         Container(
          //                                           width: double.infinity,
          //                                           height: double.infinity,
          //                                           decoration: BoxDecoration(
          //                                             shape: BoxShape.circle,
          //                                             gradient: LinearGradient(
          //                                               colors: [Color(0xFF8B5CF6), Color(0xFFEC4899), Color(0xFFFFD700)],
          //                                             ),
          //                                             border: Border.all(color: Color(0xFFFFD700), width: 3),
          //                                           ),
          //                                           child: Padding(
          //                                             padding: EdgeInsets.all(3),
          //                                             child: CircleAvatar(
          //                                               backgroundColor: Color(0xFF374151),
          //                                               backgroundImage: NetworkImage('https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face'),
          //                                             ),
          //                                           ),
          //                                         ),
          //                                         // Mute icon
          //                                         Positioned(
          //                                           bottom: 0,
          //                                           right: 0,
          //                                           child: Container(
          //                                             padding: EdgeInsets.all(2),
          //                                             decoration: BoxDecoration(
          //                                               color: Color(0xFF64748B),
          //                                               shape: BoxShape.circle,
          //                                             ),
          //                                             child: Icon(Icons.mic_off, color: Colors.white, size: 12),
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ),
          //                                 // Name and index
          //                                 Container(
          //                                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //                                   child: Row(
          //                                     children: [
          //                                       Container(
          //                                         width: 18,
          //                                         height: 18,
          //                                         decoration: BoxDecoration(
          //                                           color: Color(0xFF3B82F6),
          //                                           shape: BoxShape.circle,
          //                                         ),
          //                                         child: Center(
          //                                           child: Text('1', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          //                                         ),
          //                                       ),
          //                                       SizedBox(width: 6),
          //                                       Expanded(
          //                                         child: Text(
          //                                           'Saraf',
          //                                           style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
          //                                           overflow: TextOverflow.ellipsis,
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 // Stars
          //                                 Container(
          //                                   padding: EdgeInsets.only(bottom: 8),
          //                                   child: Row(
          //                                     mainAxisAlignment: MainAxisAlignment.center,
          //                                     children: [
          //                                       Icon(Icons.star, color: Color(0xFFFFD700), size: 14),
          //                                       Text(' 0', style: TextStyle(color: Colors.white, fontSize: 12)),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                         // Player 2
          //                         Expanded(
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                               color: Color(0xFF1E3A8A).withValues(alpha: 0.4),
          //                               borderRadius: BorderRadius.circular(12),
          //                               border: Border.all(color: Color(0xFF3B82F6), width: 2),
          //                             ),
          //                             child: Column(
          //                               children: [
          //                                 Expanded(
          //                                   flex: 1,
          //                                   child: Container(
          //                                     margin: EdgeInsets.all(8),
          //                                     child: Stack(
          //                                       children: [
          //                                         Container(
          //                                           width: double.infinity,
          //                                           height: double.infinity,
          //                                           decoration: BoxDecoration(
          //                                             shape: BoxShape.circle,
          //                                             border: Border.all(color: Color(0xFF64748B), width: 2),
          //                                           ),
          //                                           child: Padding(
          //                                             padding: EdgeInsets.all(2),
          //                                             child: CircleAvatar(
          //                                               backgroundColor: Color(0xFF374151),
          //                                               backgroundImage: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face'),
          //                                             ),
          //                                           ),
          //                                         ),
          //                                         Positioned(
          //                                           bottom: 0,
          //                                           right: 0,
          //                                           child: Container(
          //                                             padding: EdgeInsets.all(2),
          //                                             decoration: BoxDecoration(
          //                                               color: Color(0xFF64748B),
          //                                               shape: BoxShape.circle,
          //                                             ),
          //                                             child: Icon(Icons.mic_off, color: Colors.white, size: 12),
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //                                   child: Row(
          //                                     children: [
          //                                       Container(
          //                                         width: 18,
          //                                         height: 18,
          //                                         decoration: BoxDecoration(
          //                                           color: Color(0xFFEF4444),
          //                                           shape: BoxShape.circle,
          //                                         ),
          //                                         child: Center(
          //                                           child: Text('2', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          //                                         ),
          //                                       ),
          //                                       SizedBox(width: 6),
          //                                       Expanded(
          //                                         child: Text(
          //                                           'ყαη || ɭ_α 🐻',
          //                                           style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
          //                                           overflow: TextOverflow.ellipsis,
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   padding: EdgeInsets.only(bottom: 8),
          //                                   child: Row(
          //                                     mainAxisAlignment: MainAxisAlignment.center,
          //                                     children: [
          //                                       Icon(Icons.star, color: Color(0xFFFFD700), size: 14),
          //                                       Text(' 0', style: TextStyle(color: Colors.white, fontSize: 12)),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   // Row 2
          //                   Expanded(
          //                     child: Row(
          //                       children: [
          //                         // Empty slot NO.3
          //                         Expanded(
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                               color: Color(0xFF1E3A8A).withValues(alpha: 0.2),
          //                               borderRadius: BorderRadius.circular(12),
          //                               border: Border.all(color: Color(0xFF3B82F6).withValues(alpha: 0.5), width: 2),
          //                             ),
          //                             child: Column(
          //                               mainAxisAlignment: MainAxisAlignment.center,
          //                               children: [
          //                                 Container(
          //                                   width: 50,
          //                                   height: 50,
          //                                   decoration: BoxDecoration(
          //                                     color: Color(0xFF3B82F6),
          //                                     shape: BoxShape.circle,
          //                                   ),
          //                                   child: Icon(Icons.add, color: Colors.white, size: 30),
          //                                 ),
          //                                 SizedBox(height: 8),
          //                                 Text(
          //                                   'NO.3',
          //                                   style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                         // Empty slot NO.4
          //                         Expanded(
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                               color: Color(0xFF1E3A8A).withValues(alpha: 0.2),
          //                               borderRadius: BorderRadius.circular(12),
          //                               border: Border.all(color: Color(0xFF3B82F6).withValues(alpha: 0.5), width: 2),
          //                             ),
          //                             child: Column(
          //                               mainAxisAlignment: MainAxisAlignment.center,
          //                               children: [
          //                                 Container(
          //                                   width: 50,
          //                                   height: 50,
          //                                   decoration: BoxDecoration(
          //                                     color: Color(0xFF3B82F6),
          //                                     shape: BoxShape.circle,
          //                                   ),
          //                                   child: Icon(Icons.add, color: Colors.white, size: 30),
          //                                 ),
          //                                 SizedBox(height: 8),
          //                                 Text(
          //                                   'NO.4',
          //                                   style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             // Blaze team (right side) - 4 grid view
          //             Expanded(
          //               child: Column(
          //                 children: [
          //                   // Row 1
          //                   Expanded(
          //                     child: Row(
          //                       children: [
          //                         // Player 1 - Harry
          //                         Expanded(
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                               color: Color(0xFF7C2D12).withValues(alpha: 0.4),
          //                               borderRadius: BorderRadius.circular(12),
          //                               border: Border.all(color: Color(0xFFEF4444), width: 2),
          //                             ),
          //                             child: Column(
          //                               children: [
          //                                 Expanded(
          //                                   flex: 1,
          //                                   child: Container(
          //                                     margin: EdgeInsets.all(8),
          //                                     child: Stack(
          //                                       children: [
          //                                         Container(
          //                                           width: double.infinity,
          //                                           height: double.infinity,
          //                                           decoration: BoxDecoration(
          //                                             shape: BoxShape.circle,
          //                                             gradient: LinearGradient(
          //                                               colors: [Color(0xFFFFD700), Color(0xFFFF6B6B), Color(0xFF10B981)],
          //                                             ),
          //                                             border: Border.all(color: Color(0xFFFFD700), width: 3),
          //                                           ),
          //                                           child: Padding(
          //                                             padding: EdgeInsets.all(3),
          //                                             child: CircleAvatar(
          //                                               backgroundColor: Color(0xFFFFD700),
          //                                               backgroundImage: NetworkImage('https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face'),
          //                                             ),
          //                                           ),
          //                                         ),
          //                                         Positioned(
          //                                           bottom: 0,
          //                                           right: 0,
          //                                           child: Container(
          //                                             padding: EdgeInsets.all(2),
          //                                             decoration: BoxDecoration(
          //                                               color: Color(0xFF64748B),
          //                                               shape: BoxShape.circle,
          //                                             ),
          //                                             child: Icon(Icons.mic_off, color: Colors.white, size: 12),
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //                                   child: Row(
          //                                     children: [
          //                                       Container(
          //                                         width: 18,
          //                                         height: 18,
          //                                         decoration: BoxDecoration(
          //                                           color: Color(0xFFEF4444),
          //                                           shape: BoxShape.circle,
          //                                         ),
          //                                         child: Center(
          //                                           child: Text('1', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          //                                         ),
          //                                       ),
          //                                       SizedBox(width: 6),
          //                                       Expanded(
          //                                         child: Text(
          //                                           'Harry',
          //                                           style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
          //                                           overflow: TextOverflow.ellipsis,
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   padding: EdgeInsets.only(bottom: 8),
          //                                   child: Row(
          //                                     mainAxisAlignment: MainAxisAlignment.center,
          //                                     children: [
          //                                       Icon(Icons.star, color: Color(0xFFFFD700), size: 14),
          //                                       Text(' 0', style: TextStyle(color: Colors.white, fontSize: 12)),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                         // Player 2 - Empty with golden ring
          //                         Expanded(
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                               color: Color(0xFF7C2D12).withValues(alpha: 0.4),
          //                               borderRadius: BorderRadius.circular(12),
          //                               border: Border.all(color: Color(0xFFEF4444), width: 2),
          //                             ),
          //                             child: Column(
          //                               children: [
          //                                 Expanded(
          //                                   flex: 1,
          //                                   child: Container(
          //                                     margin: EdgeInsets.all(8),
          //                                     child: Stack(
          //                                       children: [
          //                                         Container(
          //                                           width: double.infinity,
          //                                           height: double.infinity,
          //                                           decoration: BoxDecoration(
          //                                             shape: BoxShape.circle,
          //                                             border: Border.all(color: Color(0xFFFFD700), width: 4),
          //                                           ),
          //                                           child: Padding(
          //                                             padding: EdgeInsets.all(4),
          //                                             child: CircleAvatar(
          //                                               backgroundColor: Colors.black,
          //                                               child: Text('OK', style: TextStyle(color: Color(0xFFFFD700), fontSize: 10, fontWeight: FontWeight.bold)),
          //                                             ),
          //                                           ),
          //                                         ),
          //                                         Positioned(
          //                                           bottom: 0,
          //                                           right: 0,
          //                                           child: Container(
          //                                             padding: EdgeInsets.all(2),
          //                                             decoration: BoxDecoration(
          //                                               color: Color(0xFF64748B),
          //                                               shape: BoxShape.circle,
          //                                             ),
          //                                             child: Icon(Icons.mic_off, color: Colors.white, size: 12),
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //                                   child: Row(
          //                                     children: [
          //                                       Container(
          //                                         width: 18,
          //                                         height: 18,
          //                                         decoration: BoxDecoration(
          //                                           color: Color(0xFFEF4444),
          //                                           shape: BoxShape.circle,
          //                                         ),
          //                                         child: Center(
          //                                           child: Text('2', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          //                                         ),
          //                                       ),
          //                                       SizedBox(width: 6),
          //                                       Expanded(
          //                                         child: Text(
          //                                           '.',
          //                                           style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
          //                                           overflow: TextOverflow.ellipsis,
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   padding: EdgeInsets.only(bottom: 8),
          //                                   child: Row(
          //                                     mainAxisAlignment: MainAxisAlignment.center,
          //                                     children: [
          //                                       Icon(Icons.star, color: Color(0xFFFFD700), size: 14),
          //                                       Text(' 0', style: TextStyle(color: Colors.white, fontSize: 12)),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                   // Row 2
          //                   Expanded(
          //                     child: Row(
          //                       children: [
          //                         // Player 3 - Fire Ghost
          //                         Expanded(
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                               color: Color(0xFF7C2D12).withValues(alpha: 0.4),
          //                               borderRadius: BorderRadius.circular(12),
          //                               border: Border.all(color: Color(0xFFEF4444), width: 2),
          //                             ),
          //                             child: Column(
          //                               children: [
          //                                 Expanded(
          //                                   flex: 1,
          //                                   child: Container(
          //                                     margin: EdgeInsets.all(8),
          //                                     child: Stack(
          //                                       children: [
          //                                         Container(
          //                                           width: double.infinity,
          //                                           height: double.infinity,
          //                                           decoration: BoxDecoration(
          //                                             shape: BoxShape.circle,
          //                                             border: Border.all(color: Color(0xFF64748B), width: 2),
          //                                           ),
          //                                           child: Padding(
          //                                             padding: EdgeInsets.all(2),
          //                                             child: CircleAvatar(
          //                                               backgroundColor: Colors.black,
          //                                               backgroundImage: NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face'),
          //                                             ),
          //                                           ),
          //                                         ),
          //                                         Positioned(
          //                                           bottom: 0,
          //                                           right: 0,
          //                                           child: Container(
          //                                             padding: EdgeInsets.all(2),
          //                                             decoration: BoxDecoration(
          //                                               color: Color(0xFF64748B),
          //                                               shape: BoxShape.circle,
          //                                             ),
          //                                             child: Icon(Icons.mic_off, color: Colors.white, size: 12),
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //                                   child: Row(
          //                                     children: [
          //                                       Container(
          //                                         width: 18,
          //                                         height: 18,
          //                                         decoration: BoxDecoration(
          //                                           color: Color(0xFFEF4444),
          //                                           shape: BoxShape.circle,
          //                                         ),
          //                                         child: Center(
          //                                           child: Text('3', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          //                                         ),
          //                                       ),
          //                                       SizedBox(width: 6),
          //                                       Expanded(
          //                                         child: Text(
          //                                           '🔥 Fire Gh...',
          //                                           style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
          //                                           overflow: TextOverflow.ellipsis,
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   padding: EdgeInsets.only(bottom: 8),
          //                                   child: Row(
          //                                     mainAxisAlignment: MainAxisAlignment.center,
          //                                     children: [
          //                                       Icon(Icons.star, color: Color(0xFFFFD700), size: 14),
          //                                       Text(' 0', style: TextStyle(color: Colors.white, fontSize: 12)),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                         // Player 4 - Black player
          //                         Expanded(
          //                           child: Container(
          //                             decoration: BoxDecoration(
          //                               color: Color(0xFF7C2D12).withValues(alpha: 0.4),
          //                               borderRadius: BorderRadius.circular(12),
          //                               border: Border.all(color: Color(0xFFEF4444), width: 2),
          //                             ),
          //                             child: Column(
          //                               children: [
          //                                 Expanded(
          //                                   flex: 1,
          //                                   child: Container(
          //                                     margin: EdgeInsets.all(8),
          //                                     child: Stack(
          //                                       children: [
          //                                         Container(
          //                                           width: double.infinity,
          //                                           height: double.infinity,
          //                                           decoration: BoxDecoration(
          //                                             shape: BoxShape.circle,
          //                                             gradient: LinearGradient(
          //                                               colors: [Color(0xFF10B981), Color(0xFF059669)],
          //                                             ),
          //                                             border: Border.all(color: Color(0xFF10B981), width: 3),
          //                                           ),
          //                                           child: Padding(
          //                                             padding: EdgeInsets.all(3),
          //                                             child: CircleAvatar(
          //                                               backgroundColor: Color(0xFF374151),
          //                                               backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face'),
          //                                             ),
          //                                           ),
          //                                         ),
          //                                         Positioned(
          //                                           bottom: 0,
          //                                           right: 0,
          //                                           child: Container(
          //                                             padding: EdgeInsets.all(2),
          //                                             decoration: BoxDecoration(
          //                                               color: Color(0xFF64748B),
          //                                               shape: BoxShape.circle,
          //                                             ),
          //                                             child: Icon(Icons.mic_off, color: Colors.white, size: 12),
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //                                   child: Row(
          //                                     children: [
          //                                       Container(
          //                                         width: 18,
          //                                         height: 18,
          //                                         decoration: BoxDecoration(
          //                                           color: Color(0xFFEF4444),
          //                                           shape: BoxShape.circle,
          //                                         ),
          //                                         child: Center(
          //                                           child: Text('4', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          //                                         ),
          //                                       ),
          //                                       SizedBox(width: 6),
          //                                       Expanded(
          //                                         child: Text(
          //                                           '☃️B𝕝ack ...',
          //                                           style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
          //                                           overflow: TextOverflow.ellipsis,
          //                                         ),
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                                 Container(
          //                                   padding: EdgeInsets.only(bottom: 8),
          //                                   child: Row(
          //                                     mainAxisAlignment: MainAxisAlignment.center,
          //                                     children: [
          //                                       Icon(Icons.star, color: Color(0xFFFFD700), size: 14),
          //                                       Text(' 0', style: TextStyle(color: Colors.white, fontSize: 12)),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
         30.verticalSpace,
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 22.h,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xffcd6866),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'Assets/share.png',
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'Assets/textpad.png',
                    height: 22,
                    color: Colors.white,

                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.menu, color: Colors.white,size: 25,)
                ],
              ),
            ),
          ),
          Container(
            height: 285.h,
            width: double.infinity,
            // whole screen bg
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF051327), Color(0xFF2A0910)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // LEFT/RIGHT halves
                Row(
                  children: [
                    // Frost panel
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF0D2B62), Color(0xFF072245)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Frost header pill
                            Container(
                              height: 28.h,
                              alignment: Alignment.center,
                              width: 100.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFF2E70FF),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x552E70FF),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Text(
                                'Frost',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: .3,
                                ),
                              ),
                            ),
                            // grid 2x2 – no spacing
                            Expanded(
                              child: GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                childAspectRatio: 0.62,
                                padding: EdgeInsets.zero,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                children: [
                                  // Frost card 1
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0D3575),
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: const Color(0xFF5AA2FF),
                                        width: 1.2,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x33000000),
                                          blurRadius: 10,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        // avatar
                                        Align(
                                          alignment: const Alignment(0, -0.2),
                                          child: Container(
                                            width: 74,
                                            height: 74,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: const SweepGradient(
                                                colors: [
                                                  Color(0xFF7C4DFF),
                                                  Color(0xFFFFC400),
                                                  Color(0xFF7C4DFF),
                                                ],
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0x664B7BFF),
                                                  blurRadius: 8,
                                                ),
                                              ],
                                            ),
                                            padding: const EdgeInsets.all(3),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    'https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=300',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // name
                                        const Align(
                                          alignment: Alignment(0, 0.55),
                                          child: Text(
                                            '1. Saraf',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        // coin row
                                        Align(
                                          alignment: const Alignment(0, 0.85),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFFFA726),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.star_rounded,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Text(
                                                '0',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // index chip (blue)
                                        Positioned(
                                          left: 8,
                                          top: 8,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF2E70FF),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Text(
                                              '1',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Frost card 2
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0D3575),
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: const Color(0xFF5AA2FF),
                                        width: 1.2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: const Alignment(0, -0.2),
                                          child: Container(
                                            width: 74,
                                            height: 74,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: const SweepGradient(
                                                colors: [
                                                  Color(0xFF7C4DFF),
                                                  Color(0xFFFFC400),
                                                  Color(0xFF7C4DFF),
                                                ],
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(3),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=300',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment: Alignment(0, 0.55),
                                          child: Text(
                                            '2. Vanila',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: const Alignment(0, 0.85),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFFFA726),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.star_rounded,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Text(
                                                '0',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 8,
                                          top: 8,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF2E70FF),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Text(
                                              '2',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Frost empty NO.3
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF103B82),
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: const Color(0xFF5AA2FF),
                                        width: 1.2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: 74,
                                            height: 74,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF2E70FF),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.add,
                                                color: Colors.white, size: 36),
                                          ),
                                        ),
                                        const Align(
                                          alignment: Alignment(0, 0.8),
                                          child: Text(
                                            'NO.3',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Frost empty NO.4
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF103B82),
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: const Color(0xFF5AA2FF),
                                        width: 1.2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: 74,
                                            height: 74,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF2E70FF),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.add,
                                                color: Colors.white, size: 36),
                                          ),
                                        ),
                                        const Align(
                                          alignment: Alignment(0, 0.8),
                                          child: Text(
                                            'NO.4',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700),
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

                    // Blaze panel
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF5B0B10), Color(0xFF2D0A0E)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Blaze header pill
                            Container(
                              height: 28.h,
                              alignment: Alignment.center,
                              width: 100.w,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE3403A),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x55E3403A),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Text(
                                'Blaze',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: .3,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GridView.count(
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                childAspectRatio: 0.62,
                                padding: EdgeInsets.zero,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0,
                                children: [
                                  // Blaze card 1
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3E0D12),
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: const Color(0xFFFF6A5F),
                                        width: 1.2,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x33000000),
                                          blurRadius: 10,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: const Alignment(0, -0.2),
                                          child: Container(
                                            width: 74,
                                            height: 74,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: const SweepGradient(
                                                colors: [
                                                  Color(0xFFFF7E6C),
                                                  Color(0xFFFFE082),
                                                  Color(0xFFFF7E6C),
                                                ],
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(3),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=300',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment: Alignment(0, 0.55),
                                          child: Text(
                                            '1. Harry',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: const Alignment(0, 0.85),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFFFA726),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.star_rounded,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Text(
                                                '0',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // red index chip
                                        Positioned(
                                          left: 8,
                                          top: 8,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFE3403A),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Text(
                                              '1',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Blaze card 2
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3E0D12),
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: const Color(0xFFFF6A5F),
                                        width: 1.2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: const Alignment(0, -0.2),
                                          child: Container(
                                            width: 74,
                                            height: 74,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: const SweepGradient(
                                                colors: [
                                                  Color(0xFFFF7E6C),
                                                  Color(0xFFFFE082),
                                                  Color(0xFFFF7E6C),
                                                ],
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(3),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    'https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?w=300',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment: Alignment(0, 0.55),
                                          child: Text(
                                            '2. Nova',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: const Alignment(0, 0.85),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFFFA726),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.star_rounded,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Text(
                                                '0',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 8,
                                          top: 8,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFE3403A),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Text(
                                              '2',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Blaze card 3
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3E0D12),
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: const Color(0xFFFF6A5F),
                                        width: 1.2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: const Alignment(0, -0.2),
                                          child: Container(
                                            width: 74,
                                            height: 74,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: const SweepGradient(
                                                colors: [
                                                  Color(0xFFFF7E6C),
                                                  Color(0xFFFFE082),
                                                  Color(0xFFFF7E6C),
                                                ],
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(3),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    'https://images.unsplash.com/photo-1547425260-76bcadfb4f2c?w=300',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment: Alignment(0, 0.55),
                                          child: Text(
                                            '3. Fire Ghost',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: const Alignment(0, 0.85),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFFFA726),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.star_rounded,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Text(
                                                '0',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 8,
                                          top: 8,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFE3403A),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Text(
                                              '3',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Blaze card 4
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3E0D12),
                                      borderRadius: BorderRadius.circular(18),
                                      border: Border.all(
                                        color: const Color(0xFFFF6A5F),
                                        width: 1.2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: const Alignment(0, -0.2),
                                          child: Container(
                                            width: 74,
                                            height: 74,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: const SweepGradient(
                                                colors: [
                                                  Color(0xFF87E89F),
                                                  Color(0xFFB3FFCF),
                                                  Color(0xFF87E89F),
                                                ],
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(3),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=300',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Align(
                                          alignment: Alignment(0, 0.55),
                                          child: Text(
                                            '4. Black Rose',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: const Alignment(0, 0.85),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFFFA726),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.star_rounded,
                                                  color: Colors.white,
                                                  size: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Text(
                                                '0',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          left: 8,
                                          top: 8,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFE3403A),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Text(
                                              '4',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800),
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
                  ],
                ),
                // PK badge in the very center-top seam
                Align(
                  alignment: const Alignment(0, -1),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2E70FF), Color(0xFFE3403A)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x66000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        )
                      ],
                      border: Border.all(color: Colors.white, width: 1),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: const Color(0xFF272B35),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Center(
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC107),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFF8D6E63), width: 1),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x33000000),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            'PK',
                            style: TextStyle(
                              color: Color(0xFF4E2D00),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
