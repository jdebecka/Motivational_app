part of 'user_values_cubit.dart';

@immutable
abstract class UserValuesState {
  UserValuesState();
}

class UserValuesInitial extends UserValuesState {}

class UserValuesUpdated extends UserValuesState {
  final List<String> valuesToBeDisplayed;

  UserValuesUpdated(this.valuesToBeDisplayed);
}
