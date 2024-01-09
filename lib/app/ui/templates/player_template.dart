import 'package:get/get.dart';

import 'package:flutter/material.dart';
import '../../config_app.dart';
import '../../controllers/audio_controller.dart';
import '../colors/colors.dart';

class PlayerTemplate extends StatelessWidget {
  PlayerTemplate({super.key});

  final controller = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.stopSound;
        return true;
      },
      child: Scaffold(
        backgroundColor: ProColors.black,
        body: GetBuilder(
          init: controller,
          builder: (controller) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 36, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ProColors.blackMedium,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            controller.stopSound;
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_left_rounded,
                            color: ProColors.graySoft,
                          ),
                        ),
                      ),
                      Text(
                        'Now Playing by UNEX',
                        style: TextStyle(
                          color: ProColors.graySoft,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: ProColors.graySoft,
                        ),
                      ),
                    ],
                  ),
                ),
                // Image.asset(
                //   'assets/images/photo_woman.png',
                //   fit: BoxFit.cover,
                //   height: 300,
                // ),

                _musicListWidget(context),
                Column(
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                          overlayShape: SliderComponentShape.noThumb),
                      child: Obx(() => Slider(
                            value: controller.position.inSeconds.toDouble(),
                            onChanged: (double value) {
                              controller.seekTo(value);
                            },
                            max: controller.duration.inSeconds.toDouble(),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(
                              controller.position.toString().split('.').first,
                              style: TextStyle(
                                color: ProColors.grayDark,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              controller.duration.toString().split('.').first,
                              style: TextStyle(
                                color: ProColors.grayDark,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.repeat_rounded,
                          color: ProColors.graySoft,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => controller.definePreviewSound,
                        icon: Icon(
                          Icons.skip_previous_rounded,
                          color: ProColors.graySoft,
                        ),
                      ),
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ProColors.greenSoft,
                        ),
                        child: controller.fetchingSound
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: ProColors.graySoft,
                                ),
                              )
                            : IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (controller.isplaying) {
                                    controller.stopSound;
                                    controller.setPosition(0);
                                  } else {
                                    controller.playSound;
                                  }
                                },
                                icon: Icon(
                                  controller.isplaying
                                      ? Icons.stop
                                      : Icons.play_arrow,
                                  color: ProColors.graySoft,
                                ),
                              ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => controller.playNextSound,
                        icon: Icon(
                          Icons.skip_next_rounded,
                          color: ProColors.graySoft,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.shuffle_sharp,
                          color: ProColors.graySoft,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 32,
                  height: 32,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(
                      Icons.keyboard_arrow_up_outlined,
                      color: ProColors.graySoft,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Lyrics',
                    style: TextStyle(
                      color: ProColors.graySoft,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _musicListWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.musicList.length,
        itemBuilder: (context, index) {
          final music = controller.musicList[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.35,
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    "${ConfigApp.musicThumbsUrl}${music.album.dsImage}",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          music.dsTitle,
                          style: TextStyle(
                            color: ProColors.graySoft,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          music.album.artist.dsArtist,
                          style: TextStyle(
                            color: ProColors.grayLight,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.heart_broken,
                          color: ProColors.grayDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        onPageChanged: (value) {
          controller.playingIndex = value;
        },
      ),
    );
  }
  // Widget get _musicListWidget {
  //   return SizedBox(
  //     height: MediaQuery.sizeOf(context).height * 0.5,
  //     child: PageView.builder(
  //       controller: _pageController,
  //       itemCount: _musicList.length,
  //       itemBuilder: (context, index) {
  //         final music = _musicList[index];
  //         return Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(
  //               height: MediaQuery.sizeOf(context).height * 0.35,
  //               width: MediaQuery.sizeOf(context).width * 0.9,
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(16),
  //                 child: Image.network(
  //                   music.coverPhotoUrl,
  //                   fit: BoxFit.fill,
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(top: 16, bottom: 24),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         music.musicName,
  //                         style: TextStyle(
  //                           color: ProColors.graySoft,
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 20,
  //                         ),
  //                       ),
  //                       Text(
  //                         music.artistName,
  //                         style: TextStyle(
  //                           color: ProColors.grayLight,
  //                           fontSize: 20,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     width: 24,
  //                     height: 24,
  //                     child: IconButton(
  //                       padding: EdgeInsets.zero,
  //                       onPressed: () {},
  //                       icon: Icon(
  //                         Icons.heart_broken,
  //                         color: ProColors.grayDark,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         );
  //       },
  //       onPageChanged: (value) {
  //         _playingIndex = value;
  //       },
  //     ),
  //   );
  // }
}
