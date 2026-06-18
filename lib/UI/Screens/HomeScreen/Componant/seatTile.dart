import 'package:flutter/material.dart';

class SeatTile extends StatelessWidget {
  final int index;
  final bool occupied;
  final Color bgColor;
  final Color borderColor;
  final Widget emptyIcon;

  const SeatTile({
    super.key,
    required this.index,
    required this.occupied,
    required this.bgColor,
    required this.borderColor,
    required this.emptyIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: occupied
            ? CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white24,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : emptyIcon,
      ),
    );
  }
}
