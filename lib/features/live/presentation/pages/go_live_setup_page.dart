import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/chat_room/presentation/navigation/chat_room_routes.dart';
import 'package:eye_rex_us/features/chat_room/presentation/pages/chat_room_screens.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/go_live_setup_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_media_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/navigation/live_routes.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/pages/live_permissions_gate.dart';
import 'package:eye_rex_us/features/live/presentation/pages/live_screens.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/live_camera_preview.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:eye_rex_us/shared/widgets/live_layout_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pre-broadcast setup — video/voice, live/party, and seat layout picker.
class GoLiveSetupPage extends StatelessWidget {
  const GoLiveSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<GoLiveSetupCubit>()),
        BlocProvider(create: (_) => sl<LiveMediaCubit>()),
      ],
      child: const _GoLivePreviewBootstrap(child: _GoLiveSetupView()),
    );
  }
}

class _GoLivePreviewBootstrap extends StatefulWidget {
  const _GoLivePreviewBootstrap({required this.child});

  final Widget child;

  @override
  State<_GoLivePreviewBootstrap> createState() => _GoLivePreviewBootstrapState();
}

class _GoLivePreviewBootstrapState extends State<_GoLivePreviewBootstrap> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncPreview());
  }

  void _syncPreview() {
    if (!mounted) return;
    final state = context.read<GoLiveSetupCubit>().state;
    final media = context.read<LiveMediaCubit>();
    final wantsVideo = state.sessionMode == GoLiveSessionMode.live &&
        state.mediaMode == GoLiveMediaMode.video;
    if (wantsVideo) {
      media.initialize(startCamera: true);
    } else {
      media.stopCameraPreview();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _GoLiveSetupView extends StatelessWidget {
  const _GoLiveSetupView();

  static const _gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF5C1A1A), Color(0xFF2A0808)],
  );

  List<String> _categories(BuildContext context) {
    final l10n = context.l10n;
    return [
      l10n.goLiveCategoryChatting,
      l10n.goLiveCategorySinging,
      l10n.goLiveCategoryDancing,
      l10n.goLiveCategoryCrackJokes,
    ];
  }

  void _startSession(BuildContext context, GoLiveSetupState state) {
    final destination = _resolveDestination(state);
    final needsVideoPermissions = state.sessionMode == GoLiveSessionMode.live &&
        state.mediaMode == GoLiveMediaMode.video;

    if (needsVideoPermissions) {
      LiveRoutes.push(
        context,
        LivePermissionsGate(
          forBroadcast: true,
          onGranted: () {
            Navigator.of(context).pop();
            LiveRoutes.push(context, destination);
          },
        ),
      );
      return;
    }

    LiveRoutes.push(context, destination);
  }

  Widget _resolveDestination(GoLiveSetupState state) {
    if (state.sessionMode == GoLiveSessionMode.party) {
      return ChatRoomLayoutPage(
        roomId: state.selectedLayoutRoomId,
        role: LiveParticipantRole.host,
        partyTitle: state.title.isNotEmpty ? state.title : 'Party Live',
      );
    }
    if (state.mediaMode == GoLiveMediaMode.voice) {
      return const LiveAudioPreviewPage();
    }
    return ChatRoomLayoutPage(
      roomId: state.selectedLayoutRoomId,
      role: LiveParticipantRole.host,
    );
  }

  String _startButtonLabel(BuildContext context, GoLiveSetupState state) {
    final l10n = context.l10n;
    if (state.sessionMode == GoLiveSessionMode.party) {
      return l10n.goLiveStartParty;
    }
    if (state.mediaMode == GoLiveMediaMode.voice) {
      return l10n.goLiveStartVoiceRoom;
    }
    return l10n.goLiveStartVideoRoom;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final categories = _categories(context);
    final cubit = context.read<GoLiveSetupCubit>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: _gradient),
        child: SafeArea(
          child: BlocListener<GoLiveSetupCubit, GoLiveSetupState>(
            listenWhen: (prev, curr) =>
                prev.mediaMode != curr.mediaMode ||
                prev.sessionMode != curr.sessionMode,
            listener: (context, state) {
              final media = context.read<LiveMediaCubit>();
              final wantsVideo = state.sessionMode == GoLiveSessionMode.live &&
                  state.mediaMode == GoLiveMediaMode.video;
              if (wantsVideo) {
                media.initialize(startCamera: true);
              } else {
                media.stopCameraPreview();
              }
            },
            child: BlocBuilder<GoLiveSetupCubit, GoLiveSetupState>(
              builder: (context, state) {
                final showVideoPreview = state.sessionMode == GoLiveSessionMode.live &&
                    state.mediaMode == GoLiveMediaMode.video;

                return Column(
                  children: [
                    _TopBar(
                      onFlipCamera: showVideoPreview
                          ? context.read<LiveMediaCubit>().switchCamera
                          : () {},
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: [
                            _ProfileCard(
                              hostLabel: l10n.goLiveHostLabel(l10n.homeProfileName),
                              categories: categories,
                              selectedIndex: state.selectedCategoryIndex,
                              onCategorySelected: cubit.selectCategory,
                            ),
                            SizedBox(
                              height: 220,
                              child: showVideoPreview
                                  ? const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      child: LiveCameraPreview(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                      ),
                                    )
                                  : _PreviewArea(hint: l10n.goLivePreviewHint),
                            ),
                          _SessionModeTabs(
                            sessionMode: state.sessionMode,
                            liveLabel: l10n.goLiveSessionLive,
                            partyLabel: l10n.goLiveSessionParty,
                            onChanged: cubit.setSessionMode,
                          ),
                          const SizedBox(height: 12),
                          _MediaModeToggle(
                            mediaMode: state.mediaMode,
                            videoLabel: l10n.goLiveModeVideo,
                            voiceLabel: l10n.goLiveModeVoice,
                            onChanged: cubit.setMediaMode,
                          ),
                          const SizedBox(height: 12),
                          _HostRoomConfigCard(
                            privacy: state.privacy,
                            onTitleChanged: cubit.setTitle,
                            onDescriptionChanged: cubit.setDescription,
                            onPrivacyChanged: cubit.setPrivacy,
                          ),
                          const SizedBox(height: 12),
                          _LayoutPicker(
                            selectedRoomId: state.selectedLayoutRoomId,
                            onSelected: cubit.selectLayout,
                          ),
                          const SizedBox(height: 8),
                          _ActionBar(
                            startLabel: _startButtonLabel(context, state),
                            onStart: () => _startSession(context, state),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onFlipCamera});

  final VoidCallback onFlipCamera;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 12, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => AppRouter.maybePop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          ),
          const Spacer(),
          IconButton(
            onPressed: onFlipCamera,
            icon: const Icon(Icons.cameraswitch_outlined, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.hostLabel,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  final String hostLabel;
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage(AppAssets.avatar),
                ),
                const SizedBox(width: 10),
                Text(
                  hostLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final label = categories[index];
                  final selected = index == selectedIndex;
                  return GestureDetector(
                    onTap: () => onCategorySelected(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: selected
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: selected
                              ? Colors.white54
                              : Colors.white24,
                        ),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
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

class _PreviewArea extends StatelessWidget {
  const _PreviewArea({required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const AppAssetImage(
            asset: AppAssets.avatarPlaceholder,
            width: 180,
            height: 220,
            fit: BoxFit.contain,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                hint,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaModeToggle extends StatelessWidget {
  const _MediaModeToggle({
    required this.mediaMode,
    required this.videoLabel,
    required this.voiceLabel,
    required this.onChanged,
  });

  final GoLiveMediaMode mediaMode;
  final String videoLabel;
  final String voiceLabel;
  final ValueChanged<GoLiveMediaMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            _ToggleSegment(
              label: videoLabel,
              selected: mediaMode == GoLiveMediaMode.video,
              onTap: () => onChanged(GoLiveMediaMode.video),
            ),
            _ToggleSegment(
              label: voiceLabel,
              selected: mediaMode == GoLiveMediaMode.voice,
              onTap: () => onChanged(GoLiveMediaMode.voice),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleSegment extends StatelessWidget {
  const _ToggleSegment({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const _accent = Color(0xFFFFD600);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: selected ? _accent : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.black : Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _LayoutPicker extends StatelessWidget {
  const _LayoutPicker({
    required this.selectedRoomId,
    required this.onSelected,
  });

  final String selectedRoomId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final items = ChatRoomRoutes.goLivePickerItems;

    return SizedBox(
      height: 76,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = item.roomId == selectedRoomId;
          return _LayoutPickerItem(
            seats: item.seats,
            isSelected: isSelected,
            onTap: () => onSelected(item.roomId),
          );
        },
      ),
    );
  }
}

class _LayoutPickerItem extends StatelessWidget {
  const _LayoutPickerItem({
    required this.seats,
    required this.isSelected,
    required this.onTap,
  });

  final int seats;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white24,
            width: isSelected ? 2.5 : 1,
          ),
        ),
        alignment: Alignment.center,
        child: LiveLayoutThumbnail(
          seats: seats,
          size: 34,
        ),
      ),
    );
  }
}


class _ActionBar extends StatelessWidget {
  const _ActionBar({
    required this.startLabel,
    required this.onStart,
  });

  final String startLabel;
  final VoidCallback onStart;

  static const _accent = Color(0xFFFFD600);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const AppAssetImage(asset: AppAssets.brush, width: 26, height: 26),
          ),
          Expanded(
            child: FilledButton(
              onPressed: onStart,
              style: FilledButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                startLabel,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _SessionModeTabs extends StatelessWidget {
  const _SessionModeTabs({
    required this.sessionMode,
    required this.liveLabel,
    required this.partyLabel,
    required this.onChanged,
  });

  final GoLiveSessionMode sessionMode;
  final String liveLabel;
  final String partyLabel;
  final ValueChanged<GoLiveSessionMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 4, 24, 12),
      child: Row(
        children: [
          Expanded(
            child: _SessionTab(
              label: liveLabel,
              selected: sessionMode == GoLiveSessionMode.live,
              onTap: () => onChanged(GoLiveSessionMode.live),
            ),
          ),
          Expanded(
            child: _SessionTab(
              label: partyLabel,
              selected: sessionMode == GoLiveSessionMode.party,
              onTap: () => onChanged(GoLiveSessionMode.party),
            ),
          ),
        ],
      ),
    );
  }
}

class _SessionTab extends StatelessWidget {
  const _SessionTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const _accent = Color(0xFFFFD600);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? _accent : Colors.white,
              fontSize: 16,
              fontWeight: selected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: selected ? 32 : 0,
            height: 3,
            decoration: BoxDecoration(
              color: _accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _HostRoomConfigCard extends StatelessWidget {
  const _HostRoomConfigCard({
    required this.privacy,
    required this.onTitleChanged,
    required this.onDescriptionChanged,
    required this.onPrivacyChanged,
  });

  final LiveRoomPrivacy privacy;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;
  final ValueChanged<LiveRoomPrivacy> onPrivacyChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: onTitleChanged,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Room title',
                labelStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
            TextField(
              onChanged: onDescriptionChanged,
              maxLines: 2,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final p in LiveRoomPrivacy.values)
                  _PrivacyChip(
                    label: _privacyLabel(p),
                    selected: privacy == p,
                    onTap: () => onPrivacyChanged(p),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _privacyLabel(LiveRoomPrivacy p) => switch (p) {
        LiveRoomPrivacy.publicRoom => 'Public',
        LiveRoomPrivacy.followersOnly => 'Followers',
        LiveRoomPrivacy.privateRoom => 'Private',
        LiveRoomPrivacy.passwordProtected => 'Password',
      };
}

class _PrivacyChip extends StatelessWidget {
  const _PrivacyChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const _accent = Color(0xFFAF1D18);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? _accent : Colors.white.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? _accent : Colors.white.withValues(alpha: 0.5),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
