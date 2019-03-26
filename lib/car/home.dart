import 'package:flutter/material.dart';
import 'dart:convert';
import '../pageLoading.dart';
import 'util.dart';
import 'seriesname.dart';

class CarHome extends StatefulWidget {
  @override
  _CarHomeState createState() => _CarHomeState();
}

class _CarHomeState extends State<CarHome> {
  List result = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCarBrand();
  }

  _getCarBrand() {
    ajax('http://apicloud.mob.com/car/brand/query?', (data) {
      print(data);
      var obj = jsonDecode(data);
      setState(() {
        result = obj['result'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('汽车品牌'),
      ),
      body: result.isEmpty
          ? PageLoading()
          : ListView(
              children: result.map<Widget>((item) {
                return Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Center(
                          child: Text(
                            item['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Wrap(
                        children: item['son'].map<Widget>((son) {
                          return Container(
                            padding: EdgeInsets.only(right: 10, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                  return new SeriesName({'name': '${son['type']}'});
                                }));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(color: Colors.blue),
                                  top: BorderSide(color: Colors.blue),
                                  left: BorderSide(color: Colors.blue),
                                  right: BorderSide(color: Colors.blue),
                                )),
                                padding: EdgeInsets.all(10),
                                child: Text('${son['type']}'),
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}
