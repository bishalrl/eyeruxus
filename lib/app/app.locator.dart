export 'di/injection.dart' show configureDependencies, sl;

import 'di/injection.dart';

final locator = sl;

Future<void> setupLocator() => configureDependencies();
