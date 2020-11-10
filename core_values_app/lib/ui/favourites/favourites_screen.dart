import 'package:core_values_app/cubits/favourite/favourite_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favourite_button.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Core Values'),
      ),
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
          builder: (context, state) {
        if (state is FavouritesEmpty) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20),
            child: Text("It seems like you didn't like any of the quotes yet"),
          );
        } else {
          var _listToDisplay = (state as FavouritesUpdated).userFavourites;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  title: Text(_listToDisplay[index]),
                  trailing: FavouritesButton(quote: _listToDisplay[index]),
                );
              },
              itemCount: _listToDisplay.length,
            ),
          );
        }
      }),
    );
  }
}
