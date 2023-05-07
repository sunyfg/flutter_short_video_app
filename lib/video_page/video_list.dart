import 'package:flutter/material.dart';
import 'package:flutter_demo1/main.dart';
import 'package:flutter_demo1/router.dart';
import 'package:flutter_demo1/video_page/video_controller.dart';
import 'package:player/player.dart';
import 'package:player/video_view.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late VideoController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoController();
    _controller.init().then((value) {
      if (_controller.dataList != null) {
        print('_controller.dataList: ${_controller.dataList![0].url}');
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: _controller.dataList?.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: _controller.dataList == null
                  ? Container()
                  : AbsorbPointer(
                      absorbing: true,
                      child: VideoView(
                        Player()
                          ..setCommonDataSource(
                              _controller.dataList![index].url,
                              type: SourceType.net,
                              autoPlay: true),
                      ),
                    ),
              onTap: () async => await router.push(
                  name: MRouter.playerPage,
                  arguments: _controller.dataList![index].url),
            );
          }),
    );
  }
}
