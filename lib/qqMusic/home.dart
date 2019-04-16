import 'package:flutter/material.dart';
import 'util.dart';
import 'newSongsTop.dart';
import 'randomSongs.dart';
import 'searchSongs.dart';
import 'myFavourite.dart';
import 'package:audioplayers/audioplayers.dart';

import 'dart:async';
import 'dart:convert';

enum PlayerState { stopped, playing, paused }

class QQMusicHome extends StatefulWidget {
  @override
  _QQMusicHomeState createState() => _QQMusicHomeState();
}

class _QQMusicHomeState extends State<QQMusicHome> with SingleTickerProviderStateMixin {
  TabController _tabController;
  AudioPlayer _audioPlayer;
  AudioPlayerState _audioPlayerState;
  Duration _duration;
  Duration _position;
  String playUrl;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: categoryList.length);
    _initAudioPlayer();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _audioPlayer.stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  List result = [];
  List categoryList = [
    {'categoryId': '0', 'name': '新歌点榜'},
    {'categoryId': '1', 'name': '随机推荐'},
    {'categoryId': '2', 'name': '歌曲搜索'},
    {'categoryId': '3', 'name': '我的收藏'},
  ];

  getSongUrl(songData) {
    String url = 'https://c.y.qq.com/base/fcgi-bin/fcg_music_express_mobile3.fcg?format=json205361747&platform=yqq'
        '&cid=205361747&songmid=${songData['songmid']}&filename=C400${songData['songmid']}.m4a&guid=126548448';
    ajax(url, (data) {
      Map obj = jsonDecode(data);
      String vkey = obj['data']['items'][0]['vkey'];
      setState(() {
        playUrl = 'http://ws.stream.qqmusic.qq.com/C400${songData['songmid']}.m4a?fromtag=0&guid=126548448&vkey=$vkey';
        _play();
      });
    });
  }

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _isPlaying => _playerState == PlayerState.playing;

  get _isPaused => _playerState == PlayerState.paused;

  get _durationText => _duration?.toString()?.split('.')?.first ?? '';

  get _positionText => _position?.toString()?.split('.')?.first ?? '';

  void _initAudioPlayer() {
    _audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) => setState(() {
          print(duration);
          _duration = duration;
        }));

    _positionSubscription = _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
          _position = p;
        }));

    _playerCompleteSubscription = _audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      setState(() {
        _position = _duration;
      });
    });

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.stopped;
        _duration = new Duration(seconds: 0);
        _position = new Duration(seconds: 0);
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        _audioPlayerState = state;
      });
    });
  }

  Future<int> _play() async {
    print(playUrl);
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    final result = await _audioPlayer.play(playUrl, isLocal: false, position: playPosition);
    if (result == 1) setState(() => _playerState = PlayerState.playing);
    return result;
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }

  Future<int> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = new Duration();
      });
    }
    return result;
  }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TabBar(
            isScrollable: true,
            tabs: categoryList.map<Widget>((item) {
              return (Tab(child: Text(item['name'])));
            }).toList(),
            controller: _tabController,
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 50 - 56 - MediaQuery.of(context).padding.top,
                child: new TabBarView(
                    controller: _tabController,
                    children: <Widget>[NewSongsTop(getSongUrl), RandomSongs(), SearchSongs(), MyFavourite()]),
              ),
              Container(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          onPressed: _isPlaying ? null : () => _play(),
                          iconSize: 30,
                          icon: new Icon(Icons.play_arrow),
                          color: Colors.cyan),
                      IconButton(
                          onPressed: _isPlaying ? () => _pause() : null,
                          iconSize: 30,
                          icon: new Icon(Icons.pause),
                          color: Colors.cyan),
                      IconButton(
                          onPressed: _isPlaying || _isPaused ? () => _stop() : null,
                          iconSize: 30,
                          icon: new Icon(Icons.stop),
                          color: Colors.cyan),
                      Container(
                        child: Text(
                          _position != null
                              ? '${_positionText ?? ''} / ${_durationText ?? ''}'
                              : _duration != null ? _durationText : '',
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}
