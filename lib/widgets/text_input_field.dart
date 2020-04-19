import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class TextInputField extends StatelessWidget {
  TextInputField(
      {this.icon,
      this.hint,
      this.obsecure = false,
      this.validator,
      this.onSaved});
  final FormFieldSetter<String> onSaved;
  final Icon icon;
  final String hint;
  final bool obsecure;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      child: TextFormField(
        //child: TextFieldBlocBuilder(
        onSaved: onSaved,
        //validator: validator,
        autofocus: true,
        obscureText: obsecure,
        style: TextStyle(
          height: 0.6,
          fontSize: 20,
          color: Color(0xff682F75),
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).primaryColor),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
            prefixIcon: icon != null
                ? Padding(
                    child: IconTheme(
                      data:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      child: icon,
                    ),
                    padding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 10),
                  )
                : SizedBox(
                    height: 1,
                  )),
      ),
    );
  }
}
