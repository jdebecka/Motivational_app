import 'package:bloc/bloc.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import '../shared_functions.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());
  final key = favourite_key;

  void addToFavourite(String quote) {
    addNewCoreValue(quote: quote, key: key);
  }

  void deleteFromFavourites(String quote) async {
    deleteCoreValue(quote: quote, key: key);
    getFavourites();
  }

  Future getFavourites() async {
    List<String> userFavourites = await getUserSavedValues();
    userFavourites.isNotEmpty ? emit(FavouritesUpdated(userFavourites)) : emit(FavouritesEmpty());
  }
}
