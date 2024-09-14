import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constsnt/list.dart';
import '../audio_player_screen.dart';

class CategoriesListviewPage extends StatelessWidget {
  const CategoriesListviewPage({super.key});

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
            'Categories',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: ListView.separated(
            itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      image: NetworkImage(
                        musicCategoriesList[index]['image'],
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
                            musicCategoriesList[index]['name'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            separatorBuilder: (context, index) => Divider(),
            itemCount: musicCategoriesList.length),
      ),
    );
  }
}
