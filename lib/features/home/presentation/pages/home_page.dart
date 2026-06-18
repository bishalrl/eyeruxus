import 'package:eye_rex_us/features/home/presentation/bloc/home_bloc.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/home_event.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/home_state.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/action_tabs_section.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/hall_of_fame_banner.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/header_section.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/home_live_feed_section.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/search_bar_widget.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/stories_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeColors.gradientOrange,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return Container(
              decoration: const BoxDecoration(gradient: HomeColors.pageGradient),
              child: const SafeArea(
                child: Column(
                  children: [
                    HeaderSection(),
                    ActionTabsSection(),
                    Expanded(
                      child: Center(
                        child: CircularProgressIndicator(color: HomeColors.textWhite),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is HomeLoadedState) {
            return Container(
              decoration: const BoxDecoration(gradient: HomeColors.pageGradient),
              child: SafeArea(
                bottom: false,
                child: RefreshIndicator(
                  color: HomeColors.accentOrange,
                  onRefresh: () async {
                    context.read<HomeBloc>().add(
                          LoadHomeDataEvent(tab: state.selectedTab),
                        );
                    await context.read<HomeBloc>().stream.firstWhere(
                          (s) => s is HomeLoadedState || s is HomeErrorState,
                        );
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeaderSection(),
                        const ActionTabsSection(),
                        const SearchBarWidget(),
                        const SizedBox(height: 4),
                        StoriesSection(stories: state.stories),
                        const HallOfFameBanner(),
                        HomeLiveFeedSection(rooms: state.rooms),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          if (state is HomeErrorState) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: HomeColors.textWhite),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
