import 'package:bloc/bloc.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:core_values_app/utils/functions.dart';
import 'package:meta/meta.dart';

part 'user_values_state.dart';

class UserValuesCubit extends Cubit<UserValuesState> {
  UserValuesCubit() : super(UserValuesInitial(List<String>()));

  void addToUserCoreValues(String quote) {
    _addNewCoreValue(quote);
  }

  getValues() {
    valuesToDisplay().then((value) => emit(UserValuesUpdated(value)));
  }

  _addNewCoreValue(String quote) async {
    var userValues = await getUserSavedValues();
    if (quote.isNotEmpty) {
      userValues.add(quote);
      userValues = userValues.toSet().toList();
      getPreferences()
          .then((value) => value.setStringList(user_values_key, userValues));
    }
    return getValues();
  }
}
