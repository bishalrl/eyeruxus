import 'package:eye_rex_us/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_state.dart';
import 'package:eye_rex_us/features/auth/presentation/pages/login_page.dart';
import 'package:eye_rex_us/features/home/presentation/pages/main_dash_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shows [LoginPage] until authenticated, then the main app shell.
class AuthGatePage extends StatelessWidget {
  const AuthGatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return const MainDashboardPage();
        }
        return const LoginPage();
      },
    );
  }
}
