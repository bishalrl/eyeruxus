import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Eye Rex'**
  String get appTitle;

  /// No description provided for @devLauncherTitle.
  ///
  /// In en, this message translates to:
  /// **'List Navigation'**
  String get devLauncherTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAccountSecurity.
  ///
  /// In en, this message translates to:
  /// **'Account and security'**
  String get settingsAccountSecurity;

  /// No description provided for @settingsSecurityLevel.
  ///
  /// In en, this message translates to:
  /// **'Security level:'**
  String get settingsSecurityLevel;

  /// No description provided for @settingsSecurityMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get settingsSecurityMedium;

  /// No description provided for @settingsSecurityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get settingsSecurityHigh;

  /// No description provided for @settingsSecurityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get settingsSecurityLow;

  /// No description provided for @settingsSecurityPassword.
  ///
  /// In en, this message translates to:
  /// **'Security Password'**
  String get settingsSecurityPassword;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language Setting'**
  String get settingsLanguage;

  /// No description provided for @settingsBlacklist.
  ///
  /// In en, this message translates to:
  /// **'Blacklist'**
  String get settingsBlacklist;

  /// No description provided for @settingsPrivilege.
  ///
  /// In en, this message translates to:
  /// **'Privilege settings'**
  String get settingsPrivilege;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'New messages notification'**
  String get settingsNotifications;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About vone'**
  String get settingsAbout;

  /// No description provided for @settingsClearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get settingsClearCache;

  /// No description provided for @settingsSwitchAccount.
  ///
  /// In en, this message translates to:
  /// **'Switch account'**
  String get settingsSwitchAccount;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get settingsLogout;

  /// No description provided for @devMovieScreen.
  ///
  /// In en, this message translates to:
  /// **'Movie Screen'**
  String get devMovieScreen;

  /// No description provided for @devChatRoom8.
  ///
  /// In en, this message translates to:
  /// **'8 chat room'**
  String get devChatRoom8;

  /// No description provided for @devChatRoom16.
  ///
  /// In en, this message translates to:
  /// **'16 chat room'**
  String get devChatRoom16;

  /// No description provided for @devChatRoom12.
  ///
  /// In en, this message translates to:
  /// **'12 chat room'**
  String get devChatRoom12;

  /// No description provided for @devChatRoom4.
  ///
  /// In en, this message translates to:
  /// **'4 chat room'**
  String get devChatRoom4;

  /// No description provided for @devChatRoom10.
  ///
  /// In en, this message translates to:
  /// **'10 chat room'**
  String get devChatRoom10;

  /// No description provided for @devChatRoom3.
  ///
  /// In en, this message translates to:
  /// **'3 chat room'**
  String get devChatRoom3;

  /// No description provided for @devChatRoom20.
  ///
  /// In en, this message translates to:
  /// **'20 chat room'**
  String get devChatRoom20;

  /// No description provided for @devChatRoom18.
  ///
  /// In en, this message translates to:
  /// **'18 chat room'**
  String get devChatRoom18;

  /// No description provided for @devChatRoomLudo.
  ///
  /// In en, this message translates to:
  /// **'Ludo chat room'**
  String get devChatRoomLudo;

  /// No description provided for @devPkScreen.
  ///
  /// In en, this message translates to:
  /// **'pk screen'**
  String get devPkScreen;

  /// No description provided for @devVipGuardian.
  ///
  /// In en, this message translates to:
  /// **'VIP & Guardian'**
  String get devVipGuardian;

  /// No description provided for @devStore.
  ///
  /// In en, this message translates to:
  /// **'Store Page'**
  String get devStore;

  /// No description provided for @devSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings Page'**
  String get devSettings;

  /// No description provided for @devAccountSecurity.
  ///
  /// In en, this message translates to:
  /// **'Account Security Page'**
  String get devAccountSecurity;

  /// No description provided for @devPrivilegeSettings.
  ///
  /// In en, this message translates to:
  /// **'Privilege Settings Page'**
  String get devPrivilegeSettings;

  /// No description provided for @devPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods Page'**
  String get devPaymentMethods;

  /// No description provided for @devWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Page'**
  String get devWithdraw;

  /// No description provided for @devBankDetails.
  ///
  /// In en, this message translates to:
  /// **'Bank Details Page'**
  String get devBankDetails;

  /// No description provided for @devAgentAccount.
  ///
  /// In en, this message translates to:
  /// **'Agent Account Page'**
  String get devAgentAccount;

  /// No description provided for @devSuperFunds.
  ///
  /// In en, this message translates to:
  /// **'Super Funds Management Page'**
  String get devSuperFunds;

  /// No description provided for @devExchangeCoins.
  ///
  /// In en, this message translates to:
  /// **'Exchange Coins Page'**
  String get devExchangeCoins;

  /// No description provided for @devPoints.
  ///
  /// In en, this message translates to:
  /// **'Points Page'**
  String get devPoints;

  /// No description provided for @devPointDetails.
  ///
  /// In en, this message translates to:
  /// **'Point Details Page'**
  String get devPointDetails;

  /// No description provided for @devHostApplication.
  ///
  /// In en, this message translates to:
  /// **'Host Application Page'**
  String get devHostApplication;

  /// No description provided for @devTransfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer Page'**
  String get devTransfer;

  /// No description provided for @devAudioPreview.
  ///
  /// In en, this message translates to:
  /// **'Audio Preview Page'**
  String get devAudioPreview;

  /// No description provided for @devLiveScreen.
  ///
  /// In en, this message translates to:
  /// **'Live Screen Page'**
  String get devLiveScreen;

  /// No description provided for @devReviewParty.
  ///
  /// In en, this message translates to:
  /// **'Review Party Screen'**
  String get devReviewParty;

  /// No description provided for @devLiveBattle.
  ///
  /// In en, this message translates to:
  /// **'Live Battle Screen'**
  String get devLiveBattle;

  /// No description provided for @devPreviewWindow.
  ///
  /// In en, this message translates to:
  /// **'Preview Window Screen'**
  String get devPreviewWindow;

  /// No description provided for @devDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard Screen'**
  String get devDashboard;

  /// No description provided for @devLiveRooms.
  ///
  /// In en, this message translates to:
  /// **'Live Rooms List'**
  String get devLiveRooms;

  /// No description provided for @storeTitle.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get storeTitle;

  /// No description provided for @storeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get storeSearchHint;

  /// No description provided for @storeCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get storeCategory;

  /// No description provided for @storeComingNew.
  ///
  /// In en, this message translates to:
  /// **'Coming New'**
  String get storeComingNew;

  /// No description provided for @storeHotRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Hot recommendation'**
  String get storeHotRecommendation;

  /// No description provided for @storeSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get storeSend;

  /// No description provided for @storePurchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase'**
  String get storePurchase;

  /// No description provided for @storeStayTuned.
  ///
  /// In en, this message translates to:
  /// **'Stay tuned…'**
  String get storeStayTuned;

  /// No description provided for @storeStayTunedMessage.
  ///
  /// In en, this message translates to:
  /// **'Stay tuned for more categories!'**
  String get storeStayTunedMessage;

  /// No description provided for @storeCategoryHonorMall.
  ///
  /// In en, this message translates to:
  /// **'Honor Mall'**
  String get storeCategoryHonorMall;

  /// No description provided for @storeCategoryRareId.
  ///
  /// In en, this message translates to:
  /// **'Rare ID'**
  String get storeCategoryRareId;

  /// No description provided for @storeCategoryRides.
  ///
  /// In en, this message translates to:
  /// **'Rides'**
  String get storeCategoryRides;

  /// No description provided for @storeCategoryProfileCard.
  ///
  /// In en, this message translates to:
  /// **'Profile card'**
  String get storeCategoryProfileCard;

  /// No description provided for @storeCategoryAvatarFrame.
  ///
  /// In en, this message translates to:
  /// **'Avatar Frame'**
  String get storeCategoryAvatarFrame;

  /// No description provided for @storeCategoryPartyTheme.
  ///
  /// In en, this message translates to:
  /// **'Party Theme'**
  String get storeCategoryPartyTheme;

  /// No description provided for @storeCategoryRoomBubble.
  ///
  /// In en, this message translates to:
  /// **'Room bubble'**
  String get storeCategoryRoomBubble;

  /// No description provided for @vipGuardianTitle.
  ///
  /// In en, this message translates to:
  /// **'VIP & Guardian'**
  String get vipGuardianTitle;

  /// No description provided for @vipTabGuardian.
  ///
  /// In en, this message translates to:
  /// **'Guardian'**
  String get vipTabGuardian;

  /// No description provided for @vipTabVip.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get vipTabVip;

  /// No description provided for @vipComingSoon.
  ///
  /// In en, this message translates to:
  /// **'This feature coming soon!'**
  String get vipComingSoon;

  /// No description provided for @vipPrivileges.
  ///
  /// In en, this message translates to:
  /// **'Privileges'**
  String get vipPrivileges;

  /// No description provided for @vipOpenTier.
  ///
  /// In en, this message translates to:
  /// **'Open {tierName}'**
  String vipOpenTier(String tierName);

  /// No description provided for @walletWithdrawTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get walletWithdrawTitle;

  /// No description provided for @walletRecord.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get walletRecord;

  /// No description provided for @walletScamAlert.
  ///
  /// In en, this message translates to:
  /// **'Scam Prevention Alert'**
  String get walletScamAlert;

  /// No description provided for @walletAvailableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get walletAvailableBalance;

  /// No description provided for @walletCoins.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get walletCoins;

  /// No description provided for @walletPoints.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get walletPoints;

  /// No description provided for @walletWithdrawable.
  ///
  /// In en, this message translates to:
  /// **'Withdrawable'**
  String get walletWithdrawable;

  /// No description provided for @walletWithdrawNow.
  ///
  /// In en, this message translates to:
  /// **'Withdraw now'**
  String get walletWithdrawNow;

  /// No description provided for @agencyHostApplicationTitle.
  ///
  /// In en, this message translates to:
  /// **'Host Application'**
  String get agencyHostApplicationTitle;

  /// No description provided for @agencySearchHint.
  ///
  /// In en, this message translates to:
  /// **'ID number or nickname'**
  String get agencySearchHint;

  /// No description provided for @agencyStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get agencyStatusRejected;

  /// No description provided for @agencyStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get agencyStatusPending;

  /// No description provided for @agencyStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get agencyStatusApproved;

  /// No description provided for @agencyNoApplication.
  ///
  /// In en, this message translates to:
  /// **'No application found'**
  String get agencyNoApplication;

  /// No description provided for @agencyName.
  ///
  /// In en, this message translates to:
  /// **'Agency'**
  String get agencyName;

  /// No description provided for @agencySubmittedAt.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get agencySubmittedAt;

  /// No description provided for @liveRoomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Live Rooms'**
  String get liveRoomsTitle;

  /// No description provided for @liveParticipants.
  ///
  /// In en, this message translates to:
  /// **'{current}/{max} participants'**
  String liveParticipants(int current, int max);

  /// No description provided for @livePrivate.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get livePrivate;

  /// No description provided for @livePublic.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get livePublic;

  /// No description provided for @liveEmpty.
  ///
  /// In en, this message translates to:
  /// **'No live rooms available'**
  String get liveEmpty;

  /// No description provided for @authLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get authLoginTitle;

  /// No description provided for @authLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your journey'**
  String get authLoginSubtitle;

  /// No description provided for @authLogoLabel.
  ///
  /// In en, this message translates to:
  /// **'LOGO'**
  String get authLogoLabel;

  /// No description provided for @authContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Continue with'**
  String get authContinueWith;

  /// No description provided for @authTryAnotherLogin.
  ///
  /// In en, this message translates to:
  /// **'Try Another Login Methods'**
  String get authTryAnotherLogin;

  /// No description provided for @authTermsAgreedPrefix.
  ///
  /// In en, this message translates to:
  /// **'I Have Read And Agreed On '**
  String get authTermsAgreedPrefix;

  /// No description provided for @authTermsOfServices.
  ///
  /// In en, this message translates to:
  /// **'Terms Of Services'**
  String get authTermsOfServices;

  /// No description provided for @authTermsAgreedAnd.
  ///
  /// In en, this message translates to:
  /// **' And '**
  String get authTermsAgreedAnd;

  /// No description provided for @authPhoneLoginComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Phone sign-in is coming soon. Use email or social for now.'**
  String get authPhoneLoginComingSoon;

  /// No description provided for @authSignupTitle.
  ///
  /// In en, this message translates to:
  /// **'Join the Stream'**
  String get authSignupTitle;

  /// No description provided for @authSignupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account to start streaming'**
  String get authSignupSubtitle;

  /// No description provided for @authUserRegistrationTitle.
  ///
  /// In en, this message translates to:
  /// **'User Registration'**
  String get authUserRegistrationTitle;

  /// No description provided for @authUserRegistrationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let everyone know you better'**
  String get authUserRegistrationSubtitle;

  /// No description provided for @authNicknameLabel.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get authNicknameLabel;

  /// No description provided for @authNicknameRequired.
  ///
  /// In en, this message translates to:
  /// **'Nickname is required'**
  String get authNicknameRequired;

  /// No description provided for @authDateOfBirthLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get authDateOfBirthLabel;

  /// No description provided for @authDateOfBirthRequired.
  ///
  /// In en, this message translates to:
  /// **'Date of birth is required'**
  String get authDateOfBirthRequired;

  /// No description provided for @authCountryLabel.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get authCountryLabel;

  /// No description provided for @authCountryRequired.
  ///
  /// In en, this message translates to:
  /// **'Country is required'**
  String get authCountryRequired;

  /// No description provided for @authInviterLabel.
  ///
  /// In en, this message translates to:
  /// **'Inviter'**
  String get authInviterLabel;

  /// No description provided for @authInviterDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'* Not to be altered once set'**
  String get authInviterDisclaimer;

  /// No description provided for @authInviterHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the inviter ID (not a required field)'**
  String get authInviterHint;

  /// No description provided for @authMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get authMale;

  /// No description provided for @authFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get authFemale;

  /// No description provided for @authSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get authSave;

  /// No description provided for @authRegistrationFooterNote.
  ///
  /// In en, this message translates to:
  /// **'- Cannot change gender and country after confirming -'**
  String get authRegistrationFooterNote;

  /// No description provided for @authPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get authPhoneLabel;

  /// No description provided for @authPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get authPhoneRequired;

  /// No description provided for @authOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get authOtpTitle;

  /// No description provided for @authOtpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code sent to your phone'**
  String get authOtpSubtitle;

  /// No description provided for @authOtpLabel.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get authOtpLabel;

  /// No description provided for @authOtpHint.
  ///
  /// In en, this message translates to:
  /// **'Enter 6-digit code'**
  String get authOtpHint;

  /// No description provided for @authOtpVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get authOtpVerify;

  /// No description provided for @authOtpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get authOtpResend;

  /// No description provided for @authOtpInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 6-digit code'**
  String get authOtpInvalid;

  /// No description provided for @authOtpSuccess.
  ///
  /// In en, this message translates to:
  /// **'Phone verified successfully. You can sign in now.'**
  String get authOtpSuccess;

  /// No description provided for @authOtpResent.
  ///
  /// In en, this message translates to:
  /// **'A new code has been sent to your phone.'**
  String get authOtpResent;

  /// No description provided for @authForgotPasswordHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send a reset link to your email'**
  String get authForgotPasswordHeaderSubtitle;

  /// No description provided for @authForgotTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get authForgotTitle;

  /// No description provided for @authForgotSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive a reset link'**
  String get authForgotSubtitle;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get authEmailLabel;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'name@company.com'**
  String get authEmailHint;

  /// No description provided for @authEmailSignupHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get authEmailSignupHint;

  /// No description provided for @authEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get authEmailRequired;

  /// No description provided for @authEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get authEmailInvalid;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @authPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get authPasswordHint;

  /// No description provided for @authPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get authPasswordRequired;

  /// No description provided for @authPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get authPasswordMinLength;

  /// No description provided for @authPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get authPasswordMismatch;

  /// No description provided for @authConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get authConfirmPasswordLabel;

  /// No description provided for @authFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get authFullNameLabel;

  /// No description provided for @authFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get authFullNameHint;

  /// No description provided for @authFullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get authFullNameRequired;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get authForgotPassword;

  /// No description provided for @authRememberMe.
  ///
  /// In en, this message translates to:
  /// **'Stay signed in for 30 days'**
  String get authRememberMe;

  /// No description provided for @authSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authSignIn;

  /// No description provided for @authOrConnectWith.
  ///
  /// In en, this message translates to:
  /// **'or connect with'**
  String get authOrConnectWith;

  /// No description provided for @authOrContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get authOrContinueWith;

  /// No description provided for @authNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get authNoAccount;

  /// No description provided for @authHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authHaveAccount;

  /// No description provided for @authCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create one for free'**
  String get authCreateAccount;

  /// No description provided for @authCreateAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get authCreateAccountButton;

  /// No description provided for @authSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get authSupport;

  /// No description provided for @authTermsPrefix.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get authTermsPrefix;

  /// No description provided for @authTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get authTermsOfService;

  /// No description provided for @authTermsAnd.
  ///
  /// In en, this message translates to:
  /// **' and '**
  String get authTermsAnd;

  /// No description provided for @authPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get authPrivacyPolicy;

  /// No description provided for @authTermsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms to continue'**
  String get authTermsRequired;

  /// No description provided for @authInfoTermsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please accept the Terms of Service and Privacy Policy to create your account.'**
  String get authInfoTermsRequired;

  /// No description provided for @authSignupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created. Please sign in.'**
  String get authSignupSuccess;

  /// No description provided for @authSuccessSignup.
  ///
  /// In en, this message translates to:
  /// **'You\'re all set! Your account was created — sign in to start streaming.'**
  String get authSuccessSignup;

  /// No description provided for @authSuccessLogin.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! You\'re signed in.'**
  String get authSuccessLogin;

  /// No description provided for @authSuccessResetSent.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a reset link to your email. Check your inbox.'**
  String get authSuccessResetSent;

  /// No description provided for @authErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again in a moment.'**
  String get authErrorGeneric;

  /// No description provided for @authErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t reach the server. Check your connection and try again.'**
  String get authErrorNetwork;

  /// No description provided for @authErrorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'That email or password doesn\'t look right. Please try again.'**
  String get authErrorInvalidCredentials;

  /// No description provided for @authErrorEmailTaken.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered. Try signing in instead.'**
  String get authErrorEmailTaken;

  /// No description provided for @authSendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get authSendResetLink;

  /// No description provided for @authReturnToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Return to Sign In'**
  String get authReturnToSignIn;

  /// No description provided for @authResetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Reset link sent. Check your email.'**
  String get authResetLinkSent;

  /// No description provided for @homeProfileName.
  ///
  /// In en, this message translates to:
  /// **'Adarsh'**
  String get homeProfileName;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'ID number or nickname'**
  String get homeSearchHint;

  /// No description provided for @homeHallOfFameTitle.
  ///
  /// In en, this message translates to:
  /// **'HALL OF FAME'**
  String get homeHallOfFameTitle;

  /// No description provided for @homeHallOfFameSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Top streamers of the week — vote for your favorite host!'**
  String get homeHallOfFameSubtitle;

  /// No description provided for @homeNavLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get homeNavLive;

  /// No description provided for @homeNavParty.
  ///
  /// In en, this message translates to:
  /// **'Party'**
  String get homeNavParty;

  /// No description provided for @homeNavDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get homeNavDiscover;

  /// No description provided for @homeNavChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get homeNavChat;

  /// No description provided for @homeNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get homeNavProfile;

  /// No description provided for @homeNavGoLive.
  ///
  /// In en, this message translates to:
  /// **'Go Live'**
  String get homeNavGoLive;

  /// No description provided for @homeChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get homeChatTitle;

  /// No description provided for @homeChatSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your messages and conversations'**
  String get homeChatSubtitle;

  /// No description provided for @homeTabFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get homeTabFollowing;

  /// No description provided for @homeTabExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get homeTabExplore;

  /// No description provided for @homeTabNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get homeTabNew;

  /// No description provided for @homeTabNearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get homeTabNearby;

  /// No description provided for @homeTabGlobal.
  ///
  /// In en, this message translates to:
  /// **'Global'**
  String get homeTabGlobal;

  /// No description provided for @homeGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get homeGreetingMorning;

  /// No description provided for @homeGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get homeGreetingAfternoon;

  /// No description provided for @homeGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get homeGreetingEvening;

  /// No description provided for @homePartyTitle.
  ///
  /// In en, this message translates to:
  /// **'Party Rooms'**
  String get homePartyTitle;

  /// No description provided for @homePartySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join voice parties and hang out with friends'**
  String get homePartySubtitle;

  /// No description provided for @homeDiscoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get homeDiscoverTitle;

  /// No description provided for @homeDiscoverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Trending tags and creators for you'**
  String get homeDiscoverSubtitle;

  /// No description provided for @homeProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get homeProfileTitle;

  /// No description provided for @homeProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your account and rewards'**
  String get homeProfileSubtitle;

  /// No description provided for @homeProfileSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get homeProfileSettings;

  /// No description provided for @homeProfileStore.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get homeProfileStore;

  /// No description provided for @homeProfileWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get homeProfileWallet;

  /// No description provided for @homeProfileVip.
  ///
  /// In en, this message translates to:
  /// **'VIP & Guardian'**
  String get homeProfileVip;

  /// No description provided for @homeProfileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get homeProfileLogout;

  /// No description provided for @profileUserId.
  ///
  /// In en, this message translates to:
  /// **'ID: {id}'**
  String profileUserId(String id);

  /// No description provided for @profileFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get profileFriends;

  /// No description provided for @profileCoins.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get profileCoins;

  /// No description provided for @profilePoints.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get profilePoints;

  /// No description provided for @profileTopUp.
  ///
  /// In en, this message translates to:
  /// **'Top Up'**
  String get profileTopUp;

  /// No description provided for @profileWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get profileWithdraw;

  /// No description provided for @profileVipUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to VIP and Enjoy Exclusive Benefits'**
  String get profileVipUpgrade;

  /// No description provided for @profileReward.
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get profileReward;

  /// No description provided for @profileRank.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get profileRank;

  /// No description provided for @profileAuth.
  ///
  /// In en, this message translates to:
  /// **'Auth'**
  String get profileAuth;

  /// No description provided for @profileVipShort.
  ///
  /// In en, this message translates to:
  /// **'VIP'**
  String get profileVipShort;

  /// No description provided for @profileHostRewardsTitle.
  ///
  /// In en, this message translates to:
  /// **'MONTHLY HOST INVITATION REWARDS'**
  String get profileHostRewardsTitle;

  /// No description provided for @profileHostRewardsDate.
  ///
  /// In en, this message translates to:
  /// **'1 JULY - 31 JULY'**
  String get profileHostRewardsDate;

  /// No description provided for @profileInvite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get profileInvite;

  /// No description provided for @profileInviteReward.
  ///
  /// In en, this message translates to:
  /// **'Reward: {amount}/person'**
  String profileInviteReward(String amount);

  /// No description provided for @profileMyAgency.
  ///
  /// In en, this message translates to:
  /// **'My Agency'**
  String get profileMyAgency;

  /// No description provided for @profileActivityCentre.
  ///
  /// In en, this message translates to:
  /// **'Activity Centre'**
  String get profileActivityCentre;

  /// No description provided for @homePartyJoin.
  ///
  /// In en, this message translates to:
  /// **'Join Party'**
  String get homePartyJoin;

  /// No description provided for @homePartyTabHot.
  ///
  /// In en, this message translates to:
  /// **'Hot'**
  String get homePartyTabHot;

  /// No description provided for @homePartyTabNearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get homePartyTabNearby;

  /// No description provided for @homePartyTabFriends.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get homePartyTabFriends;

  /// No description provided for @homePartyTabPrivate.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get homePartyTabPrivate;

  /// No description provided for @homePartyCreate.
  ///
  /// In en, this message translates to:
  /// **'Create Party'**
  String get homePartyCreate;

  /// No description provided for @homePartyThemes.
  ///
  /// In en, this message translates to:
  /// **'Party Themes'**
  String get homePartyThemes;

  /// No description provided for @homePartyFeaturedTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekend Party Night'**
  String get homePartyFeaturedTitle;

  /// No description provided for @homePartyFeaturedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join trending rooms and win bonus coins'**
  String get homePartyFeaturedSubtitle;

  /// No description provided for @homePartyFriendsInParty.
  ///
  /// In en, this message translates to:
  /// **'Friends in Party'**
  String get homePartyFriendsInParty;

  /// No description provided for @homePartyMembersCount.
  ///
  /// In en, this message translates to:
  /// **'{current}/{max}'**
  String homePartyMembersCount(int current, int max);

  /// No description provided for @homePartyEmpty.
  ///
  /// In en, this message translates to:
  /// **'No party rooms in this category yet.'**
  String get homePartyEmpty;

  /// No description provided for @partyVibeChatting.
  ///
  /// In en, this message translates to:
  /// **'Chatting'**
  String get partyVibeChatting;

  /// No description provided for @partyVibeSinging.
  ///
  /// In en, this message translates to:
  /// **'Singing'**
  String get partyVibeSinging;

  /// No description provided for @partyVibeGaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get partyVibeGaming;

  /// No description provided for @partyVibeDancing.
  ///
  /// In en, this message translates to:
  /// **'Dancing'**
  String get partyVibeDancing;

  /// No description provided for @partyVibeComedy.
  ///
  /// In en, this message translates to:
  /// **'Comedy'**
  String get partyVibeComedy;

  /// No description provided for @partyVibeChill.
  ///
  /// In en, this message translates to:
  /// **'Chill'**
  String get partyVibeChill;

  /// No description provided for @homeDiscoverTrending.
  ///
  /// In en, this message translates to:
  /// **'Trending Now'**
  String get homeDiscoverTrending;

  /// No description provided for @homeDiscoverLiveSection.
  ///
  /// In en, this message translates to:
  /// **'Live Screens'**
  String get homeDiscoverLiveSection;

  /// No description provided for @homeDiscoverLiveLayoutsSection.
  ///
  /// In en, this message translates to:
  /// **'Live Room Layouts'**
  String get homeDiscoverLiveLayoutsSection;

  /// No description provided for @homeDiscoverLiveLayoutsHint.
  ///
  /// In en, this message translates to:
  /// **'Multi-seat live UIs — single host, duo PK, and grid rooms.'**
  String get homeDiscoverLiveLayoutsHint;

  /// No description provided for @homeDiscoverRoomsSection.
  ///
  /// In en, this message translates to:
  /// **'Chat Rooms'**
  String get homeDiscoverRoomsSection;

  /// No description provided for @discoverTabSquare.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get discoverTabSquare;

  /// No description provided for @discoverTabVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get discoverTabVideo;

  /// No description provided for @discoverChooseTopic.
  ///
  /// In en, this message translates to:
  /// **'Choose a Topic'**
  String get discoverChooseTopic;

  /// No description provided for @discoverTopicAnniversary.
  ///
  /// In en, this message translates to:
  /// **'#4thAnniversary'**
  String get discoverTopicAnniversary;

  /// No description provided for @discoverTopicBirthday.
  ///
  /// In en, this message translates to:
  /// **'#Birthday'**
  String get discoverTopicBirthday;

  /// No description provided for @discoverTopicHeartbreak.
  ///
  /// In en, this message translates to:
  /// **'#Heartbreak'**
  String get discoverTopicHeartbreak;

  /// No description provided for @discoverTopicTravel.
  ///
  /// In en, this message translates to:
  /// **'#Travel'**
  String get discoverTopicTravel;

  /// No description provided for @discoverPostAuthor.
  ///
  /// In en, this message translates to:
  /// **'Anime Lover'**
  String get discoverPostAuthor;

  /// No description provided for @discoverFollowersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} followers'**
  String discoverFollowersCount(String count);

  /// No description provided for @discoverPostLikes.
  ///
  /// In en, this message translates to:
  /// **'1000'**
  String get discoverPostLikes;

  /// No description provided for @discoverPostComments.
  ///
  /// In en, this message translates to:
  /// **'200'**
  String get discoverPostComments;

  /// No description provided for @discoverPostCaption.
  ///
  /// In en, this message translates to:
  /// **'Love Music #Topics you are...'**
  String get discoverPostCaption;

  /// No description provided for @discoverPostCaptionAlt.
  ///
  /// In en, this message translates to:
  /// **'Weekend vibes #Travel #Music'**
  String get discoverPostCaptionAlt;

  /// No description provided for @homeFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get homeFollowers;

  /// No description provided for @homeFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get homeFollowing;

  /// No description provided for @homeCoins.
  ///
  /// In en, this message translates to:
  /// **'Coins'**
  String get homeCoins;

  /// No description provided for @goLiveHostLabel.
  ///
  /// In en, this message translates to:
  /// **'I am {name}'**
  String goLiveHostLabel(String name);

  /// No description provided for @goLivePreviewHint.
  ///
  /// In en, this message translates to:
  /// **'Better live streaming effect within the continuous room experience.'**
  String get goLivePreviewHint;

  /// No description provided for @goLiveCategoryChatting.
  ///
  /// In en, this message translates to:
  /// **'Chatting'**
  String get goLiveCategoryChatting;

  /// No description provided for @goLiveCategorySinging.
  ///
  /// In en, this message translates to:
  /// **'Singing'**
  String get goLiveCategorySinging;

  /// No description provided for @goLiveCategoryDancing.
  ///
  /// In en, this message translates to:
  /// **'Dancing'**
  String get goLiveCategoryDancing;

  /// No description provided for @goLiveCategoryCrackJokes.
  ///
  /// In en, this message translates to:
  /// **'Crack Jokes'**
  String get goLiveCategoryCrackJokes;

  /// No description provided for @goLiveModeVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get goLiveModeVideo;

  /// No description provided for @goLiveModeVoice.
  ///
  /// In en, this message translates to:
  /// **'Voice'**
  String get goLiveModeVoice;

  /// No description provided for @goLiveStartVideoRoom.
  ///
  /// In en, this message translates to:
  /// **'Start a Video Room'**
  String get goLiveStartVideoRoom;

  /// No description provided for @goLiveStartVoiceRoom.
  ///
  /// In en, this message translates to:
  /// **'Start a Voice Room'**
  String get goLiveStartVoiceRoom;

  /// No description provided for @goLiveStartParty.
  ///
  /// In en, this message translates to:
  /// **'Start a Party Room'**
  String get goLiveStartParty;

  /// No description provided for @goLiveSessionLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get goLiveSessionLive;

  /// No description provided for @goLiveSessionParty.
  ///
  /// In en, this message translates to:
  /// **'Party'**
  String get goLiveSessionParty;

  /// No description provided for @liveLayoutSingle.
  ///
  /// In en, this message translates to:
  /// **'Single Live'**
  String get liveLayoutSingle;

  /// No description provided for @liveLayout2.
  ///
  /// In en, this message translates to:
  /// **'2 Person Live'**
  String get liveLayout2;

  /// No description provided for @liveLayout3.
  ///
  /// In en, this message translates to:
  /// **'3 Seat Live'**
  String get liveLayout3;

  /// No description provided for @liveLayout4.
  ///
  /// In en, this message translates to:
  /// **'4 Seat Live'**
  String get liveLayout4;

  /// No description provided for @liveLayout8.
  ///
  /// In en, this message translates to:
  /// **'8 Seat Live'**
  String get liveLayout8;

  /// No description provided for @liveLayout10.
  ///
  /// In en, this message translates to:
  /// **'10 Seat Live'**
  String get liveLayout10;

  /// No description provided for @liveLayout12.
  ///
  /// In en, this message translates to:
  /// **'12 Seat Live'**
  String get liveLayout12;

  /// No description provided for @liveLayout16.
  ///
  /// In en, this message translates to:
  /// **'16 Seat Live'**
  String get liveLayout16;

  /// No description provided for @liveLayout18.
  ///
  /// In en, this message translates to:
  /// **'18 Seat Live'**
  String get liveLayout18;

  /// No description provided for @liveLayout20.
  ///
  /// In en, this message translates to:
  /// **'20 Seat Live'**
  String get liveLayout20;

  /// No description provided for @liveLayoutLudo.
  ///
  /// In en, this message translates to:
  /// **'Ludo Live'**
  String get liveLayoutLudo;

  /// No description provided for @liveLayoutSeatCount.
  ///
  /// In en, this message translates to:
  /// **'{count} seats'**
  String liveLayoutSeatCount(int count);

  /// No description provided for @liveScreenVideo.
  ///
  /// In en, this message translates to:
  /// **'Video Live'**
  String get liveScreenVideo;

  /// No description provided for @liveScreenAudio.
  ///
  /// In en, this message translates to:
  /// **'Audio Preview'**
  String get liveScreenAudio;

  /// No description provided for @liveScreenParty.
  ///
  /// In en, this message translates to:
  /// **'Review Party'**
  String get liveScreenParty;

  /// No description provided for @liveScreenBattle.
  ///
  /// In en, this message translates to:
  /// **'Live Battle'**
  String get liveScreenBattle;

  /// No description provided for @liveScreenPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview Window'**
  String get liveScreenPreview;

  /// No description provided for @liveScreenDashboard.
  ///
  /// In en, this message translates to:
  /// **'Live Dashboard'**
  String get liveScreenDashboard;

  /// No description provided for @reelsTabFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get reelsTabFollowing;

  /// No description provided for @reelsTabForYou.
  ///
  /// In en, this message translates to:
  /// **'For You'**
  String get reelsTabForYou;

  /// No description provided for @reelsFollow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get reelsFollow;

  /// No description provided for @reelsFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get reelsFollowing;

  /// No description provided for @reelsCommentOpened.
  ///
  /// In en, this message translates to:
  /// **'Comments opened'**
  String get reelsCommentOpened;

  /// No description provided for @reelsShared.
  ///
  /// In en, this message translates to:
  /// **'Shared'**
  String get reelsShared;

  /// No description provided for @reelsCommentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get reelsCommentsTitle;

  /// No description provided for @reelsCommentsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No comments yet. Be the first!'**
  String get reelsCommentsEmpty;

  /// No description provided for @reelsCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Add a comment...'**
  String get reelsCommentHint;

  /// No description provided for @reelsCommentPost.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get reelsCommentPost;

  /// No description provided for @liveRoomJoined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get liveRoomJoined;

  /// No description provided for @liveRoomTapToLike.
  ///
  /// In en, this message translates to:
  /// **'Tap tap to send likes'**
  String get liveRoomTapToLike;

  /// No description provided for @liveRoomGiftsTitle.
  ///
  /// In en, this message translates to:
  /// **'Send Gifts'**
  String get liveRoomGiftsTitle;

  /// No description provided for @liveRoomSendGift.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get liveRoomSendGift;

  /// No description provided for @liveRoomCoinsBalance.
  ///
  /// In en, this message translates to:
  /// **'{balance} coins'**
  String liveRoomCoinsBalance(String balance);

  /// No description provided for @liveRoomCommentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Live Comments'**
  String get liveRoomCommentsTitle;

  /// No description provided for @liveRoomCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Say something...'**
  String get liveRoomCommentHint;

  /// No description provided for @liveRoomShared.
  ///
  /// In en, this message translates to:
  /// **'Room link shared'**
  String get liveRoomShared;

  /// No description provided for @liveRoomShare.
  ///
  /// In en, this message translates to:
  /// **'Share room'**
  String get liveRoomShare;

  /// No description provided for @liveRoomViewers.
  ///
  /// In en, this message translates to:
  /// **'Viewers'**
  String get liveRoomViewers;

  /// No description provided for @liveRoomPickSeat.
  ///
  /// In en, this message translates to:
  /// **'Pick a seat to join'**
  String get liveRoomPickSeat;

  /// No description provided for @liveRoomSeat.
  ///
  /// In en, this message translates to:
  /// **'Seat'**
  String get liveRoomSeat;

  /// No description provided for @reelsFormatCount.
  ///
  /// In en, this message translates to:
  /// **'{count}'**
  String reelsFormatCount(String count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
