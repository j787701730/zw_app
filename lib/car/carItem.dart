import 'package:flutter/material.dart';

class CarItem extends StatelessWidget {
  final data;

  CarItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.map<Widget>((item) {
        return Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              width: 220,
              child: Text(
                item['name'],
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Text(item['value']),
            )
          ],
        );
      }).toList(),
    );
  }
}
