import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_player/constsnt/list.dart';

import '../controller/song_audio_controller.dart';
import 'audio_player_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              homeAppBar(),
              const SizedBox(
                height: 20,
              ),
              textFront(title: 'Categories'),
              Expanded(
                flex: 3,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: musicCategoriesList.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              musicCategoriesList[index]['image'],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        musicCategoriesList[index]['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 10,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              textFront(title: 'Artists'),
              Expanded(
                flex: 5,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: artistsList.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(
                              artistsList[index]['image'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        artistsList[index]['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 10,
                  ),
                ),
              ),
              textFront(title: 'Trending'),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                  flex: 5,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                      itemCount: trendingSongList.length))
            ],
          ),
        ),
      ),
    );
  }
}

Widget homeAppBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Image(
        image: AssetImage(
          'assets/images/profile.png',
        ),
        width: 100,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, Vinish!',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Live your day with Music',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Spacer(),
      Icon(
        CupertinoIcons.bell_fill,
        color: Colors.blueAccent,
        weight: 30,
      ),
    ],
  );
}

Widget textFront({required title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacer(),
      Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
      ),
    ],
  );
}
