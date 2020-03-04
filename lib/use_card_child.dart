import 'package:flutter/material.dart';

class UseCardChild extends StatelessWidget {
  UseCardChild({@required this.childIcon, this.childText});

  final String childIcon;
  final String childText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 100.0,
          height: 100.0,
          child: Image.asset(childIcon),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(childText)
      ],
    );
  }
}
