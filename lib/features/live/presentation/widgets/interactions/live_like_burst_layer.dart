import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:flutter/material.dart';

class LiveLikeBurstLayer extends StatelessWidget {
  const LiveLikeBurstLayer({super.key, required this.bursts});

  final List<LiveLikeBurst> bursts;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (final burst in bursts)
          _BurstReaction(
            key: ValueKey(burst.id),
            dx: burst.dx,
            dy: burst.dy,
            emoji: burst.emoji,
          ),
      ],
    );
  }
}

class _BurstReaction extends StatefulWidget {
  const _BurstReaction({
    super.key,
    required this.dx,
    required this.dy,
    required this.emoji,
  });

  final double dx;
  final double dy;
  final String emoji;

  @override
  State<_BurstReaction> createState() => _BurstReactionState();
}

class _BurstReactionState extends State<_BurstReaction>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return Positioned(
          left: MediaQuery.sizeOf(context).width * widget.dx - 16,
          top: MediaQuery.sizeOf(context).height * widget.dy - 16 - t * 60,
          child: Opacity(
            opacity: 1 - t,
            child: Transform.scale(
              scale: 0.6 + t * 0.8,
              child: Text(widget.emoji, style: const TextStyle(fontSize: 32)),
            ),
          ),
        );
      },
    );
  }
}
