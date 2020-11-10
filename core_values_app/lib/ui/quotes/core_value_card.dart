import 'package:core_values_app/ui/favourites/favourite_button.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoreValueCard extends StatelessWidget {
  final String coreValue;

  const CoreValueCard({Key key, this.coreValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      shadowColor: primary_green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Text(
                  coreValue,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Ink(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: primary_green)),
                  child: FavouritesButton(key: key, quote: coreValue)),
            )
          ],
        ),
      ),
    );
  }
}
