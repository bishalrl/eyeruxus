/// Abstraction for real-time audio/video. Swap with Agora, Zego, or WebRTC.
abstract class LiveMediaEngine {
  Future<void> initialize({required String roomId});

  Future<void> setCameraEnabled(bool enabled);

  Future<void> setMicrophoneEnabled(bool enabled);

  Future<void> setSpeakerEnabled(bool enabled);

  Future<void> switchCamera();

  Future<void> setBeautyFilterEnabled(bool enabled);

  Future<void> setBackgroundBlurEnabled(bool enabled);

  Future<void> startScreenShare();

  Future<void> stopScreenShare();

  Future<void> recoverStream();

  Future<void> dispose();
}

class MockLiveMediaEngine implements LiveMediaEngine {
  bool _initialized = false;

  @override
  Future<void> initialize({required String roomId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    _initialized = true;
  }

  @override
  Future<void> setCameraEnabled(bool enabled) async {}

  @override
  Future<void> setMicrophoneEnabled(bool enabled) async {}

  @override
  Future<void> setSpeakerEnabled(bool enabled) async {}

  @override
  Future<void> switchCamera() async {}

  @override
  Future<void> setBeautyFilterEnabled(bool enabled) async {}

  @override
  Future<void> setBackgroundBlurEnabled(bool enabled) async {}

  @override
  Future<void> startScreenShare() async {}

  @override
  Future<void> stopScreenShare() async {}

  @override
  Future<void> recoverStream() async {
    if (!_initialized) {
      await Future<void>.delayed(const Duration(milliseconds: 200));
      _initialized = true;
    }
  }

  @override
  Future<void> dispose() async {
    _initialized = false;
  }
}
