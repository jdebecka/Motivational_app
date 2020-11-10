import 'package:core_values_app/utils/constants.dart';
import 'package:core_values_app/utils/screen_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuotesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: ValueKey<int>(index),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                title: Text(core_values[index]),
              ),
            );
          },
          itemCount: core_values.length,
        ),
      ),
      childIndex: 0,
    );
  }
}
