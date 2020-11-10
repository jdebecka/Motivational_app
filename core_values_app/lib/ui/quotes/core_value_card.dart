import 'package:core_values_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoreValueCard extends StatelessWidget {
  final String coreValue;
  final bool isListView;

  const CoreValueCard({Key key, this.coreValue, this.isListView = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: primary_green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              coreValue,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15),
          OutlineButton(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Icon(Icons.favorite_border_outlined),
            ),
            shape: CircleBorder(),
            color: primary_green,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
