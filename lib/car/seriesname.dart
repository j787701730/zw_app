import 'package:flutter/material.dart';
import 'dart:convert';
import 'util.dart';
import '../pageLoading.dart';
import 'carDetail.dart';

class SeriesName extends StatefulWidget {
  final params;

  SeriesName(this.params);

  @override
  _SeriesNameState createState() => _SeriesNameState(params);
}

class _SeriesNameState extends State<SeriesName> {
  final params;

  _SeriesNameState(this.params);

  List result = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMsg();
  }

  _getMsg() {
    ajax('http://apicloud.mob.com/car/seriesname/query?name=${params['name']}', (data) {
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
        title: Text('${params['name']}'),
      ),
      body: result.isEmpty
          ? PageLoading()
          : ListView(
              children: result.map<Widget>((item) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                        return new CarDetail({
                          'brandName': '${item['brandName']}',
                          'seriesName': '${item['seriesName']}',
                          'cid': item['carId']
                        });
                      }));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(item['brandName']),
                        ),
                        Container(
                          child: Text(item['seriesName']),
                        ),
                        Container(
                          child: Text(item['guidePrice']),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
