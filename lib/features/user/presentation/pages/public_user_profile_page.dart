import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/app/router/app_route_args.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/presentation/theme/profile_theme.dart';
import 'package:eye_rex_us/features/user/domain/entities/public_user_profile.dart';
import 'package:eye_rex_us/features/user/domain/repositories/user_repository.dart';
import 'package:eye_rex_us/features/user/presentation/cubit/public_user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicUserProfilePage extends StatelessWidget {
  const PublicUserProfilePage({super.key, required this.args});

  final UserProfileRouteArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PublicUserProfileCubit(
        sl<UserRepository>(),
        PublicUserProfileQuery(
          userId: args.userId,
          displayName: args.displayName,
          avatarUrl: args.avatarUrl,
        ),
      )..load(),
      child: const _PublicUserProfileView(),
    );
  }
}

class _PublicUserProfileView extends StatelessWidget {
  const _PublicUserProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileTheme.background,
      appBar: AppBar(
        backgroundColor: ProfileTheme.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: ProfileTheme.textPrimary),
        title: Text(
          context.l10n.homeNavProfile,
          style: const TextStyle(
            color: ProfileTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocBuilder<PublicUserProfileCubit, PublicUserProfileState>(
        builder: (context, state) {
          if (state.status == PublicUserProfileStatus.loading &&
              state.profile == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == PublicUserProfileStatus.error) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Could not load profile',
                style: const TextStyle(color: ProfileTheme.textPrimary),
              ),
            );
          }
          final profile = state.profile;
          if (profile == null) return const SizedBox.shrink();
          return _ProfileBody(profile: profile);
        },
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.profile});

  final PublicUserProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        Center(
          child: CircleAvatar(
            radius: 48,
            backgroundColor: ProfileTheme.avatarBrown,
            backgroundImage:
                profile.avatarUrl.isNotEmpty ? NetworkImage(profile.avatarUrl) : null,
            child: profile.avatarUrl.isEmpty
                ? Text(
                    profile.initial,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          profile.displayName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: ProfileTheme.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.profileUserId(profile.userId),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: ProfileTheme.textPrimary,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _StatTile(
                value: '${profile.friends}',
                label: l10n.profileFriends,
              ),
            ),
            Expanded(
              child: _StatTile(
                value: '${profile.following}',
                label: l10n.homeFollowing,
              ),
            ),
            Expanded(
              child: _StatTile(
                value: '${profile.followers}',
                label: l10n.homeFollowers,
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => Navigator.maybePop(context),
            style: FilledButton.styleFrom(
              backgroundColor: ProfileTheme.avatarBrown,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text('Follow'),
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: ProfileTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: ProfileTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
