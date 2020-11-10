import 'package:core_values_app/cubits/user_core_values/user_values_cubit.dart';
import 'package:core_values_app/ui/favourites/favourite_button.dart';
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
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: ValueKey<int>(index),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    title: Text(_listToDisplay[index]),
                    trailing: FavouritesButton(quote: _listToDisplay[index]),
                  ),
                );
              },
              itemCount: _listToDisplay.length,
            ),
          ),
        );
      }
    });
  }
}
