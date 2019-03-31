import 'package:flutter/material.dart';
import '../util.dart';
import '../commonListView.dart';

class Love extends StatefulWidget {
  @override
  _LoveState createState() => _LoveState();
}

class _LoveState extends State<Love> with AutomaticKeepAliveClientMixin {
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
    ajax('http://wallpaper.apc.360.cn/index.php?c=WallPaperAndroid&a=getAppsByCategory&cid=30&start=0&count=20', (data) {
      setState(() {
        dataList = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CommonListView(dataList),
    );
  }
}