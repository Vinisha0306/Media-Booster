import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:media_player/constant/list.dart';
import 'package:media_player/controller/video_controller.dart';
import 'package:media_player/page/video_player.dart';

class AllVideoPlayer extends StatelessWidget {
  AllVideoPlayer({super.key});

  VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: videoList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () async {
            videoController.currentVideo = videoList[index];
            if (videoController.currentVideo != null) {
              videoController.init();
              Get.to(VideoPlayer());
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      videoList[index]['image'],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      '${videoList[index]['name']} $des',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
