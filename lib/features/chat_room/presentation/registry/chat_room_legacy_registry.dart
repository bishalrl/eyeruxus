import 'package:eye_rex_us/UI/Screens/HomeScreen/HomeScreen.dart';
import 'package:eye_rex_us/UI/Screens/HomeScreen/HomeScreen10.dart';
import 'package:eye_rex_us/UI/Screens/HomeScreen/HomeScreen11.dart';
import 'package:eye_rex_us/UI/Screens/HomeScreen/HomeScreen2.dart';
import 'package:eye_rex_us/UI/Screens/HomeScreen/HomeScreen3.dart';
import 'package:eye_rex_us/UI/Screens/HomeScreen/HomeScreen4.dart';
import 'package:eye_rex_us/UI/Screens/HomeScreen/HomeScreen5.dart';
import 'package:eye_rex_us/UI/Screens/HomeScreen/HomeScreen6.dart';
import 'package:eye_rex_us/UI/Screens/HomeScreen/HomeScreen7.dart';
import 'package:eye_rex_us/UI/Screens/HomeScreen/HomeScreen8.dart';
import 'package:eye_rex_us/UI/Screens/HomeScreen/HomeScreen9.dart';
import 'package:flutter/material.dart';

typedef ChatRoomLegacyBuilder = Widget Function();

/// Single source of truth for roomId → legacy HomeScreen widget mapping.
abstract final class ChatRoomLegacyRegistry {
  static const _builders = <String, ChatRoomLegacyBuilder>{
    'movie': _movie,
    'pk': _pk,
    'room_3': _room3,
    'room_4': _room4,
    'room_8': _room8,
    'room_10': _room10,
    'room_12': _room12,
    'room_16': _room16,
    'room_18': _room18,
    'room_20': _room20,
    'room_ludo': _ludo,
  };

  static Widget build(String roomId) {
    final builder = _builders[roomId];
    if (builder == null) {
      throw ArgumentError.value(roomId, 'roomId', 'Unknown chat room layout');
    }
    return builder();
  }

  static bool contains(String roomId) => _builders.containsKey(roomId);

  static Widget _movie() => LiveRoomScreen();
  static Widget _pk() => HomeScreen10();
  static Widget _room3() => HomeScreen7();
  static Widget _room4() => HomeScreen5();
  static Widget _room8() => HomeScreen2();
  static Widget _room10() => HomeScreen6();
  static Widget _room12() => HomeScreen4();
  static Widget _room16() => HomeScreen3();
  static Widget _room18() => HomeScreen9();
  static Widget _room20() => HomeScreen8();
  static Widget _ludo() => HomeScreen11();
}
