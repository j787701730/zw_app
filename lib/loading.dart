import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final bool requesting;

  Loading(this.requesting);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !requesting,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ),
    );
  }
}
