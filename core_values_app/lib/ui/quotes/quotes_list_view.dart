import 'package:core_values_app/cubits/user_core_values/user_values_cubit.dart';
import 'package:core_values_app/ui/favourites/favourite_button.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuotesListView extends StatefulWidget {
  @override
  _QuotesListViewState createState() => _QuotesListViewState();
}

class _QuotesListViewState extends State<QuotesListView> {
  List<String> _listToDisplay;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserValuesCubit, UserValuesState>(
      builder: (context, state) {
        if (state is UserValuesInitial) {
          BlocProvider.of<UserValuesCubit>(context).getValues();
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          _listToDisplay = (state as UserValuesUpdated).valuesToBeDisplayed;
          return Scaffold(
            appBar: AppBar(),
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return core_values.contains(_listToDisplay[index])
                    ? getChildListTile(index)
                    : Dismissible(
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          BlocProvider.of<UserValuesCubit>(context)
                              .deleteFromCoreValues(_listToDisplay[index]);
                        },
                        key: ValueKey<int>(index),
                        child: getChildListTile(index),
                      );
              },
              itemCount: _listToDisplay.length,
            ),
          );
        }
      },
    );
  }

  getChildListTile(index) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: primary_green, blurRadius: 2)],
            color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.grey[400] : Colors.white,
            border: Border.all(color: primary_green)),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Text(_listToDisplay[index]),
            ),
            Expanded(
              flex: 1,
              child: FavouritesButton(quote: _listToDisplay[index]),
            )
          ],
        ),
      );
}
