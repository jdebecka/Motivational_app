part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouritesUpdated extends FavouriteState{
  final List<String> userFavourites;

  FavouritesUpdated(this.userFavourites);
}

class FavouritesEmpty extends FavouriteState{}
