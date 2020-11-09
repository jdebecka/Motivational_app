import 'package:core_values_app/favourites/favourites_screen.dart';
import 'package:core_values_app/quotes/quotes_screen.dart';
import 'package:core_values_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _getBottomIcon(IconData iconData, String description, destination) =>
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
          child: InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => destination)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                  size: 29,
                ),
                Text(
                  description,
                  style: TextStyle(color: Colors.white),
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
        backgroundColor: primary_green,
      ),
      bottomNavigationBar: BottomAppBar(
        color: primary_green,
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _getBottomIcon(
                Icons.format_quote_sharp, 'Values', QuotesScreen()),
            _getBottomIcon(Icons.favorite, 'Favourites', FavouritesScreen()),
          ],
        ),
      ),
      body: QuotesScreen(),
    );
  }
}
