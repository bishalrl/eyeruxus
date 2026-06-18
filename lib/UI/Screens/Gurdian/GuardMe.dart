import 'package:eye_rex_us/UI/Screens/Gurdian/MyGurdian.dart';
import 'package:flutter/material.dart';


class GuardMeScreen extends StatelessWidget {
  const GuardMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A3728), // Brown tone at top
              Color(0xFF2B1F17), // Darker brown at bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [


              // Empty State Illustration
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Illustration
                    SizedBox(
                      width: size.width * 0.6,
                      height: size.width * 0.4,
                      child: CustomPaint(
                        painter: EmptyStatePainter(),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Text
                    const Text(
                      'You haven\'t guarded someone yet.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

