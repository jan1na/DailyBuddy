import 'package:daily_buddy_app/themes.dart';
import 'package:daily_buddy_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class MainMenu extends StatelessWidget {

  final Map<String, MaterialPageRoute> burgerMenuItemsContent = Map<String, MaterialPageRoute>();
  final Map<String, MaterialPageRoute> mainMenuItemsContent = Map<String, MaterialPageRoute>();

  @override
  Widget build(BuildContext context) {
    initBurgerMenuItems();
    initMainMenuItems();
    return Scaffold(
        appBar: AppBar(centerTitle: true,
          title: Text(getCurrentDate()),
        ),
        body: Center(
            child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                createMainMenuItems(context)
            )
        ),
        endDrawer: Drawer(
            child:
            Container
              (
              height: double.maxFinite,
              child:
              ListView.separated
                (
                  itemCount: burgerMenuItemsContent.length,
                  itemBuilder: (BuildContext context, index) {
                    return new ListTile(title: Text(burgerMenuItemsContent.keys.elementAt(index)),
                        onTap: () {
                          Navigator.pop(context);
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            Navigator.push(context,
                                burgerMenuItemsContent[burgerMenuItemsContent.keys.elementAt(index)]);
                          });
                        }
                    );
                  },

                  separatorBuilder: (context, index) => Divider()
              ),
            )
        )
    );
  }

  List<Widget> createMainMenuItems(BuildContext context){

    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    List<Widget> mainMenuItems = [];

    //Willkommens-Zeile
    Container welcome = Container(
        width: widthScreen / 1.3,
        child: FittedBox(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.wb_sunny,
                      color: defaultTheme.accentColor),
                  Text('  Schön, dass du da bist!  '),
                  Icon(Icons.wb_sunny,
                      color: defaultTheme.accentColor)
                ]
            )
        )
    );

    mainMenuItems.add(welcome);

    //buttons
    Widget mainMenuItem;
    mainMenuItemsContent.forEach((key, value){
      mainMenuItem = Container(
          width: widthScreen/1.5,
          height: heightScreen/(mainMenuItemsContent.length + (mainMenuItemsContent.length + 1) * 0.5 + 1),
          child:
          RaisedButton(
            color: defaultTheme.accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(18)
                  )
              ),
              child: Text(key),
              onPressed: () => Navigator.push(context, value)
          )
      );
      mainMenuItems.add(mainMenuItem);
    });

    return mainMenuItems;
  }

  void initBurgerMenuItems() {
    burgerMenuItemsContent['Mein Profil'] =
        MaterialPageRoute(builder: (context) => DummyScreen());
    burgerMenuItemsContent['Über uns'] =
        MaterialPageRoute(builder: (context) => DummyScreen());
    burgerMenuItemsContent['Feedback'] =
        MaterialPageRoute(builder: (context) => DummyScreen());
    burgerMenuItemsContent['Hilfe'] =
        MaterialPageRoute(builder: (context) => DummyScreen());
  }

  void initMainMenuItems()
  {
    mainMenuItemsContent['Dein Kalender'] =
        MaterialPageRoute(builder: (context) => SchedulesPage());
    mainMenuItemsContent['Erfolge'] =
        MaterialPageRoute(builder: (context) => DummyScreen());
    mainMenuItemsContent['Deine Ressourcen'] =
        MaterialPageRoute(builder: (context) => DummyScreen());
    mainMenuItemsContent['Notfallkontakte'] =
        MaterialPageRoute(builder: (context) => DummyScreen());
    mainMenuItemsContent['Weitere Fragen'] =
        MaterialPageRoute(builder: (context) => DummyScreen());
  }

  String getCurrentDate(){
    return DateFormat('dd.MM.yy').format(DateTime.now());
  }

}



