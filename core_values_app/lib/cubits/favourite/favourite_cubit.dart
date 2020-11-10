import 'package:bloc/bloc.dart';
import 'package:core_values_app/cubits/option_enum.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import '../shared_functions.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouritesEmpty());
  final key = favourite_key;

  void addToFavourite(String quote) async {
    var newUserValues =
        await manageStoredItems(quote: quote, key: key, option: ManageItem.add);
    emit(FavouritesUpdated(newUserValues));
  }

  void deleteFromFavourites(String quote) async {
    var newUserValues = await manageStoredItems(
        quote: quote, key: key, option: ManageItem.delete);
    _checkIfEmptyEmitState(newUserValues);
  }

  Future getFavourites() async {
    List<String> userFavourites = await getUserSavedValues(key: key);
    _checkIfEmptyEmitState(userFavourites);
  }

  _checkIfEmptyEmitState(newUserValues) {
    newUserValues.isNotEmpty
        ? emit(FavouritesUpdated(newUserValues))
        : emit(FavouritesEmpty());
  }
}
