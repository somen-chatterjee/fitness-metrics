import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const YoutubeVideoPlayer({super.key, required this.videoUrl});

  @override
  State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        forceHD: true,
      ),
    );

    // Add a listener to track full-screen changes
    _controller.addListener(_onPlayerStateChanged);
  }

  void _onPlayerStateChanged() {
    final playerState = _controller.value.playerState;

    if (playerState == PlayerState.ended) {
      // Optionally, restart the video after some delay
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _controller.seekTo(const Duration(seconds: 0));  // Restart the video
          _controller.pause();
        });
      });
    }

    if (_controller.value.isFullScreen != _isFullScreen) {
      setState(() {
        _isFullScreen = _controller.value.isFullScreen;
      });
      if (!_isFullScreen) {
        // Actions when exiting full-screen mode (optional)
        _restoreSystemUI();
      }
    }
  }

  void _restoreSystemUI() {
    // Make the status bar and navigation bar visible
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  @override
  void dispose() {
    _controller.removeListener(_onPlayerStateChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            width: MediaQuery.of(context).size.width,
            aspectRatio: 16 / 9,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.transparent,
            onReady: () {
              log('Player is ready.');
            },
          ),
          builder: (context, player) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Place the player widget
                player,
                // Add other widgets you may need
              ],
            );
          },
        ),
      ],
    );
  }
}
