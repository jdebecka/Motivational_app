import 'package:core_values_app/cubits/favourite/favourite_cubit.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesButton extends StatelessWidget {
  final String quote;

  const FavouritesButton({Key key, this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isFavourite;
    return BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          if (state is FavouritesEmpty) {
            BlocProvider.of<FavouriteCubit>(context).getFavourites();
            isFavourite = false;
          }
          else
            isFavourite = (state as FavouritesUpdated).userFavourites.contains(quote);
            return IconButton(
              onPressed: () {
                isFavourite
                    ? BlocProvider.of<FavouriteCubit>(context)
                    .deleteFromFavourites(quote)
                    : BlocProvider.of<FavouriteCubit>(context)
                    .addToFavourite(quote);
              },
              color: primary_green,
              icon: Icon(isFavourite ? Icons.favorite : Icons
                  .favorite_border_outlined),
            );
          });
  }
}

