import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String name;
  final Widget child;

  const Input({Key key, this.name, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(name),
        SizedBox(
          height: 8,
        ),
        child,
      ],
    );
  }
}
