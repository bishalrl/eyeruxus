import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:flutter/material.dart';

class LiveConnectionBanner extends StatelessWidget {
  const LiveConnectionBanner({
    super.key,
    required this.quality,
    this.onRetry,
  });

  final LiveConnectionQuality quality;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    if (quality == LiveConnectionQuality.good) return const SizedBox.shrink();

    final isPoor = quality == LiveConnectionQuality.poor;
    return Positioned(
      top: MediaQuery.paddingOf(context).top + 8,
      left: 48,
      right: 48,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isPoor ? Colors.orange.shade900.withValues(alpha: 0.92) : Colors.red.shade900.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                isPoor ? Icons.signal_cellular_alt_1_bar : Icons.wifi_off,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isPoor ? 'Weak connection — stream may lag' : 'Reconnecting…',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              if (onRetry != null && !isPoor)
                TextButton(
                  onPressed: onRetry,
                  child: const Text('Retry', style: TextStyle(color: Colors.white)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
