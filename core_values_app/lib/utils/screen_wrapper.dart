import 'package:core_values_app/ui/favourites/favourites_screen.dart';
import 'package:core_values_app/ui/quotes/quotes_list_view.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenWrapper extends StatefulWidget {
  final child;
  final childIndex;

  ScreenWrapper({Key key, this.child, this.childIndex}) : super(key: key);

  @override
  _ScreenWrapperState createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  TextEditingController _textFieldController = TextEditingController();

  Route _createRoute(nextPage) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  _addNewCoreValue(String quote) async {
    final preferences = await SharedPreferences.getInstance();
    var userValues =
        preferences.getStringList(user_values) ?? List<String>();
    if (quote.isNotEmpty) {
      userValues.add(quote);
      preferences.setStringList(user_values, userValues);
    }
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Add Your Core Value'),
          content: Card(
            color: Colors.transparent,
            elevation: 0.0,
            child: Column(
              children: [
                TextField(
                  minLines: 1,
                  maxLines: 5,
                  controller: _textFieldController,
                  decoration:
                      InputDecoration(hintText: "Enter your core value"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text("CANCEL"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("ADD"),
                onPressed: () {
                  setState(() {
                    _addNewCoreValue(_textFieldController.value.text);
                    _textFieldController.clear();
                  });
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  Widget _getBottomIcon(IconData iconData, double iconSize,
      String description, destination) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: InkWell(
          onTap: () => Navigator.of(context).pushAndRemoveUntil(_createRoute(destination), (Route<dynamic> route) => route.isFirst),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        onPressed: () => _displayDialog(context),
      ),
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
        ),
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
              widget.childIndex == 0
                  ? Icons.format_quote_sharp
                  : Icons.format_quote_outlined,
              35,
              'Values',
              QuotesListView(),
            ),
            _getBottomIcon(
              widget.childIndex == 1
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              28,
              'Favourites',
              FavouritesScreen(),
            ),
          ],
        ),
      ),
      body: widget.child,
    );
  }
}
