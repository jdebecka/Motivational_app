import 'package:core_values_app/cubits/favourite/favourite_cubit.dart';
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
            appBar: AppBar(
              title: Text('Core Values'),
            ),
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return core_values.contains(_listToDisplay[index])
                    ? _getChildListTile(index)
                    : Dismissible(
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.red,
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    BlocProvider.of<UserValuesCubit>(context)
                        .deleteFromCoreValues(_listToDisplay[index]);
                    BlocProvider.of<FavouriteCubit>(context)
                        .deleteFromFavourites(_listToDisplay[index]);
                  },
                  key: ValueKey<String>(_listToDisplay[index]),
                  child: _getChildListTile(index),
                );
              },
              itemCount: _listToDisplay.length,
            ),
          );
        }
      },
    );
  }

  _getChildListTile(index) =>
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: primary_green))),
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
