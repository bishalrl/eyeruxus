import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_discovery_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/pages/live_discovery_page.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/live_session_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveRoomsRoute extends StatelessWidget {
  const LiveRoomsRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LiveDiscoveryCubit>(),
      child: const LiveSessionScope(child: LiveDiscoveryPage()),
    );
  }
}
