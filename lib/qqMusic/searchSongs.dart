import 'package:flutter/material.dart';
import 'util.dart';
import 'dart:convert';

class SearchSongs extends StatefulWidget {
  final getSongUrl;
  final changeFavourite;
  final myFavouriteSongs;

  SearchSongs(this.getSongUrl, this.changeFavourite, this.myFavouriteSongs);

  @override
  _SearchSongsState createState() => _SearchSongsState();
}

class _SearchSongsState extends State<SearchSongs> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getList();
  }

  @override
  bool get wantKeepAlive => true;
  List songList = [];
  String searchWord = '殇雪';
  int count = 0;

  _getList() {
    if (searchWord.trim() == '') {
      setState(() {
        songList = [];
      });
      return;
    }
    ajax('https://c.y.qq.com/soso/fcgi-bin/client_search_cp?aggr=1&cr=1&flag_qc=0&p=1&n=50&w=$searchWord', (data) {
      if (!mounted) return;
      Map obj = jsonDecode(data.substring(9, data.length - 1));
      if (obj['code'] == 0) {
        setState(() {
          songList = obj['data']['song']['list'];
        });
      }
    });
  }

  queryChange(val) {
    setState(() {
      searchWord = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    count = 0;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(hintText: '搜索歌曲', hintStyle: TextStyle(color: Colors.white)),
            onChanged: queryChange,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _getList,
          )
        ],
      ),
      body: ListView(
        children: songList.map<Widget>((item) {
          count += 1;
          bool flag = false;
          if (item != null) {
            for (var o in widget.myFavouriteSongs) {
              if (item['songmid'] == o['songmid']) {
                flag = true;
                break;
              }
            }
          }
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
                        widget.getSongUrl({'songmid': '${item['songmid']}',
                          'songname': '${item['songname']}',
                          'singer': '${item['data']['singer'][0]['name']}'});
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              '${item['songname']}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            child: Text(
                              item['singer'][0]['name'],
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
                  child: InkWell(
                    onTap: () {
                      widget.changeFavourite({
                        'songmid': '${item['songmid']}',
                        'songname': '${item['songname']}',
                        'singer': '${item['singer'][0]['name']}',
                      }, !flag);
                    },
                    child: Icon(
                      flag ? Icons.favorite : Icons.favorite_border,
                      color: Color(0xFF31C27C),
                    ),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
