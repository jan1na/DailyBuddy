import 'package:flutter/material.dart';

class UserResourcesPage extends StatelessWidget {

  final List<String> skillsMenuItems = List<String>();
  final List<String> favouriteActivitiesMenuItems = List<String>();

  @override
  Widget build(BuildContext context) {
    initSkillsMenuItems();
    initFavouriteActivitiesMenuItems();
    return Center(
            child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                createSubMenuItems(context, "Fähigkeiten", skillsMenuItems)
            )
    );
  }

  List<Widget> createSubMenuItems(BuildContext context, String subHeaderText, List <String> subMenuItems){
    //

    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    List<Widget> items = [];

    Container subHeader = Container(
        width: widthScreen / 1.3,
        child: FittedBox(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(subHeaderText)
                ]
            )
        )
    );

    items.add(subHeader);

    //buttons
    Widget item;
    for(var text in subMenuItems)
    {
      item = Container(
          width: widthScreen/1.5,
          height: heightScreen/(subMenuItems.length + (subMenuItems.length + 1) * 0.5 + 1),
          child:
          RaisedButton(
              //onPressed:,
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(18)
                  )
              ),
              child: Text(text)
          )
      );
      items.add(item);
    }

    return items;
  }

  void initSkillsMenuItems() {
    skillsMenuItems.add("Fähigkeit 1");
    skillsMenuItems.add("Fähigkeit 2");
    skillsMenuItems.add("Fähigkeit 3");
  }

  void initFavouriteActivitiesMenuItems()
  {
    favouriteActivitiesMenuItems.add("Aktivität 1");
    favouriteActivitiesMenuItems.add("Aktivität 2");
    favouriteActivitiesMenuItems.add("Aktivität 3");
  }
}
