import 'package:bloc/bloc.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:meta/meta.dart';

import '../option_enum.dart';
import '../shared_functions.dart';

part 'user_values_state.dart';

class UserValuesCubit extends Cubit<UserValuesState> {
  UserValuesCubit() : super(UserValuesInitial());

  final key = user_values_key;

  void addToUserCoreValues(String quote) async {
    var newUserValues =
        await manageStoredItems(quote: quote, key: key, option: ManageItem.add);
    _addAndEmit(newUserValues);
  }

  void deleteFromCoreValues(String quote) async {
    var newUserValues = await manageStoredItems(
        quote: quote, key: key, option: ManageItem.delete);
    _addAndEmit(newUserValues);
  }
  
  _addAndEmit(newValues) {
    newValues..addAll(core_values);
    newValues = newValues.toSet().toList();
    emit(UserValuesUpdated(newValues));
  }

  getValues() {
    getUserSavedValues(key: key).then((value) => _addAndEmit(value));
  }
}
