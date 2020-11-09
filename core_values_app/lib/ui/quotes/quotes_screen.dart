import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      alignment: Alignment.center,
      child: Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specim",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }
}
