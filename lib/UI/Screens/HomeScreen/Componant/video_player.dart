import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CompactVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final double height;

  const CompactVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.height,
  });

  @override
  State<CompactVideoPlayer> createState() => _CompactVideoPlayerState();
}

class _CompactVideoPlayerState extends State<CompactVideoPlayer> {
  VideoPlayerController? _controller;
  bool _initialized = false;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
      await controller.initialize();
      if (!mounted) {
        controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _initialized = true;
      });
    } catch (_) {
      if (mounted) {
        setState(() => _failed = true);
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: widget.height,
        width: double.infinity,
        color: Colors.black26,
        child: _failed
            ? const Center(
                child: Icon(Icons.play_circle_outline,
                    color: Colors.white, size: 48),
              )
            : !_initialized
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _controller!.value.size.width,
                            height: _controller!.value.size.height,
                            child: VideoPlayer(_controller!),
                          ),
                        ),
                      ),
                      if (!_controller!.value.isPlaying)
                        IconButton(
                          icon: const Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 48,
                          ),
                          onPressed: () => _controller!.play(),
                        ),
                    ],
                  ),
      ),
    );
  }
}
