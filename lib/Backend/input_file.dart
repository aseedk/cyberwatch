import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget InputFile({
  label,
  obscureText = false,
  child,
  required TextEditingController controller,
  required String labelText,
  /*String hintText*/
}) {
  //obscureText false means to show the text as it is
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black87,
              ),
            ),
            border:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
      ]);
}
