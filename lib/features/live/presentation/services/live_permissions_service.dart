import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

enum LivePermissionType { camera, microphone, photos, notifications, bluetooth }

class LivePermissionStatus {
  const LivePermissionStatus({
    required this.granted,
    required this.denied,
    required this.permanentlyDenied,
  });

  final bool granted;
  final bool denied;
  final bool permanentlyDenied;
}

abstract class LivePermissionsService {
  Future<LivePermissionStatus> check(LivePermissionType type);

  Future<LivePermissionStatus> request(LivePermissionType type);

  Future<Map<LivePermissionType, LivePermissionStatus>> requestLiveKit();

  Future<Map<LivePermissionType, LivePermissionStatus>> requestBroadcastPermissions();

  Future<void> openSettings();
}

class LivePermissionsServiceImpl implements LivePermissionsService {
  Permission _map(LivePermissionType type) {
    return switch (type) {
      LivePermissionType.camera => Permission.camera,
      LivePermissionType.microphone => Permission.microphone,
      LivePermissionType.photos => Permission.photos,
      LivePermissionType.notifications => Permission.notification,
      LivePermissionType.bluetooth => Permission.bluetoothConnect,
    };
  }

  /// Permissions required before starting a video live broadcast.
  static const broadcastTypes = [
    LivePermissionType.camera,
    LivePermissionType.microphone,
    LivePermissionType.photos,
  ];

  LivePermissionStatus _fromPermissionStatus(PermissionStatus status) {
    return LivePermissionStatus(
      granted: status.isGranted || status.isLimited,
      denied: status.isDenied,
      permanentlyDenied: status.isPermanentlyDenied,
    );
  }

  @override
  Future<LivePermissionStatus> check(LivePermissionType type) async {
    if (kIsWeb) {
      return const LivePermissionStatus(granted: true, denied: false, permanentlyDenied: false);
    }
    if (type == LivePermissionType.photos) {
      return _checkPhotos();
    }
    final status = await _map(type).status;
    return _fromPermissionStatus(status);
  }

  @override
  Future<LivePermissionStatus> request(LivePermissionType type) async {
    if (kIsWeb) {
      return const LivePermissionStatus(granted: true, denied: false, permanentlyDenied: false);
    }
    if (type == LivePermissionType.photos) {
      return _requestPhotos();
    }
    final status = await _map(type).request();
    return _fromPermissionStatus(status);
  }

  Future<LivePermissionStatus> _requestPhotos() async {
    var status = await Permission.photos.request();
    if (status.isGranted || status.isPermanentlyDenied) {
      return _fromPermissionStatus(status);
    }
    if (!kIsWeb && Platform.isAndroid) {
      status = await Permission.storage.request();
    }
    return _fromPermissionStatus(status);
  }

  Future<LivePermissionStatus> _checkPhotos() async {
    var status = await Permission.photos.status;
    if (status.isGranted || status.isPermanentlyDenied) {
      return _fromPermissionStatus(status);
    }
    if (!kIsWeb && Platform.isAndroid) {
      status = await Permission.storage.status;
    }
    return _fromPermissionStatus(status);
  }

  @override
  Future<Map<LivePermissionType, LivePermissionStatus>> requestBroadcastPermissions() async {
    final results = <LivePermissionType, LivePermissionStatus>{};
    for (final type in LivePermissionsServiceImpl.broadcastTypes) {
      results[type] = await request(type);
    }
    return results;
  }

  @override
  Future<Map<LivePermissionType, LivePermissionStatus>> requestLiveKit() async {
    final types = [
      ...LivePermissionsServiceImpl.broadcastTypes,
      LivePermissionType.notifications,
    ];
    final results = <LivePermissionType, LivePermissionStatus>{};
    for (final type in types) {
      results[type] = await request(type);
    }
    return results;
  }

  @override
  Future<void> openSettings() => openAppSettings();
}
