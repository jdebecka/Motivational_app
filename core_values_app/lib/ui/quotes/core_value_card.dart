import 'package:core_values_app/ui/favourites/favourite_button.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoreValueCard extends StatelessWidget {
  final String coreValue;
  final bool isFavourite;

  const CoreValueCard({Key key, this.coreValue, this.isFavourite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      shadowColor: primary_green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 20,
            left: 20,
            child: Text(
              coreValue,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom: 20,
            child: FavouritesButton(),
          )
        ],
      ),
    );
  }
}
