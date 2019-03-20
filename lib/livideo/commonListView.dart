import 'package:flutter/material.dart';
import '../pageLoading.dart';
import 'detailContent.dart';

class CommonListView extends StatelessWidget {
  final data;

  CommonListView(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: data.isEmpty
          ? PageLoading()
          : ListView(
              children: data.map<Widget>((item) {
                return item['contList'] == null
                    ? Container(
                        height: 0,
                      )
                    : Column(
                        children: <Widget>[
                          Container(
                            child: Text('${item['nodeName']}'),
                          ),
                          Column(
                            children: item['contList'].map<Widget>((list) {
                              print(list);
                              return ListTile(
                                title: Text('${list['name']}'),
                                onTap: () {
                                  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                    return new DetailContent({'contId': list['contId']});
                                  }));
                                },
                              );
                            }).toList(),
                          )
                        ],
                      );
              }).toList(),
            ),
    );
  }
}
