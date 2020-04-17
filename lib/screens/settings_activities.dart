import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../blocs/blocs.dart';

class SettingsActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivitiesBloc, ActivitiesState>(
        builder: (context, activitiesState) {
      if (activitiesState is ActivitiesLoaded) {
        final categories = activitiesState.categories;
        return ListView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                title: Text(categories[index].categoryName),
                trailing: FlatButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SingleChildScrollView(
                            child: MaterialPicker(
                              pickerColor: categories[index].color,
                              onColorChanged: (color) => {
                                //TODO implement color change
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(backgroundColor: categories[index].color),
                ),
              ));
            });
      } else {
        BlocProvider.of<ActivitiesBloc>(context).add(LoadActivitiesEvent());
        return Container();
      }
    });
  }
}
