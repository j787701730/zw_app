import 'package:flutter/material.dart';
import 'dart:convert';
import 'util.dart';
import '../pageLoading.dart';
import 'carItem.dart';

class CarDetail extends StatefulWidget {
  final params;

  CarDetail(this.params);

  @override
  _CarDetailState createState() => _CarDetailState(params);
}

class _CarDetailState extends State<CarDetail> {
  final params;

  _CarDetailState(this.params);

  List result = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMsg();
  }

  _getMsg() {
    ajax('http://apicloud.mob.com/car/series/query?cid=${params['cid']}', (data) {
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
        title: Text('${params['seriesName']}'),
      ),
      body: result.isEmpty
          ? PageLoading()
          : Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: result.map<Widget>((res) {
                  return Column(
                    children: <Widget>[
                      Container(
                        child: Image.network(
                          res['carImage'],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      CarItem(res['airConfig']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['baseInfo']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['carbody']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['chassis']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['controlConfig']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['engine']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['exterConfig']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['glassConfig']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['interConfig']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['lightConfig']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['mediaConfig']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['safetyDevice']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['seatConfig']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['techConfig']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['transmission']),
                      Container(
                        height: 20,
                      ),
                      CarItem(res['wheelInfo']),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}
