import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/discover_cubit.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/home_bloc.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/home_event.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/main_dashboard_cubit.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/party_bloc.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/party_event.dart';
import 'package:eye_rex_us/features/home/presentation/navigation/home_live_routes.dart';
import 'package:eye_rex_us/features/home/presentation/pages/chat_page.dart';
import 'package:eye_rex_us/features/home/presentation/pages/discover_page.dart';
import 'package:eye_rex_us/features/home/presentation/pages/home_page.dart';
import 'package:eye_rex_us/features/home/presentation/pages/party_page.dart';
import 'package:eye_rex_us/features/home/presentation/pages/profile_page.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDashboardPage extends StatelessWidget {
  const MainDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<HomeBloc>()..add(const LoadHomeDataEvent()),
        ),
        BlocProvider(create: (_) => sl<MainDashboardCubit>()),
        BlocProvider(create: (_) => sl<DiscoverCubit>()),
        BlocProvider(
          create: (_) => sl<PartyBloc>()..add(const PartyFeedRequested()),
        ),
      ],
      child: const _MainDashboardView(),
    );
  }
}

class _MainDashboardView extends StatelessWidget {
  const _MainDashboardView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainDashboardCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          extendBody: false,
          backgroundColor: HomeColors.backgroundBlack,
          body: _DashboardBody(currentIndex: currentIndex),
          floatingActionButton: GoLiveFab(
            onTap: () => HomeLiveRoutes.openGoLive(context),
          ),
          floatingActionButtonLocation: const GoLiveFabLocation(),
          bottomNavigationBar: BottomAppBar(
            color: HomeColors.navBackground,
            elevation: 0,
            height: 56,
            notchMargin: 5,
            padding: EdgeInsets.zero,
            shape: const CircularNotchedRectangle(),            child: CustomBottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) =>
                  context.read<MainDashboardCubit>().selectTab(index),
            ),
          ),
        );
      },
    );
  }
}

class _DashboardBody extends StatefulWidget {
  const _DashboardBody({required this.currentIndex});

  final int currentIndex;

  @override
  State<_DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<_DashboardBody> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  void didUpdateWidget(covariant _DashboardBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex &&
        _pageController.hasClients) {
      _pageController.jumpToPage(widget.currentIndex);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: context.read<MainDashboardCubit>().selectTab,
      children: const [
        HomePage(),
        PartyPage(),
        DiscoverPage(),
        ChatPage(),
        ProfilePage(),
      ],
    );
  }
}
