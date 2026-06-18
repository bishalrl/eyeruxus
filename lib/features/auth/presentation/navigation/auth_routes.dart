import 'package:eye_rex_us/app/router/app_route_args.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:flutter/material.dart';

abstract final class AuthRoutes {
  static void openOtp(BuildContext context, {String? phoneNumber}) {
    AppRouter.pushNamed(
      context,
      AppRouteNames.otp,
      arguments: OtpRouteArgs(phoneNumber: phoneNumber),
    );
  }

  static void openForgotPassword(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.forgotPassword);
  }

  static void openSignup(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.signup);
  }

  static void openLogin(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.login);
  }

  static void replaceWithLogin(BuildContext context) {
    AppRouter.pushReplacementNamed(context, AppRouteNames.login);
  }
}
