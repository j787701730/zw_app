import 'package:flutter/material.dart';
import 'util.dart';
import 'musicPlayer.dart';
import 'dart:convert';
import '../pageLoading.dart';

class OneHome extends StatefulWidget {
  @override
  _OneHomeState createState() => _OneHomeState();
}

class _OneHomeState extends State<OneHome> {
  String mp3 = 'http://www.ytmp3.cn/down/58464.mp3';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getidlist();
  }

//  _getMusiclist() {
//    ajax('http://v3.wufazhuce.com:8000/api/channel/music/more/0', (data) {
//      print(jsonEncode(data));
//    });
//  }
  List idList = [];
  Map oneList = {};

  _getidlist() {
    ajax('http://v3.wufazhuce.com:8000/api/onelist/idlist/', (data) {
      print(jsonEncode(data));
      if (!mounted) return;
      if (data['res'] == 0) {
        setState(() {
          idList = data['data'];
          _getonelist();
        });
      }
    });
  }

  _getonelist() {
    ajax('http://v3.wufazhuce.com:8000/api/onelist/${idList[0]}/0', (data) {
      print(jsonEncode(data['data']));
      if (!mounted) return;
      if (data['res'] == 0) {
        setState(() {
          oneList = data['data'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ONE'),
      ),
      body: oneList.isEmpty
          ? PageLoading()
          : ListView(
              children: <Widget>[
                Container(
                  child: FlatButton(
                      onPressed: () {
                        _getonelist();
                      },
                      child: Text('one')),
                ),
//          MusicPlayer(
//            url: mp3,
//          )
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(oneList['weather']['date']),
                      Text('${oneList['weather']['city_name']}·'
                          '${oneList['weather']['climate']}'
                          '${oneList['weather']['temperature']}℃')
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: oneList['content_list'].map<Widget>((list){
//                      return ListTile(
//                        title: ,
//                      );
                    }).toList(),
                  ),
                )
              ],
            ),
    );
  }
}
