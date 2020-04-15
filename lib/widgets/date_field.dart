import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  final DateTime date;
  final Function(DateTime) onChange;

  const DateField({Key key, this.date, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(date?.millisecondsSinceEpoch),
      initialValue:
          date == null ? "TT.MM.JJJJ" : DateFormat("dd.MM.yyyy").format(date),
      readOnly: true,
      decoration: InputDecoration(border: OutlineInputBorder()),
      enabled: onChange != null,
      onTap: () async {
        final time = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime.now()
                  .subtract(
                    Duration(days: 1),
                  )
                  .isAfter(date)
              ? date
              : DateTime.now().subtract(
                  Duration(days: 1),
                ),
          lastDate: DateTime.now().add(
            Duration(days: 365),
          ),
        );
        if (time != null) onChange(time);
      },
    );
  }
}
