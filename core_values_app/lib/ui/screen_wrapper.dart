import 'package:core_values_app/cubits/user_core_values/user_values_cubit.dart';
import 'package:core_values_app/ui/favourites/favourites_screen.dart';
import 'package:core_values_app/ui/quotes/quotes_list_view.dart';
import 'package:core_values_app/ui/quotes/quotes_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenWrapper extends StatefulWidget {
  @override
  _ScreenWrapperState createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  TextEditingController _textFieldController;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
  }

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
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Image.asset('assets/images/logo.png'),
        ),
        title: Text('NG Values'),
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
              Icons.format_quote,
              35,
              'Values',
              QuotesListView(),
            ),
            _getBottomIcon(
              Icons.favorite,
              28,
              'Favourites',
              FavouritesScreen(),
            ),
          ],
        ),
      ),
      body: QuotesScreen(),
    );
  }

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
              onPressed: _popWidget,
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("ADD"),
              onPressed: _addToUserValues,
            ),
          ],
        );
      },
    );
  }

  Widget _getBottomIcon(IconData iconData, double iconSize, String description,
      destination) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        child: InkWell(
          onTap: () => Navigator.of(context).push(_createRoute(destination)),
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

  _addToUserValues() {
    var quote = _textFieldController.value.text;
    BlocProvider.of<UserValuesCubit>(context).addToUserCoreValues(quote);
    _textFieldController.clear();
    _popWidget();
  }

  _popWidget() => Navigator.of(context).pop();
}
