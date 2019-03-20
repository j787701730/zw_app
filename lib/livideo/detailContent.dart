import 'package:flutter/material.dart';
import 'util.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class DetailContent extends StatefulWidget {
  final params;

  DetailContent(this.params);

  @override
  _DetailContentState createState() => _DetailContentState(params);
}

class _DetailContentState extends State<DetailContent> {
  final params;

  _DetailContentState(this.params);

  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  String videoUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDetail();
    _videoPlayerController = VideoPlayerController.network(videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: false,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true,
    );
  }

  _getDetail() {
    ajax('http://app.pearvideo.com/clt/jsp/v2/content.jsp?contId=${params['contId']}', (data) {
      print(data['relateConts']);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Chewie(
            controller: _chewieController,
          )
        ],
      ),
    );
  }
}
