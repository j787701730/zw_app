import 'package:flutter/material.dart';
import 'movie/home.dart';
import 'weather/home.dart';
import 'livideo/home.dart';
import 'one/home.dart';
import 'tiku/home.dart';

class Index extends StatelessWidget {
  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('首页'),
        ),
        body: WillPopScope(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('电影'),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                      return new MovieHome();
                    }));
                  },
                ),ListTile(
                  title: Text('天气'),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                      return new WeatherHome();
                    }));
                  },
                ),ListTile(
                  title: Text('视频'),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                      return new LiHome();
                    }));
                  },
                ),ListTile(
                  title: Text('ONE'),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                      return new OneHome();
                    }));
                  },
                ),ListTile(
                  title: Text('驾照题库'),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                      return new TiKuHome();
                    }));
                  },
                ),
              ],
            ),
            onWillPop: () async {
              if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
                //两次点击间隔超过1秒则重新计时
                _lastPressedAt = DateTime.now();
                return false;
              }
              return true;
            }));
  }
}
