import 'package:eye_rex_us/features/agency/presentation/pages/agency_page.dart';
import 'package:eye_rex_us/features/chat_room/presentation/pages/chat_room_screens.dart';
import 'package:eye_rex_us/features/guardian_vip/presentation/pages/guardian_vip_page.dart';
import 'package:eye_rex_us/features/live/presentation/pages/live_rooms_page.dart';
import 'package:eye_rex_us/features/live/presentation/pages/live_screens.dart';
import 'package:eye_rex_us/features/settings/presentation/pages/settings_page.dart';
import 'package:eye_rex_us/features/settings/presentation/pages/settings_screens.dart';
import 'package:eye_rex_us/features/store/presentation/pages/store_page.dart';
import 'package:eye_rex_us/features/wallet/presentation/pages/wallet_page.dart';
import 'package:flutter/material.dart';

class DevLauncherEntry {
  final String labelKey;
  final WidgetBuilder builder;

  const DevLauncherEntry({
    required this.labelKey,
    required this.builder,
  });
}

abstract final class DevLauncherConfig {
  static const entries = <DevLauncherEntry>[
    DevLauncherEntry(labelKey: 'devMovieScreen', builder: _movieScreen),
    DevLauncherEntry(labelKey: 'devChatRoom8', builder: _home2),
    DevLauncherEntry(labelKey: 'devChatRoom16', builder: _home3),
    DevLauncherEntry(labelKey: 'devChatRoom12', builder: _home4),
    DevLauncherEntry(labelKey: 'devChatRoom4', builder: _home5),
    DevLauncherEntry(labelKey: 'devChatRoom10', builder: _home6),
    DevLauncherEntry(labelKey: 'devChatRoom3', builder: _home7),
    DevLauncherEntry(labelKey: 'devChatRoom20', builder: _home8),
    DevLauncherEntry(labelKey: 'devChatRoom18', builder: _home9),
    DevLauncherEntry(labelKey: 'devPkScreen', builder: _home10),
    DevLauncherEntry(labelKey: 'devChatRoomLudo', builder: _home11),
    DevLauncherEntry(labelKey: 'devVipGuardian', builder: _guardian),
    DevLauncherEntry(labelKey: 'devStore', builder: _store),
    DevLauncherEntry(labelKey: 'devSettings', builder: _settings),
    DevLauncherEntry(labelKey: 'devAccountSecurity', builder: _accountSecurity),
    DevLauncherEntry(labelKey: 'devPrivilegeSettings', builder: _privilege),
    DevLauncherEntry(labelKey: 'devPaymentMethods', builder: _paymentMethods),
    DevLauncherEntry(labelKey: 'devWithdraw', builder: _withdraw),
    DevLauncherEntry(labelKey: 'devBankDetails', builder: _bankDetails),
    DevLauncherEntry(labelKey: 'devAgentAccount', builder: _agentAccount),
    DevLauncherEntry(labelKey: 'devSuperFunds', builder: _superFunds),
    DevLauncherEntry(labelKey: 'devExchangeCoins', builder: _exchangeCoins),
    DevLauncherEntry(labelKey: 'devPoints', builder: _points),
    DevLauncherEntry(labelKey: 'devPointDetails', builder: _pointDetails),
    DevLauncherEntry(labelKey: 'devHostApplication', builder: _hostApplication),
    DevLauncherEntry(labelKey: 'devTransfer', builder: _transfer),
    DevLauncherEntry(labelKey: 'devAudioPreview', builder: _audioPreview),
    DevLauncherEntry(labelKey: 'devLiveScreen', builder: _liveScreen),
    DevLauncherEntry(labelKey: 'devReviewParty', builder: _reviewParty),
    DevLauncherEntry(labelKey: 'devLiveBattle', builder: _liveBattle),
    DevLauncherEntry(labelKey: 'devPreviewWindow', builder: _previewWindow),
    DevLauncherEntry(labelKey: 'devDashboard', builder: _dashboard),
    DevLauncherEntry(labelKey: 'devLiveRooms', builder: _liveRooms),
  ];

  static Widget _movieScreen(BuildContext _) => const ChatRoomMoviePage();
  static Widget _home2(BuildContext _) => const ChatRoom8Page();
  static Widget _home3(BuildContext _) => const ChatRoom16Page();
  static Widget _home4(BuildContext _) => const ChatRoom12Page();
  static Widget _home5(BuildContext _) => const ChatRoom4Page();
  static Widget _home6(BuildContext _) => const ChatRoom10Page();
  static Widget _home7(BuildContext _) => const ChatRoom3Page();
  static Widget _home8(BuildContext _) => const ChatRoom20Page();
  static Widget _home9(BuildContext _) => const ChatRoom18Page();
  static Widget _home10(BuildContext _) => const ChatRoomPkPage();
  static Widget _home11(BuildContext _) => const ChatRoom11Page();
  static Widget _guardian(BuildContext _) => const GuardianVipPage();
  static Widget _store(BuildContext _) => const StorePage();
  static Widget _settings(BuildContext _) => const SettingsPage();
  static Widget _accountSecurity(BuildContext _) => const AccountSecurityPage();
  static Widget _privilege(BuildContext _) => const PrivilegeSettingsPage();
  static Widget _paymentMethods(BuildContext _) => const PaymentMethodsPage();
  static Widget _withdraw(BuildContext _) => const WalletPage();
  static Widget _bankDetails(BuildContext _) => const BankDetailsPage();
  static Widget _agentAccount(BuildContext _) => const AgentAccountPage();
  static Widget _superFunds(BuildContext _) => const SuperFundsPage();
  static Widget _exchangeCoins(BuildContext _) => const ExchangeCoinsPage();
  static Widget _points(BuildContext _) => const PointsPage();
  static Widget _pointDetails(BuildContext _) => const SettingsPointDetailsPage();
  static Widget _hostApplication(BuildContext _) => const AgencyPage();
  static Widget _transfer(BuildContext _) => const TransferPage();
  static Widget _audioPreview(BuildContext _) => const LiveAudioPreviewPage();
  static Widget _liveScreen(BuildContext _) => const LiveVideoRoomPage();
  static Widget _reviewParty(BuildContext _) => const LiveReviewPartyPage();
  static Widget _liveBattle(BuildContext _) => const LiveBattlePage();
  static Widget _previewWindow(BuildContext _) => const LivePreviewWindowPage();
  static Widget _dashboard(BuildContext _) => const LiveDashboardPage();
  static Widget _liveRooms(BuildContext _) => const LiveRoomsRoute();
}
