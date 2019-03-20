import 'package:flutter/material.dart';
import '../util.dart';
import '../commonListView.dart';

class SheHui extends StatefulWidget {
  @override
  _SheHuiState createState() => _SheHuiState();
}

class _SheHuiState extends State<SheHui> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getList();
  }

  List dataList = [];

  _getList() {
    ajax(
      'http://app.pearvideo.com/clt/jsp/v2/home.jsp?lastLikeIds=1063871%2C1063985%2C1064069%2C1064123%2C1064078%2C1064186%2C1062372%2C1064164%2C1064081%2C1064176%2C1064070%2C1064019',
        (data) {
        setState(() {
          dataList = data['dataList'];
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonListView(dataList),
    );
  }
}
