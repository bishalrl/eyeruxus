import 'package:eye_rex_us/app/router/app_route_args.dart';
import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_room.dart';
import 'package:flutter/material.dart';

abstract final class PartyRoutes {
  static void openCreateParty(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.goLive);
  }

  static void openPartyThemes(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.storePartyTheme);
  }

  /// Vertical swipe feed — browse parties, request or join a seat on any room.
  static void openBrowseFeed(
    BuildContext context, {
    required List<PartyRoom> rooms,
    required PartyRoom initialRoom,
    int? preferredSeatIndex,
    bool instantJoinSeat = false,
  }) {
    if (rooms.isEmpty) return;

    final initialIndex = rooms.indexWhere((r) => r.id == initialRoom.id);
    final index = initialIndex >= 0 ? initialIndex : 0;

    AppRouter.pushNamed(
      context,
      AppRouteNames.liveBrowse,
      arguments: LiveRoomBrowseRouteArgs(
        initialIndex: index,
        initialSeatRequestIndex: preferredSeatIndex,
        instantJoinSeat: instantJoinSeat,
        entries: rooms
            .map(
              (room) => LiveRoomBrowseEntry(
                roomId: room.layoutRoomId ?? 'room_8',
                title: room.title,
                partyId: room.id,
              ),
            )
            .toList(),
      ),
    );
  }

  static void joinRoom(
    BuildContext context,
    PartyRoom room, {
    List<PartyRoom>? allRooms,
  }) {
    openBrowseFeed(
      context,
      rooms: allRooms ?? [room],
      initialRoom: room,
    );
  }

  static void watchRoom(
    BuildContext context,
    PartyRoom room, {
    List<PartyRoom>? allRooms,
  }) {
    openBrowseFeed(
      context,
      rooms: allRooms ?? [room],
      initialRoom: room,
    );
  }

  /// From party card + seat — instant join on that seat, then swipe to other lives.
  static void joinRoomSeat(
    BuildContext context,
    PartyRoom room,
    int seatIndex, {
    List<PartyRoom>? allRooms,
  }) {
    openBrowseFeed(
      context,
      rooms: allRooms ?? [room],
      initialRoom: room,
      preferredSeatIndex: seatIndex,
      instantJoinSeat: true,
    );
  }
}
