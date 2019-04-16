import 'package:flutter/material.dart';
import 'util.dart';

class SearchSongs extends StatefulWidget {
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
  Map dataList = {};

  _getList() {
    ajax('http://wallpaper.apc.360.cn/index.php?c=WallPaperAndroid&a=getAppsByCategory&cid=36&start=0&count=20',
        (data) {
        setState(() {
          dataList = data;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Text(''),
    );
  }
}
