import 'package:get/get.dart';

class PlayPauseController extends GetxController {
  RxBool isPlay = false.obs;

  bool get isPlaying => isPlay.value;

  void play() {
    isPlay(true);
  }

  void pause() {
    isPlay(false);
  }
}
