import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/controller/video_controller.dart';

class VideoPlayer extends StatefulWidget {
  VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoController videoController = Get.put(VideoController());

  @override
  void dispose() {
    videoController.chewieController.dispose();
    videoController.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(videoController.currentVideo?['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<VideoController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                controller.videoPlayerController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio:
                            controller.videoPlayerController.value.aspectRatio,
                        child: Chewie(
                          controller: controller.chewieController,
                        ),
                      )
                    : const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
