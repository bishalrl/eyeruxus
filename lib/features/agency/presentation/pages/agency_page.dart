import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/core/constants/dev_session.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/agency/domain/entities/host_application.dart';
import 'package:eye_rex_us/features/agency/presentation/bloc/agency_bloc.dart';
import 'package:eye_rex_us/features/agency/presentation/bloc/agency_tab_cubit.dart';
import 'package:eye_rex_us/shared/widgets/feature_state_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AgencyPage extends StatelessWidget {
  const AgencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AgencyTabCubit>(),
      child: const _AgencyPageBody(),
    );
  }
}

class _AgencyPageBody extends StatefulWidget {
  const _AgencyPageBody();

  @override
  State<_AgencyPageBody> createState() => _AgencyPageBodyState();
}

class _AgencyPageBodyState extends State<_AgencyPageBody> {
  @override
  void initState() {
    super.initState();
    context.read<AgencyBloc>().add(
          const AgencyApplicationRequested(
            userId: DevSession.userId,
            accessToken: DevSession.accessToken,
          ),
        );
  }

  String _statusLabel(BuildContext context, String status) {
    final l10n = context.l10n;
    switch (status.toLowerCase()) {
      case 'approved':
        return l10n.agencyStatusApproved;
      case 'pending':
        return l10n.agencyStatusPending;
      case 'rejected':
      default:
        return l10n.agencyStatusRejected;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary, size: 24.sp),
          onPressed: () => AppRouter.pop(context),
        ),
        title: Text(
          l10n.agencyHostApplicationTitle,
          style: textTheme.titleMedium?.copyWith(color: colors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Container(
                height: 44.h,
                decoration: BoxDecoration(
                  color: colors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 14.w, right: 8.w),
                      child: Icon(Icons.search, color: colors.textMuted, size: 22.sp),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: l10n.agencySearchHint,
                          hintStyle: TextStyle(color: colors.textMuted, fontSize: 15.sp),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<AgencyTabCubit, String>(
              builder: (context, selectedTab) {
                return _StatusTabs(
                  selected: selectedTab,
                  onSelected: context.read<AgencyTabCubit>().selectTab,
                );
              },
            ),
            Expanded(
              child: BlocBuilder<AgencyTabCubit, String>(
                builder: (context, selectedTab) {
                  return BlocBuilder<AgencyBloc, AgencyState>(
                    builder: (context, state) {
                      if (state is AgencyLoading || state is AgencyInitial) {
                        return const FeatureLoadingView();
                      }
                      if (state is AgencyFailure) {
                        return FeatureErrorView(message: state.message);
                      }

                      final application =
                          state is AgencyLoaded ? state.application : null;

                      if (application == null) {
                        return Center(
                          child: Text(
                            l10n.agencyNoApplication,
                            style: textTheme.bodyLarge?.copyWith(color: colors.textMuted),
                          ),
                        );
                      }

                      if (application.status.toLowerCase() != selectedTab) {
                        return Center(
                          child: Text(
                            l10n.agencyNoApplication,
                            style: textTheme.bodyLarge?.copyWith(color: colors.textMuted),
                          ),
                        );
                      }

                      return _ApplicationCard(
                        application: application,
                        statusLabel: _statusLabel(context, application.status),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusTabs extends StatelessWidget {
  const _StatusTabs({required this.selected, required this.onSelected});

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final textTheme = context.textTheme;

    final tabs = [
      ('rejected', l10n.agencyStatusRejected),
      ('pending', l10n.agencyStatusPending),
      ('approved', l10n.agencyStatusApproved),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          for (final tab in tabs) ...[
            Expanded(
              child: GestureDetector(
                onTap: () => onSelected(tab.$1),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: selected == tab.$1 ? colors.primary : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    tab.$2,
                    textAlign: TextAlign.center,
                    style: textTheme.labelLarge?.copyWith(
                      color: selected == tab.$1 ? colors.primary : colors.textMuted,
                      fontWeight: selected == tab.$1 ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ApplicationCard extends StatelessWidget {
  const _ApplicationCard({
    required this.application,
    required this.statusLabel,
  });

  final HostApplication application;
  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final textTheme = context.textTheme;
    final date = DateFormat.yMMMd().format(application.submittedAt);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.scaffoldBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              statusLabel,
              style: textTheme.titleMedium?.copyWith(
                color: colors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${l10n.agencyName}: ${application.agencyName}',
              style: textTheme.bodyLarge?.copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              '${l10n.agencySubmittedAt}: $date',
              style: textTheme.bodyMedium?.copyWith(color: colors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
