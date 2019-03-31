import 'package:flutter/material.dart';
import '../pageLoading.dart';
//import 'detailContent.dart';

class CommonListView extends StatelessWidget {
  final data;

  CommonListView(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: data.isEmpty
          ? PageLoading()
          : ListView(
              children: data['data'].map<Widget>((item) {
                return item['url'] == null
                    ? Container(
                        height: 0,
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Image.network(item['url']),
                      );
              }).toList(),
            ),
    );
  }
}
