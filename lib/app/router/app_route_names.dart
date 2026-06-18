/// Central route name registry for the whole app.
abstract final class AppRouteNames {
  static const authGate = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const otp = '/otp';
  static const forgotPassword = '/forgot-password';

  static const goLive = '/go-live';
  static const reelsFeed = '/reels-feed';
  static const chatRoom = '/chat-room';
  static const liveBrowse = '/live-browse';
  static const liveSession = '/live-session';
  static const liveRooms = '/live-rooms';

  static const settings = '/settings';
  static const store = '/store';
  static const wallet = '/wallet';
  static const agency = '/agency';
  static const guardianVip = '/guardian-vip';
  static const devLauncher = '/dev-launcher';

  static const privilegeSettings = '/privilege-settings';
  static const newMessagesNotification = '/new-messages-notification';
  static const pointDetails = '/point-details';
  static const withdraw = '/withdraw';
  static const exchangeCoins = '/exchange-coins';
  static const accountSecurity = '/account-security';
  static const paymentMethods = '/payment-methods';
  static const bankDetails = '/bank-details';
  static const transfer = '/transfer';
  static const points = '/points';
  static const myAgency = '/my-agency';
  static const makeMoney = '/make-money';
  static const friends = '/friends';
  static const addHost = '/host-money/add-host';
  static const inviteAgent = '/host-money/invite-agent';
  static const coinsTrading = '/host-money/coins-trading';
  static const ranking = '/ranking';
  static const hostRewards = '/host-rewards';
  static const liveData = '/live-data';
  static const superFunds = '/super-funds';

  static const storeHonorMall = '/store/honor-mall';
  static const storeRareId = '/store/rare-id';
  static const storeRides = '/store/rides';
  static const storeProfileCard = '/store/profile-card';
  static const storeAvatarFrame = '/store/avatar-frame';
  static const storePartyTheme = '/store/party-theme';
  static const storeRoomBubble = '/store/room-bubble';
}

/// @deprecated Use [AppRouteNames] instead.
typedef AppRoutes = AppRouteNames;
