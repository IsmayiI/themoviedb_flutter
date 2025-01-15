import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MovieTrailerWidget extends StatefulWidget {
  final String youTubeKey;

  const MovieTrailerWidget({super.key, required this.youTubeKey});

  @override
  State<MovieTrailerWidget> createState() => _MovieTrailerWidgetState();
}

class _MovieTrailerWidgetState extends State<MovieTrailerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.youTubeKey,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        enableCaption: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      aspectRatio: 16 / 9,
      controller: _controller,
      builder: (context, player) {
        return Center(child: player);
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
