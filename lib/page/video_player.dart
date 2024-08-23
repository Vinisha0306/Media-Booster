import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:media_player/controller/video_controller.dart';

class VideoPlayer extends StatelessWidget {
  VideoPlayer({super.key});

  VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(
      builder: (controller) => Center(
        child: controller.videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: controller.videoPlayerController.value.aspectRatio,
                child: Chewie(
                  controller: controller.chewieController,
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
