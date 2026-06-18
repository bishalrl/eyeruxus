import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_feed_tab.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_room.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/party_bloc.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/party_event.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/party_state.dart';
import 'package:eye_rex_us/features/home/presentation/navigation/party_routes.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/home_sub_page_scaffold.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/party/party_featured_banner.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/party/party_friends_strip.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/party/party_quick_actions.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/party/party_room_grid.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/party/party_top_bar.dart';
import 'package:eye_rex_us/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Party tab — browse, join, and create voice party rooms.
class PartyPage extends StatelessWidget {
  const PartyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return HomeSubPageScaffold(
      title: l10n.homePartyTitle,
      subtitle: l10n.homePartySubtitle,
      child: BlocBuilder<PartyBloc, PartyState>(
        builder: (context, state) {
          if (state is PartyInitial) {
            return const Center(
              child: CircularProgressIndicator(color: HomeColors.partyAccent),
            );
          }

          if (state is PartyError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: HomeColors.textGrey),
                ),
              ),
            );
          }

          final tab = switch (state) {
            PartyLoaded(:final tab) => tab,
            PartyLoading(:final tab) => tab,
            _ => PartyFeedTab.hot,
          };

          final rooms = state is PartyLoaded ? state.rooms : const <PartyRoom>[];
          final friends = state is PartyLoaded
              ? state.friendsInParty
              : const <PartyFriendActivity>[];
          final isRefreshing = state is PartyLoading;

          return RefreshIndicator(
            color: HomeColors.partyAccent,
            onRefresh: () async {
              context.read<PartyBloc>().add(PartyFeedRequested(tab: tab));
              await context.read<PartyBloc>().stream.firstWhere(
                    (s) => s is PartyLoaded || s is PartyError,
                  );
            },
            child: ListView(
              padding: const EdgeInsets.only(bottom: 128),
              children: [
                PartyTopBar(
                  selectedTab: tab,
                  onTabChanged: (t) =>
                      context.read<PartyBloc>().add(PartyTabChanged(t)),
                ),
                PartyQuickActions(
                  onCreateParty: () => PartyRoutes.openCreateParty(context),
                  onPartyThemes: () => PartyRoutes.openPartyThemes(context),
                ),
                PartyFeaturedBanner(rooms: rooms),
                PartyFriendsStrip(
                  friends: friends,
                  onFriendTap: (_) {
                    final first = rooms.isNotEmpty ? rooms.first : null;
                    if (first != null) {
                      PartyRoutes.joinRoom(context, first, allRooms: rooms);
                    }
                  },
                ),
                if (isRefreshing)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: CircularProgressIndicator(color: HomeColors.partyAccent),
                    ),
                  )
                else
                  PartyRoomGrid(
                    rooms: rooms,
                    vibeLabelFor: (key) => _vibeLabel(l10n, key),
                    onJoinSeat: (room, seatIndex) => PartyRoutes.joinRoomSeat(
                      context,
                      room,
                      seatIndex,
                      allRooms: rooms,
                    ),
                    onWatch: (room) =>
                        PartyRoutes.watchRoom(context, room, allRooms: rooms),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _vibeLabel(AppLocalizations l10n, String key) {
    return switch (key) {
      'partyVibeSinging' => l10n.partyVibeSinging,
      'partyVibeGaming' => l10n.partyVibeGaming,
      'partyVibeDancing' => l10n.partyVibeDancing,
      'partyVibeComedy' => l10n.partyVibeComedy,
      'partyVibeChill' => l10n.partyVibeChill,
      _ => l10n.partyVibeChatting,
    };
  }
}
