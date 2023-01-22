import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItems2 extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  const VideoItems2({required this.videoPlayerController, super.key});

  @override
  VideoItemsState createState() => VideoItemsState();
}

class VideoItemsState extends State<VideoItems2> {
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      customControls: const MaterialControls(),
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      fullScreenByDefault: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 3, 31, 71),
      body: Chewie(
        controller: _chewieController!,
      ),
    );
  }
}
