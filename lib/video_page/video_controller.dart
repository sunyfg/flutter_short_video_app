
import 'dart:convert';

import 'package:flutter_demo1/video_page/server_data.dart';
import 'package:flutter_demo1/video_page/video_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoController {
  List<VideoModel>? dataList;

  Future<void> init() async {
    // 首先判断一级缓存——即内存中是否有数据
    dataList ??= await fetchVideoData();
  }

  // 从服务端拉取视频Json字符串类型表示的视频数据
  Future<List<VideoModel>> fetchVideoData() async {
    var sp = await SharedPreferences.getInstance();

    var modelStr = sp.getString("videoModel");
    if(modelStr != null && modelStr.isNotEmpty) {
      print('DEMO: 二级缓存中找到数据，直接使用');
      // 二级缓存中找到数据，直接使用
      var list = jsonDecode(modelStr) as List<dynamic>;
      // jsonDecode获取到的是“List<Map>”，需要转换成List<VideoModel>
      // List<Map> => List<VideoModel>
      print('DEMO: 二级缓存中找到数据，直接使用');
      return list.map((e) => VideoModel.fromJson(e)).toList();
    } else {
      // 二级缓存未找到数据，走三级缓存
      print('DEMO: 二级缓存未找到数据，走三级缓存');
      var list = jsonDecode(ServerData.fetchDataFromServer());
      var sp = await SharedPreferences.getInstance();
      sp.setString('videoModel', ServerData.fetchDataFromServer());
      return list.map((e) => VideoModel.fromJson(e)).toList();
    }
  }
}