import 'package:flutter/material.dart';
import 'util.dart';
import 'dart:convert';
import '../pageLoading.dart';

class NewSongsTop extends StatefulWidget {
  final getSongUrl;

  NewSongsTop(this.getSongUrl);

  @override
  _NewSongsTopState createState() => _NewSongsTopState();
}

class _NewSongsTopState extends State<NewSongsTop> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getList();
  }

  @override
  bool get wantKeepAlive => true;
  List songList = [];
  int count = 0;

  _getList() {
    ajax(
        'https://c.y.qq.com/v8/fcg-bin/fcg_v8_toplist_cp.fcg?uin=0&notice=0'
        '&platform=h5&needNewCode=1&tpl=3&page=detail&type=top&topid=27', (data) {
      Map obj = jsonDecode(data);
      if (obj['code'] == 0) {
        setState(() {
          songList = obj['songlist'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    count = 0;
    return Scaffold(
      body: songList.isEmpty
          ? PageLoading()
          : ListView(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              children: songList.map<Widget>((item) {
                count += 1;
                return Container(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 40,
                        child: Center(
                          child: Text('$count'),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: InkWell(
                            onTap: () {
                              widget.getSongUrl({'songmid': '${item['data']['songmid']}'});
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    '${item['data']['songname']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    item['data']['singer'][0]['name'],
                                    style: TextStyle(color: Color(0xff777777)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        child: Icon(Icons.favorite_border),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}
