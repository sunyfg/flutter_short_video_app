import 'package:flutter/material.dart';
import 'package:player/player.dart';
import 'package:player/video_view.dart';

class PlayerPage extends StatefulWidget {
  final String url;

  const PlayerPage(this.url);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {

  @override
  Widget build(BuildContext context) {
    var player = Player();
    player.setCommonDataSource(widget.url, type: SourceType.net, autoPlay: true);
    return GestureDetector(
      onLongPress: () {
        // 长按视频，弹出对话框
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: const Text('提示'),
            content: const Text('确认下载本视频吗'),
            actions: <Widget>[
              TextButton(onPressed: () => Navigator.pop(context, 'cancel'), child: const Text('取消')),
              TextButton(onPressed: () => Navigator.pop(context, 'cancel'), child: const Text('确认')),
            ],
          );
        });
      },
      child: VideoView(player),
    );
  }
}
