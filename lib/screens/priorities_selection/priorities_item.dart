import 'package:flutter/material.dart';

class PriorityItemWidget extends StatefulWidget {
  PriorityItemWidget({Key key, this.statement}) : super(key: key);

  final Widget statement;

  @override
  PriorityItemWidgetState createState() => PriorityItemWidgetState();
}

class PriorityItemWidgetState extends State<PriorityItemWidget> {
  bool _isChecked = false;

  get isChecked => _isChecked;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: widget.statement,
      value: _isChecked,
      onChanged: (bool value) {
        setState(() {
          _isChecked = value;
        });
      },
    );
  }
}
