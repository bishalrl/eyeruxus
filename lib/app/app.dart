import 'package:eye_rex_us/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theme/app_theme.dart';
import '../features/agency/presentation/bloc/agency_bloc.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/dev_tools/presentation/bloc/dev_tools_bloc.dart';
import '../features/guardian_vip/presentation/bloc/guardian_vip_bloc.dart';
import '../features/settings/presentation/bloc/settings_bloc.dart';
import '../features/store/presentation/bloc/store_bloc.dart';
import '../features/user/presentation/bloc/user_bloc.dart';
import '../features/wallet/presentation/bloc/wallet_bloc.dart';
import 'di/injection.dart';
import 'router/app_route_names.dart';
import 'router/app_router.dart';

class EyeRexApp extends StatelessWidget {
  const EyeRexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<UserBloc>()),
        BlocProvider(create: (_) => sl<StoreBloc>()),
        BlocProvider(create: (_) => sl<WalletBloc>()),
        BlocProvider(create: (_) => sl<SettingsBloc>()),
        BlocProvider(create: (_) => sl<GuardianVipBloc>()),
        BlocProvider(create: (_) => sl<AgencyBloc>()),
        BlocProvider(
          create: (_) => sl<DevToolsBloc>()..add(const DevRoutesRequested()),
        ),
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(360, 690),
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Eye Rex',
            debugShowCheckedModeBanner: false,
            navigatorKey: AppRouter.navigatorKey,
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: AppRouteNames.authGate,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: ThemeMode.system,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
          );
        },
      ),
    );
  }
}
