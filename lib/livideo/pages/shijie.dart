import 'package:flutter/material.dart';
import '../util.dart';

class ShiJie extends StatefulWidget {
  @override
  _ShiJieState createState() => _ShiJieState();
}

class _ShiJieState extends State<ShiJie> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _getList(){
    ajax('http://app.pearvideo.com/clt/jsp/v2/home.jsp?lastLikeIds=1063871%2C1063985%2C1064069%2C1064123%2C1064078%2C1064186%2C1062372%2C1064164%2C1064081%2C1064176%2C1064070%2C1064019', (data){

    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
