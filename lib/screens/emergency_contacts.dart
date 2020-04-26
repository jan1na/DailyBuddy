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
    Column _emergencyContacts = createEmergencyContacts('MyEmergencyContacts');
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text('Notfallkontakte'),
      ),
      body: Center(
        child:
        Container(
            padding: EdgeInsets.only(top: 20.0),
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                      children: <Widget>[
                        Container(
                            child:
                            RaisedButton(
                                color: defaultTheme.accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(18)
                                    )
                                ),
                                child: Text('Meine /nKontakte'),
                                onPressed: () =>
                                    setState(() {
                                      _emergencyContacts =
                                          createEmergencyContacts(
                                              'MyEmergencyContacts');
                                    })
                            )
                        ),
                        Container(
                            child:
                            RaisedButton(
                                color: defaultTheme.accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(18)
                                    )
                                ),
                                child: Text('Allgemeine /nKontakte'),
                                onPressed: () =>
                                    setState(() {
                                      _emergencyContacts =
                                          createEmergencyContacts(
                                              'MyEmergencyContacts');
                                    })
                            )
                        ),
                      ]
                  )
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
        children: <Widget>[]
        );
      }

    return contactsColumn;
  }
}