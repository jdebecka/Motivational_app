import 'dart:async';
import 'dart:math';

import 'package:core_values_app/utils/constants.dart';
import 'package:core_values_app/utils/screen_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuotesScreen extends StatefulWidget {
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String _currentText;
  int _currentIndex;
  Timer _timer;

  _changeText(AnimationStatus status) {
    if (status == AnimationStatus.forward)
      setState(() {
        _currentIndex =
            _currentIndex < core_values.length - 1 ? _currentIndex + 1 : 0;
        _currentText = core_values[_currentIndex];
      });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _currentText = core_values[_currentIndex];
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _controller.repeat(reverse: true);
    _controller.addStatusListener(_changeText);
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: FadeTransition(
          opacity: _controller,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(
                child: child,
                position:
                    Tween<Offset>(begin: Offset(1, 0), end: Offset(0.0, 0))
                        .animate(animation),
              );
            },
            child: Text(
              _currentText,
              style: Theme.of(context).textTheme.bodyText1,
              key: ValueKey<int>(_currentIndex),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
