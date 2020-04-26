import 'package:flutter/material.dart';
import 'package:daily_buddy_app/themes.dart';

class EmergencyContacts extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts>
{
  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    Column _emergencyContacts = createEmergencyContacts('MyEmergencyContacts');
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text('Notfallkontakte'),
      ),
      body: Center(
        child:
        Container(
            padding: EdgeInsets.only(top: 40.0),
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 30.0),
                            width: widthScreen/3,
                            height: heightScreen/6,
                            child:
                            RaisedButton(
                                color: defaultTheme.accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(18)
                                    )
                                ),
                                child: Text('Meine \nKontakte'),
                                onPressed: () =>
                                    setState(() {
                                      _emergencyContacts =
                                          createEmergencyContacts(
                                              'MyEmergencyContacts');
                                    })
                            )
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 30.0),
                            width: widthScreen/3,
                            height: heightScreen/6,
                            child:
                            RaisedButton(
                                color: defaultTheme.accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(18)
                                    )
                                ),
                                child: Text('Allgemeine \nKontakte'),
                                onPressed: () =>
                                    setState(() {
                                      _emergencyContacts =
                                          createEmergencyContacts(
                                              'GeneralEmergencyContacts');
                                    })
                            )
                        )
                      ]
                  ),
                  _emergencyContacts
                ]
            )
        ),
      ),
    );
  }

  Column createEmergencyContacts (String buttonName)
  {
    Column contactsColumn;

    if(buttonName == 'MyEmergencyContacts')
      {
        contactsColumn = Column(
        children: <Widget>[
          Container(
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.phone),
                    Text('Bitte Nummer hinterlegen')
                  ])
          )
        ]
        );
      }
    else
      {
        print('else');
        contactsColumn = Column(
            children: <Widget>[
              Container(
                child:
                    Row(
            children: <Widget>[
                Icon(Icons.phone),
                Text('Polizei Notruf')
                  ])
              ),
              Container(
                  child:
                  Row(
                      children: <Widget>[
                        Icon(Icons.phone),
                        Text('Feuerwehr Rettungsdienst')
                      ])
              )
            ]
        );
      }

    return contactsColumn;
  }
}