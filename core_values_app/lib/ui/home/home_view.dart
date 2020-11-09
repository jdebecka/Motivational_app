import 'package:core_values_app/ui/favourites/favourites_screen.dart';
import 'package:core_values_app/ui/quotes/quotes_screen.dart';
import 'package:core_values_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _getBottomIcon(IconData iconData, double iconSize, String description, destination) =>
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => destination)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  iconData,
                  size: iconSize,
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      appBar: AppBar(
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getBottomIcon(
                Icons.format_quote_sharp, 35, 'Values', QuotesScreen()),
            _getBottomIcon(Icons.favorite, 28, 'Favourites', FavouritesScreen()),
          ],
        ),
      ),
      body: QuotesScreen(),
    );
  }
}
