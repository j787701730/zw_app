import 'package:flutter/material.dart';
import 'movie/home.dart';
import 'weather/home.dart';
import 'livideo/home.dart';
import 'one/home.dart';
import 'tiku/home.dart';
import 'stock/home.dart';
import 'car/home.dart';
import 'meiriyiwen/home.dart';
import 'transit/home.dart';
import 'shiguangmovie/home.dart';
import 'wallpaper/home.dart';
import 'reader/home.dart';
import 'qqMusic/home.dart';

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
                Wrap(
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('电影'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new MovieHome();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('Time电影'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new ShiGuangHome();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('QQ音乐'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new QQMusicHome();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('天气'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new WeatherHome();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('视频'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new LiHome();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('ONE'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new OneHome();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('驾照题库'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new TiKuHome();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('汽车信息'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new CarHome();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('每日一文'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new MeiRiHome();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('360壁纸'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new WallPaperHome();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('小说'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new ReaderHome();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('全球股指'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new StockHome();
                          }));
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 4,
                      child: InkWell(
                        child: Center(
                          child: Text('公交地铁(福州)'),
                        ),
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                            return new TransitHome();
                          }));
                        },
                      ),
                    ),
                  ],
                )
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
