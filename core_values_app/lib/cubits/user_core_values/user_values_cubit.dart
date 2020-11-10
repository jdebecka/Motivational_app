import 'package:bloc/bloc.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:meta/meta.dart';

import '../shared_functions.dart';

part 'user_values_state.dart';

class UserValuesCubit extends Cubit<UserValuesState> {
  UserValuesCubit() : super(UserValuesInitial());

  final key = user_values_key;

  void addToUserCoreValues(String quote) {
    addNewCoreValue(quote: quote, key: key);
    getValues();
  }

  getValues() {
    getValuesToDisplay().then((value) => emit(UserValuesUpdated(value)));
  }
}
