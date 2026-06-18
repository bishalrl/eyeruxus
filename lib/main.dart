import 'package:eye_rex_us/app/app.dart';
import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/core/config/load_env.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  await configureDependencies();
  runApp(const EyeRexApp());
}
