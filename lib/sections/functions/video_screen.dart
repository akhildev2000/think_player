import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
//import 'package:VideoItems/VideoItems.dart';
import 'package:video_player/video_player.dart';

// class VideoItems extends StatefulWidget {
//   final VideoPlayerController videoPlayerController;

//   const VideoItems({required this.videoPlayerController, super.key});

//   @override
//   VideoItemsState createState() => VideoItemsState();
// }

// class VideoItemsState extends State<VideoItems> {
//   ChewieController? _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     _chewieController = ChewieController(
//       videoPlayerController: widget.videoPlayerController,
//       customControls: const MaterialControls(),
//       autoInitialize: true,
//       autoPlay: true,
//       looping: true,
//       fullScreenByDefault: true,
//       errorBuilder: (context, errorMessage) {
//         return Center(
//           child: Text(
//             errorMessage,
//             style: const TextStyle(color: Colors.white),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _chewieController!.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 3, 31, 71),
//       body: Chewie(
//         controller: _chewieController!,
//       ),
//     );
//   }
// }
class VideoItems extends StatefulWidget {
  final contentFiles;
  final index;
  const VideoItems({super.key, this.contentFiles, this.index});

  @override
  State<VideoItems> createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    videoPlayerController =
        VideoPlayerController.file(widget.contentFiles[widget.index].file);
    return Scaffold(
      backgroundColor: const Color.fromARGB(56, 11, 11, 11),
      body: Chewie(
        controller: ChewieController(
          materialProgressColors: ChewieProgressColors(
              //   playedColor: backgroud_color1, bufferedColor: Colors.transparent
              ),
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: true,
          fullScreenByDefault: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }
}

class VideoItems1 extends StatefulWidget {
  final contentFiles;
  const VideoItems1({super.key, required this.contentFiles});

  @override
  State<VideoItems1> createState() => _VideoItems1State();
}

class _VideoItems1State extends State<VideoItems1> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    videoPlayerController = VideoPlayerController.file(widget.contentFiles);
    return Scaffold(
      backgroundColor: const Color.fromARGB(56, 11, 11, 11),
      body: Chewie(
        controller: ChewieController(
          materialProgressColors: ChewieProgressColors(
              // playedColor: backgroud_color1, bufferedColor: Colors.transparent
              ),
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: true,
          fullScreenByDefault: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }
}
