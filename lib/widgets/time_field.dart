import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeField extends StatelessWidget {
  final DateTime date;
  final Function(TimeOfDay) onChange;

  const TimeField({Key key, this.date, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(date),
      initialValue: date == null ? "HH:mm" : DateFormat("HH:mm").format(date),
      readOnly: true,
      decoration: InputDecoration(border: OutlineInputBorder()),
      enabled: onChange != null,
      onTap: () async {
        final timeOfDay = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(minute: date.minute, hour: date.hour));
        onChange(timeOfDay);
      },
    );
  }
}
