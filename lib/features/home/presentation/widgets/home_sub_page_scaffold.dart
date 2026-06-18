import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:flutter/material.dart';

class HomeSubPageScaffold extends StatelessWidget {
  const HomeSubPageScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeColors.backgroundBlack,
      body: Container(
        decoration: const BoxDecoration(gradient: HomeColors.pageGradient),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: HomeColors.textWhite,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: HomeColors.textGrey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: const BoxDecoration(
                    color: HomeColors.backgroundBlack,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
