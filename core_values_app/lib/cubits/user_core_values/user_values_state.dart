part of 'user_values_cubit.dart';

@immutable
abstract class UserValuesState {
  final List<String> valuesToBeDisplayed;

  UserValuesState(this.valuesToBeDisplayed);
}

class UserValuesInitial extends UserValuesState {
  UserValuesInitial(List<String> valuesToBeDisplayed) : super(valuesToBeDisplayed);
}

class UserValuesUpdated extends UserValuesState {
  UserValuesUpdated(List<String> valuesToBeDisplayed) : super(valuesToBeDisplayed);

}
