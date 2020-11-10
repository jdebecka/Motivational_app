import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  void addToFavourite(String quote) => emit(state);
}
