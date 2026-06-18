import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loadEnv() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // .env is optional; [EnvConfig] supplies defaults when missing.
  }
}
