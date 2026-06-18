import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/network/dio_client.dart';
import '../../features/agency/data/datasources/agency_local_datasource.dart';
import '../../features/agency/data/datasources/agency_remote_datasource.dart';
import '../../features/agency/data/repositories/agency_repository_impl.dart';
import '../../features/agency/domain/repositories/agency_repository.dart';
import '../../features/agency/domain/usecases/get_host_application_usecase.dart';
import '../../features/agency/presentation/bloc/agency_bloc.dart';
import '../../features/agency/presentation/bloc/agency_tab_cubit.dart';
import '../../features/host_money/data/datasources/host_money_local_datasource.dart';
import '../../features/host_money/data/repositories/host_money_repository_impl.dart';
import '../../features/host_money/domain/repositories/host_money_repository.dart';
import '../../features/host_money/domain/usecases/host_money_usecases.dart';
import '../../features/host_money/presentation/bloc/host_money_feature_cubits.dart';
import '../../features/host_money/presentation/bloc/make_money_cubit.dart';
import '../../features/chat_room/data/datasources/chat_room_local_datasource.dart';
import '../../features/chat_room/data/repositories/chat_room_repository_impl.dart';
import '../../features/chat_room/domain/repositories/chat_room_repository.dart';
import '../../features/chat_room/domain/usecases/get_chat_room_config_usecase.dart';
import '../../features/chat_room/presentation/bloc/chat_room_bloc.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_feedback_cubit.dart';
import '../../features/auth/presentation/bloc/forgot_password_form_cubit.dart';
import '../../features/auth/presentation/bloc/login_form_cubit.dart';
import '../../features/auth/presentation/bloc/signup_form_cubit.dart';
import '../../features/dev_tools/data/datasources/dev_tools_local_datasource.dart';
import '../../features/dev_tools/data/repositories/dev_tools_repository_impl.dart';
import '../../features/dev_tools/domain/repositories/dev_tools_repository.dart';
import '../../features/dev_tools/domain/usecases/get_dev_routes_usecase.dart';
import '../../features/dev_tools/presentation/bloc/dev_tools_bloc.dart';
import '../../features/home/data/datasources/home_local_datasource.dart';
import '../../features/home/data/datasources/party_local_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/data/repositories/party_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/repositories/party_repository.dart';
import '../../features/home/domain/usecases/get_home_feed_usecase.dart';
import '../../features/home/domain/usecases/get_party_feed_usecase.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/home/presentation/bloc/discover_cubit.dart';
import '../../features/home/presentation/bloc/main_dashboard_cubit.dart';
import '../../features/home/presentation/bloc/party_bloc.dart';
import '../../features/home/presentation/bloc/profile_page_cubit.dart';
import '../../features/home/presentation/bloc/reels_bloc.dart';
import '../../features/guardian_vip/data/datasources/guardian_vip_local_datasource.dart';
import '../../features/guardian_vip/data/repositories/guardian_vip_repository_impl.dart';
import '../../features/guardian_vip/domain/repositories/guardian_vip_repository.dart';
import '../../features/guardian_vip/domain/usecases/get_vip_tiers_usecase.dart';
import '../../features/guardian_vip/presentation/bloc/guardian_vip_bloc.dart';
import '../../features/guardian_vip/presentation/bloc/guardian_vip_tab_cubit.dart';
import '../../features/live/data/datasources/live_session_local_datasource.dart';
import '../../features/live/data/repositories/live_platform_repository_impl.dart';
import '../../features/live/data/repositories/live_session_repository_impl.dart';
import '../../features/live/data/services/live_economy_service.dart';
import '../../features/live/data/services/live_realtime_sync_service.dart';
import '../../features/live/domain/repositories/live_platform_repository.dart';
import '../../features/live/domain/repositories/live_session_repository.dart';
import '../../features/live/presentation/bloc/live_discovery_cubit.dart';
import '../../features/live/presentation/services/live_permissions_service.dart';
import '../../features/live/data/datasources/live_local_datasource.dart';
import '../../features/live/data/datasources/live_remote_datasource.dart';
import '../../features/live/data/repositories/live_repository_impl.dart';
import '../../features/live/domain/repositories/live_repository.dart';
import '../../features/live/domain/usecases/create_live_session_usecase.dart';
import '../../features/live/domain/usecases/get_live_rooms_usecase.dart';
import '../../features/live/domain/usecases/join_live_session_usecase.dart';
import '../../features/live/presentation/bloc/live_bloc.dart';
import '../../features/live/presentation/bloc/go_live_setup_cubit.dart';
import '../../features/live/presentation/bloc/live_media_cubit.dart';
import '../../features/settings/data/datasources/settings_local_datasource.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/get_settings_usecase.dart';
import '../../features/settings/domain/usecases/update_settings_usecase.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';
import '../../features/store/data/datasources/store_local_datasource.dart';
import '../../features/store/data/repositories/store_repository_impl.dart';
import '../../features/store/domain/repositories/store_repository.dart';
import '../../features/store/domain/usecases/get_store_products_usecase.dart';
import '../../features/store/presentation/bloc/store_bloc.dart';
import '../../features/user/data/datasources/user_remote_datasource.dart';
import '../../features/user/data/repositories/user_repository_impl.dart';
import '../../features/user/domain/repositories/user_repository.dart';
import '../../features/user/presentation/bloc/user_bloc.dart';
import 'package:eye_rex_us/features/wallet/data/datasources/wallet_operations_local_datasource.dart';
import 'package:eye_rex_us/features/wallet/data/repositories/wallet_operations_repository_impl.dart';
import 'package:eye_rex_us/features/wallet/domain/repositories/wallet_operations_repository.dart';
import 'package:eye_rex_us/features/wallet/domain/usecases/wallet_operations_usecases.dart';
import 'package:eye_rex_us/features/wallet/presentation/bloc/wallet_operations_cubits.dart';
import '../../features/wallet/data/datasources/wallet_local_datasource.dart';
import '../../features/wallet/data/datasources/wallet_remote_datasource.dart';
import '../../features/wallet/data/repositories/wallet_repository_impl.dart';
import '../../features/wallet/domain/repositories/wallet_repository.dart';
import '../../features/wallet/domain/usecases/get_wallet_balance_usecase.dart';
import '../../features/wallet/presentation/bloc/wallet_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  if (sl.isRegistered<DioClient>()) return;

  sl.registerLazySingleton(NavigationService.new);
  sl.registerLazySingleton(DioClient.new);

  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(AuthLocalDataSourceImpl.new);
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
      forgotPasswordUseCase: sl(),
    ),
  );
  sl.registerFactory(AuthFeedbackCubit.new);
  sl.registerFactory(LoginFormCubit.new);
  sl.registerFactory(SignupFormCubit.new);
  sl.registerFactory(ForgotPasswordFormCubit.new);

  // User
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerFactory(() => UserBloc(sl()));

  // Chat room
  sl.registerLazySingleton<ChatRoomLocalDataSource>(
    ChatRoomLocalDataSourceImpl.new,
  );
  sl.registerLazySingleton<ChatRoomRepository>(
    () => ChatRoomRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetChatRoomConfigUseCase(sl()));
  sl.registerFactory(() => ChatRoomBloc(getChatRoomConfigUseCase: sl()));

  // Live
  sl.registerLazySingleton<LiveRemoteDataSource>(
    () => LiveRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<LiveLocalDataSource>(LiveLocalDataSourceImpl.new);
  sl.registerLazySingleton<LiveRepository>(
    () => LiveRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => GetLiveRoomsUseCase(sl()));
  sl.registerLazySingleton(() => CreateLiveSessionUseCase(sl()));
  sl.registerLazySingleton(() => JoinLiveSessionUseCase(sl()));
  sl.registerFactory(() => LiveBloc(getLiveRoomsUseCase: sl()));
  sl.registerLazySingleton<LiveSessionLocalDataSource>(
    LiveSessionLocalDataSourceImpl.new,
  );
  sl.registerLazySingleton<LiveRealtimeSyncService>(
    () => LiveRealtimeSyncService.instance,
  );
  sl.registerLazySingleton<LiveEconomyService>(LiveEconomyService.new);
  sl.registerLazySingleton<LiveSessionRepository>(
    () => LiveSessionRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<LivePlatformRepository>(
    () => LivePlatformRepositoryImpl(sl(), sl(), sl(), sl()),
  );
  sl.registerLazySingleton<LivePermissionsService>(
    LivePermissionsServiceImpl.new,
  );
  sl.registerFactory(() => LiveDiscoveryCubit(sl()));

  // Store
  sl.registerLazySingleton<StoreLocalDataSource>(StoreLocalDataSourceImpl.new);
  sl.registerLazySingleton<StoreRepository>(() => StoreRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetStoreProductsUseCase(sl()));
  sl.registerFactory(() => StoreBloc(getStoreProductsUseCase: sl()));

  // Wallet
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<WalletLocalDataSource>(WalletLocalDataSourceImpl.new);
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => GetWalletBalanceUseCase(sl()));
  sl.registerFactory(() => WalletBloc(getWalletBalanceUseCase: sl()));

  sl.registerLazySingleton<WalletOperationsLocalDataSourceImpl>(
    WalletOperationsLocalDataSourceImpl.new,
  );
  sl.registerLazySingleton<WalletOperationsRepository>(
    () => WalletOperationsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => WalletOperationsUseCases(sl()));
  sl.registerFactory(() => PointsShopCubit(sl()));
  sl.registerFactory(() => ExchangeCoinsCubit(sl()));
  sl.registerFactory(() => TransferCoinsCubit(sl()));
  sl.registerFactory(() => BankDetailsCubit(sl()));
  sl.registerFactory(() => PaymentMethodsCubit(sl()));
  sl.registerFactory(() => InviteCubit(sl()));
  sl.registerFactory(() => FriendsCubit(sl()));
  sl.registerFactory(() => MyAgencyCubit(sl()));

  // Settings
  sl.registerLazySingleton<SettingsLocalDataSource>(
    SettingsLocalDataSourceImpl.new,
  );
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetSettingsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateSettingsUseCase(sl()));
  sl.registerFactory(
    () => SettingsBloc(
      getSettingsUseCase: sl(),
      updateSettingsUseCase: sl(),
    ),
  );

  // Guardian / VIP
  sl.registerLazySingleton<GuardianVipLocalDataSource>(
    GuardianVipLocalDataSourceImpl.new,
  );
  sl.registerLazySingleton<GuardianVipRepository>(
    () => GuardianVipRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetVipTiersUseCase(sl()));
  sl.registerFactory(() => GuardianVipBloc(getVipTiersUseCase: sl()));
  sl.registerFactory(GuardianVipTabCubit.new);

  // Agency
  sl.registerLazySingleton<AgencyRemoteDataSource>(
    () => AgencyRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<AgencyLocalDataSource>(AgencyLocalDataSourceImpl.new);
  sl.registerLazySingleton<AgencyRepository>(
    () => AgencyRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => GetHostApplicationUseCase(sl()));
  sl.registerFactory(() => AgencyBloc(getHostApplicationUseCase: sl()));
  sl.registerFactory(AgencyTabCubit.new);

  // Host money / Make money
  sl.registerLazySingleton<HostMoneyLocalDataSource>(
    HostMoneyLocalDataSourceImpl.new,
  );
  sl.registerLazySingleton<HostMoneyRepository>(
    () => HostMoneyRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetMakeMoneyDashboardUseCase(sl()));
  sl.registerLazySingleton(() => GetHostManagementUseCase(sl()));
  sl.registerLazySingleton(() => GetLiveDataUseCase(sl()));
  sl.registerLazySingleton(() => GetRankingUseCase(sl()));
  sl.registerLazySingleton(() => GetHostRewardsUseCase(sl()));
  sl.registerLazySingleton(() => GetCoinsTradingUseCase(sl()));
  sl.registerLazySingleton(() => InviteHostUseCase(sl()));
  sl.registerLazySingleton(() => InviteAgentUseCase(sl()));
  sl.registerLazySingleton(() => PurchaseCoinsTradeUseCase(sl()));
  sl.registerLazySingleton(() => ClaimHostRewardUseCase(sl()));
  sl.registerFactory(
    () => MakeMoneyCubit(
      getDashboard: sl(),
      getManagement: sl(),
      getLiveData: sl(),
    ),
  );
  sl.registerFactory(() => RankingCubit(sl()));
  sl.registerFactory(
    () => RewardsCubit(getRewards: sl(), claimReward: sl()),
  );
  sl.registerFactory(
    () => CoinsTradingCubit(getOffers: sl(), purchase: sl()),
  );
  sl.registerFactory(() => AddHostCubit(sl()));
  sl.registerFactory(() => InviteAgentCubit(sl()));

  // Home
  sl.registerLazySingleton<PartyLocalDataSource>(PartyLocalDataSourceImpl.new);
  sl.registerLazySingleton<PartyRepository>(() => PartyRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetPartyFeedUseCase(sl()));
  sl.registerLazySingleton<HomeLocalDataSource>(HomeLocalDataSourceImpl.new);
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetHomeFeedUseCase(sl()));
  sl.registerFactory(() => HomeBloc(getHomeFeedUseCase: sl()));
  sl.registerFactory(() => PartyBloc(getPartyFeedUseCase: sl()));
  sl.registerFactory(MainDashboardCubit.new);
  sl.registerFactory(DiscoverCubit.new);
  sl.registerFactory(ProfilePageCubit.new);
  sl.registerFactory(ReelsBloc.new);
  sl.registerFactory(GoLiveSetupCubit.new);
  sl.registerFactory(() => LiveMediaCubit(sl()));

  // Dev tools
  sl.registerLazySingleton<DevToolsLocalDataSource>(
    DevToolsLocalDataSourceImpl.new,
  );
  sl.registerLazySingleton<DevToolsRepository>(
    () => DevToolsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetDevRoutesUseCase(sl()));
  sl.registerFactory(() => DevToolsBloc(getDevRoutesUseCase: sl()));
}
