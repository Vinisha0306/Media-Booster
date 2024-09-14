import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constsnt/list.dart';
import '../audio_player_screen.dart';

class ListviewPage extends StatelessWidget {
  const ListviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          title: const Text(
            'Trending',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      songAudioController.currentAudio =
                          trendingSongList[index]['song'];
                      print(
                          'print data :: ${songAudioController.currentAudio}');
                      Get.toNamed(
                        '/audio',
                        arguments: index,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: NetworkImage(
                            trendingSongList[index]['image'],
                          ),
                          width: 100,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trendingSongList[index]['title'],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                trendingSongList[index]['subTitle'],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              separatorBuilder: (context, index) => Divider(),
              itemCount: trendingSongList.length),
        ),
      ),
    );
  }
}
