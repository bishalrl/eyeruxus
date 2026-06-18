import 'package:eye_rex_us/features/live/domain/entities/live_platform_entities.dart';
import 'package:eye_rex_us/features/live/presentation/theme/live_room_theme.dart';
import 'package:flutter/material.dart';

/// Dual-host PK score bar with countdown and winner state.
class LivePkBattleOverlay extends StatelessWidget {
  const LivePkBattleOverlay({
    super.key,
    required this.pk,
    required this.hostName,
  });

  final LivePkBattleState pk;
  final String hostName;

  @override
  Widget build(BuildContext context) {
    if (pk.phase == PkBattlePhase.idle) return const SizedBox.shrink();

    final total = (pk.hostScore + pk.opponentScore).clamp(1, 999999);
    final hostRatio = pk.hostScore / total;

    return Positioned(
      top: MediaQuery.paddingOf(context).top + 56,
      left: 12,
      right: 12,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            if (pk.phase == PkBattlePhase.finished && pk.winnerId != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber.shade700, Colors.orange.shade900],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  pk.winnerId == 'opponent' ? '${pk.opponentHostName} wins!' : '$hostName wins!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              )
            else
              Text(
                pk.phase == PkBattlePhase.countdown ? 'PK starting…' : _formatTime(pk.secondsRemaining),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                ),
              ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                height: 28,
                child: Row(
                  children: [
                    Expanded(
                      flex: (hostRatio * 100).round().clamp(1, 99),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 8),
                        color: LiveRoomTheme.accent,
                        child: Text(
                          '$hostName ${pk.hostScore}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: ((1 - hostRatio) * 100).round().clamp(1, 99),
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 8),
                        color: Colors.purple.shade600,
                        child: Text(
                          '${pk.opponentHostName} ${pk.opponentScore}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
