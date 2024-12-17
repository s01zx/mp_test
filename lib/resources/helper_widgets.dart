// Application helper widgets

//Text widget
import 'package:flutter/material.dart';
import 'package:mp_test/resources/helper_functions.dart';

Widget appText(String tx, double size,
    {FontWeight weight = FontWeight.w400,
    topmargin = 0.0,
    bottommargin = 0.0,
    leftmargin = 0.0,
    rightmargin = 0.0,
    TextAlign align = TextAlign.center,
    Color color = Colors.black, //color0f17,
    double? space,
    double? height,
    bool softwrap = true,
    TextOverflow? overflow,
    TextDecoration? decoration,
    int? maxlines,
    FontStyle fontStyle = FontStyle.normal}) {
  return Container(
    margin: EdgeInsets.only(
        top: calculateSize(topmargin),
        bottom: calculateSize(bottommargin),
        left: calculateSize(leftmargin, useWidth: true),
        right: calculateSize(rightmargin, useWidth: true)),
    child: Text(
      tx,
      softWrap: softwrap,
      overflow: overflow,
      maxLines: maxlines,
      textAlign: align,
      style: TextStyle(
          decoration: decoration,
          fontSize: calculateSize(size),
          fontWeight: weight,
          fontStyle: fontStyle,
          color: color,
          letterSpacing: space,
          height: height),
    ),
  );
}

Widget verticalspace(height) {
  return SizedBox(
    height: calculateSize(height),
  );
}

Widget horizontalspace(width) {
  return SizedBox(
    width: calculateSize(width, useWidth: true),
  );
}
