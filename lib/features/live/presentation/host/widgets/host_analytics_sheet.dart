import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:eye_rex_us/features/live/presentation/theme/live_room_theme.dart';
import 'package:flutter/material.dart';

class HostAnalyticsSheet extends StatelessWidget {
  const HostAnalyticsSheet({super.key, required this.state});

  final LiveRoomInteractionState state;

  @override
  Widget build(BuildContext context) {
    final a = state.hostAnalytics;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Live Analytics',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 20),
            _MetricGrid(metrics: [
              _Metric('Current viewers', LiveRoomTheme.formatCount(a.currentViewers)),
              _Metric('Peak viewers', LiveRoomTheme.formatCount(a.peakViewers)),
              _Metric('Engagement', LiveRoomTheme.formatCount(a.totalEngagement)),
              _Metric('Gifts received', '${a.giftsReceived}'),
              _Metric('Gift earnings', '${a.giftEarnings} coins'),
              _Metric('Revenue', '${a.revenueTotal} coins'),
              _Metric('New followers', '${a.newFollowers}'),
              _Metric('Duration', LiveRoomTheme.formatDuration(a.liveDurationSeconds)),
            ]),
          ],
        ),
      ),
    );
  }
}

class _Metric {
  const _Metric(this.label, this.value);
  final String label;
  final String value;
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.metrics});

  final List<_Metric> metrics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.2,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final m = metrics[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: LiveRoomTheme.glass(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(m.label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
              const SizedBox(height: 4),
              Text(
                m.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
