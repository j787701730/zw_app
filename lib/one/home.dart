import 'package:flutter/material.dart';
import 'util.dart';
import 'musicPlayer.dart';
import 'dart:convert';
import '../pageLoading.dart';
import 'articleContent.dart';

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
                    children: oneList['content_list'].map<Widget>((list) {
                      switch (list['category']) {
                        case '0':
                          return ListTile(
                            title: Column(
                              children: <Widget>[
                                Container(
                                  child: Image.network(
                                    list['img_url'],
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Text('${list['title']} | ${list['pic_info']}'),
                                  ),
                                ),
                                Container(
                                  child: Text(list['forward']),
                                ),
                                Container(
                                  child: Text(list['words_info']),
                                ),
                              ],
                            ),
                          );
                          break;
                        case '1':
                          return ListTile(
                            onTap: () {
                              Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                return new ArticleContent({'item_id': list['item_id'],'title':list['title'],'share_url':list['share_url']});
                              }));
                            },
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Text('-- ${category[list['category']]} --'),
                                ),
                                Container(
                                  child: Text('${list['title']} | ${list['pic_info']}'),
                                ),
                                Container(
                                  child: Text('文 / ${list['author']['user_name']}'),
                                ),
                                Container(
                                  child: Image.network(
                                    list['img_url'],
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Container(
                                  child: Text(list['forward']),
                                  padding: EdgeInsets.only(bottom: 10),
                                ),
                                Container(
                                  height: 3,
                                  color: Colors.black38,
                                )
                              ],
                            ),
                          );
                          break;
                        case '2':
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Text('-- ${category[list['category']]} --'),
                                ),
                                Container(
                                  child: Text('${list['title']} | ${list['pic_info']}'),
                                ),
                                Container(
                                  child: Text('文 / ${list['author']['user_name']}'),
                                ),
                                Container(
                                  child: Image.network(
                                    list['img_url'],
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Container(
                                  child: Text(list['forward']),
                                  padding: EdgeInsets.only(bottom: 10),
                                ),
                                Container(
                                  height: 3,
                                  color: Colors.black38,
                                )
                              ],
                            ),
                          );
                          break;
                        case '3':
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Text('-- ${category[list['category']]} --'),
                                ),
                                Container(
                                  child: Text('${list['title']} | ${list['pic_info']}'),
                                ),
                                Container(
                                  child: Text('${list['answerer']['user_name']}答'),
                                ),
                                Container(
                                  child: Image.network(
                                    list['img_url'],
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Container(
                                  child: Text(list['forward']),
                                  padding: EdgeInsets.only(bottom: 10),
                                ),
                                Container(
                                  height: 3,
                                  color: Colors.black38,
                                )
                              ],
                            ),
                          );
                          break;
                        case '4':
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Text('-- ${category[list['category']]} --'),
                                ),
                                Container(
                                  child: Text('${list['title']} | ${list['pic_info']}'),
                                ),
                                Container(
                                  child: Text('文 / ${list['author']['user_name']}'),
                                ),
                                Center(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width / 3,
                                    height: MediaQuery.of(context).size.width / 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                            list['img_url'],
                                          )),
                                          borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width / 3))),
                                      child: Center(
                                        child: Icon(
                                          Icons.play_circle_outline,
                                          color: Color.fromRGBO(255, 255, 255, 0.6),
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '${list['music_name']} ·${list['audio_author']} | ${list['audio_album']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  padding: EdgeInsets.only(bottom: 10),
                                ),
                                Container(
                                  child: Text(list['forward']),
                                  padding: EdgeInsets.only(bottom: 10),
                                ),
                                Container(
                                  height: 3,
                                  color: Colors.black38,
                                )
                              ],
                            ),
                          );
                          break;
                        case '5':
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Text('-- ${category[list['category']]} --'),
                                ),
                                Container(
                                  child: Text('${list['title']} | ${list['pic_info']}'),
                                ),
                                Container(
                                  child: Text('文 / ${list['author']['user_name']}'),
                                ),
                                Container(
                                  child: Image.network(
                                    list['img_url'],
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                Container(
                                  child: Text(list['forward']),
                                  padding: EdgeInsets.only(bottom: 10),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[Text('————《${list['subtitle']}》')],
                                  ),
                                ),
                                Container(
                                  height: 3,
                                  color: Colors.black38,
                                )
                              ],
                            ),
                          );
                          break;
                        default:
                          return Placeholder(
                            fallbackHeight: 1,
                            color: Colors.transparent,
                          );
                          break;
                      }
                    }).toList(),
                  ),
                )
              ],
            ),
    );
  }
}
