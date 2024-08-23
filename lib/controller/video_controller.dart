import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  VideoController() {
    init();
  }

  Future<void> init() async {
    videoPlayerController =
        VideoPlayerController.asset('lib/assets/video/videoplayback.mp4');
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      aspectRatio: videoPlayerController.value.aspectRatio,
    );

    update();
  }
}
