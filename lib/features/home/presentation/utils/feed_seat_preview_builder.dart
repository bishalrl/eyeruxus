import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/layouts/live_layout_registry.dart';

/// Builds lightweight seat grids for home/party feed previews.
abstract final class FeedSeatPreviewBuilder {
  static List<LiveSeat> build({
    required String layoutRoomId,
    required String hostName,
    required String hostAvatarUrl,
    required int stageMemberCount,
    String seed = '',
  }) {
    final seatCount = LiveLayoutRegistry.seatCountForRoom(layoutRoomId);
    final occupied = stageMemberCount.clamp(1, seatCount);

    final host = LiveParticipant(
      id: 'preview_host',
      name: hostName,
      avatarUrl: hostAvatarUrl,
      role: LiveParticipantRole.host,
      isSpeaking: true,
    );

    return List<LiveSeat>.generate(seatCount, (index) {
      if (index == 0) {
        return LiveSeat(
          index: index,
          status: LiveSeatStatus.occupied,
          participant: host,
        );
      }
      if (index < occupied) {
        final guestIndex = index;
        return LiveSeat(
          index: index,
          status: LiveSeatStatus.occupied,
          participant: LiveParticipant(
            id: 'preview_guest_$guestIndex',
            name: 'Guest $guestIndex',
            avatarUrl: 'https://i.pravatar.cc/150?img=${(guestIndex + seed.hashCode.abs()) % 70 + 1}',
            role: LiveParticipantRole.cohost,
          ),
        );
      }
      return LiveSeat(index: index, status: LiveSeatStatus.empty);
    });
  }
}
