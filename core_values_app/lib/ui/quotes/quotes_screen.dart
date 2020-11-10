import 'dart:async';
import 'dart:math';
import 'package:core_values_app/ui/quotes/core_value_card.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:core_values_app/utils/screen_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesScreen extends StatefulWidget {
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen>
    with TickerProviderStateMixin {
  List<String> _coreValuesToDisplay;
  AnimationController _controller;
  String _currentText;
  int _currentIndex;
  Timer _timer;
  SharedPreferences preferences;

  _changeText(AnimationStatus status) {
    if (status == AnimationStatus.forward)
      setState(() {
        _currentIndex = _getRandomIndex();
        _currentText = _coreValuesToDisplay[_currentIndex];
      });
  }

  @override
  void initState() {
    super.initState();
    _coreValuesToDisplay = List.from(core_values);
    _currentIndex = _getRandomIndex();
    _currentText = _coreValuesToDisplay[_currentIndex];
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.repeat(reverse: true);
    _controller.addStatusListener(_changeText);
  }

  int _getRandomIndex() => Random().nextInt(_coreValuesToDisplay.length);

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  _getPreferences() async {
    preferences = await SharedPreferences.getInstance();
    _getUserSavedValues();
  }
  _getUserSavedValues() {
    setState(() {
      _coreValuesToDisplay.addAll(preferences.getStringList(user_values) ?? []);
      _coreValuesToDisplay =_coreValuesToDisplay.toSet().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenAdjustmentMultiplier = size.height < 700 ? 0.6 : 0.45;
    final offsetAdjustment = size.height < 700 ? 0.15 : 0.4;
    _getPreferences();

    return ScreenWrapper(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        height: size.height * screenAdjustmentMultiplier,
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                child: child,
                position: Tween<Offset>(
                        begin: Offset(0, -1),
                        end: Offset(0.0, offsetAdjustment))
                    .animate(animation),
              );
            },
            child: CoreValueCard(
              key: ValueKey<int>(_currentIndex),
              coreValue: _currentText,
            )),
      ),
    );
  }
}
