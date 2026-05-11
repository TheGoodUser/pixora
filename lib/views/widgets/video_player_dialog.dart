import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPopup extends StatefulWidget {
  final String videoUrl;
  final String? title;

  const VideoPopup({
    super.key,
    required this.videoUrl,
    this.title,
  });

  @override
  State<VideoPopup> createState() => _VideoPopupState();
}

class _VideoPopupState extends State<VideoPopup> {
  late VideoPlayerController _controller;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _hideControlsAfterDelay();
      });
  }

  void _hideControlsAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _controller.value.isPlaying) {
        setState(() => _showControls = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 5,
            )
          ],
        ),
        child: _controller.value.isInitialized
            ? GestureDetector(
                onTap: () {
                  setState(() => _showControls = !_showControls);
                  if (_showControls) _hideControlsAfterDelay();
                },
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_controller),

                      // Gradient Overlay
                      AnimatedOpacity(
                        opacity: _showControls ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Top Bar
                      if (_showControls)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.title ?? 'Preview',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.close_rounded,
                                      color: Colors.white),
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.white24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Center Play/Pause
                      if (_showControls)
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause_circle_filled_rounded
                                : Icons.play_circle_filled_rounded,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),

                      // Bottom Progress
                      if (_showControls)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              colors: const VideoProgressColors(
                                playedColor: Colors.white,
                                bufferedColor: Colors.white24,
                                backgroundColor: Colors.white12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            : const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
      ),
    );
  }
}
