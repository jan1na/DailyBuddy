import 'package:flutter/material.dart';

class ConfirmationButton extends StatelessWidget {
  final IconData icon;
  final String lable;
  final Color color;
  final Function onPressed;

  ConfirmationButton({this.lable, this.icon, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          GestureDetector(
            onTap: () {
              onPressed();
            },
            child: Container(
              alignment: Alignment(0.0, 0.0),
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  lable,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ]));
  }
}
