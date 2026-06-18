import 'package:eye_rex_us/UI/Screens/Gurdian/GuardMe.dart';
import 'package:eye_rex_us/UI/Screens/Gurdian/MyGurdian.dart';
import 'package:eye_rex_us/UI/Screens/VIPScreens/VIPScreen.dart';
import 'package:eye_rex_us/features/guardian_vip/presentation/bloc/guardian_vip_bloc.dart';
import 'package:eye_rex_us/shared/widgets/feature_state_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuardianVipBoundPage extends StatefulWidget {
  const GuardianVipBoundPage({super.key, required this.child});

  final Widget child;

  @override
  State<GuardianVipBoundPage> createState() => _GuardianVipBoundPageState();
}

class _GuardianVipBoundPageState extends State<GuardianVipBoundPage> {
  @override
  void initState() {
    super.initState();
    context.read<GuardianVipBloc>().add(const GuardianVipTiersRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuardianVipBloc, GuardianVipState>(
      builder: (context, state) {
        if (state is GuardianVipLoading || state is GuardianVipInitial) {
          return const FeatureLoadingView();
        }
        if (state is GuardianVipFailure) {
          return FeatureErrorView(message: state.message);
        }
        return widget.child;
      },
    );
  }
}

class VipDetailPage extends StatelessWidget {
  const VipDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GuardianVipBoundPage(child: VIPScreen());
  }
}

class MyGuardianPage extends StatelessWidget {
  const MyGuardianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GuardianVipBoundPage(child: MyGuardianScreen());
  }
}

class GuardMePage extends StatelessWidget {
  const GuardMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GuardianVipBoundPage(child: GuardMeScreen());
  }
}
