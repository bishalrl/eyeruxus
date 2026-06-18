import 'package:eye_rex_us/l10n/app_localizations.dart';

abstract final class DevLauncherLabels {
  static String resolve(AppLocalizations l10n, String key) {
    return switch (key) {
      'devMovieScreen' => l10n.devMovieScreen,
      'devChatRoom8' => l10n.devChatRoom8,
      'devChatRoom16' => l10n.devChatRoom16,
      'devChatRoom12' => l10n.devChatRoom12,
      'devChatRoom4' => l10n.devChatRoom4,
      'devChatRoom10' => l10n.devChatRoom10,
      'devChatRoom3' => l10n.devChatRoom3,
      'devChatRoom20' => l10n.devChatRoom20,
      'devChatRoom18' => l10n.devChatRoom18,
      'devChatRoomLudo' => l10n.devChatRoomLudo,
      'devPkScreen' => l10n.devPkScreen,
      'devVipGuardian' => l10n.devVipGuardian,
      'devStore' => l10n.devStore,
      'devSettings' => l10n.devSettings,
      'devAccountSecurity' => l10n.devAccountSecurity,
      'devPrivilegeSettings' => l10n.devPrivilegeSettings,
      'devPaymentMethods' => l10n.devPaymentMethods,
      'devWithdraw' => l10n.devWithdraw,
      'devBankDetails' => l10n.devBankDetails,
      'devAgentAccount' => l10n.devAgentAccount,
      'devSuperFunds' => l10n.devSuperFunds,
      'devExchangeCoins' => l10n.devExchangeCoins,
      'devPoints' => l10n.devPoints,
      'devPointDetails' => l10n.devPointDetails,
      'devHostApplication' => l10n.devHostApplication,
      'devTransfer' => l10n.devTransfer,
      'devAudioPreview' => l10n.devAudioPreview,
      'devLiveScreen' => l10n.devLiveScreen,
      'devReviewParty' => l10n.devReviewParty,
      'devLiveBattle' => l10n.devLiveBattle,
      'devPreviewWindow' => l10n.devPreviewWindow,
      'devDashboard' => l10n.devDashboard,
      'devLiveRooms' => l10n.devLiveRooms,
      _ => key,
    };
  }
}
