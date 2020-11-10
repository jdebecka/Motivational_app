import 'dart:math';
import 'package:core_values_app/cubits/user_core_values/user_values_cubit.dart';
import 'package:core_values_app/ui/quotes/core_value_card.dart';
import 'package:core_values_app/ui/screen_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesScreen extends StatefulWidget {
  @override
  _QuotesScreenState createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen>
    with TickerProviderStateMixin {
  List<String> _coreValuesToDisplay;
  AnimationController _animationController;
  String _currentText;
  int _currentIndex;
  SharedPreferences preferences;

  _changeText(AnimationStatus status) {
    if (status == AnimationStatus.forward)
      setState(
        () {
          _currentIndex = _getRandomIndex();
          _currentText = _coreValuesToDisplay[_currentIndex];
        },
      );
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animationController.addStatusListener(_changeText);
  }

  int _getRandomIndex() => Random().nextInt(_coreValuesToDisplay.length);

  void startAnimating() {
    _currentIndex = _getRandomIndex();
    _currentText = _coreValuesToDisplay[_currentIndex];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenAdjustmentMultiplier = size.height < 700 ? 0.6 : 0.45;
    final offsetAdjustment = size.height < 700 ? 0.15 : 0.4;

    return Scaffold(
      body: BlocBuilder<UserValuesCubit, UserValuesState>(
          builder: (context, state) {
        if (state is UserValuesInitial) {
          _coreValuesToDisplay =
              BlocProvider.of<UserValuesCubit>(context).getValues();
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          _coreValuesToDisplay = state.valuesToBeDisplayed;
          startAnimating();

          return Container(
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
          );
        }
      }),
    );
  }
}
