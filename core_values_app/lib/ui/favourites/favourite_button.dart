import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavouritesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: Colors.white)
      ),
      padding: const EdgeInsets.all(20),
      child: Icon(Icons.favorite_border_outlined),
    );
  }
}
