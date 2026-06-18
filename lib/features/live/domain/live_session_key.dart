/// Stable storage key for live sessions (party rooms share one session per party id).
abstract final class LiveSessionKey {
  static String forRoom({required String roomId, String? partyId}) {
    if (partyId != null && partyId.isNotEmpty) return 'party_${partyId}_$roomId';
    return roomId;
  }
}
