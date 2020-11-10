import 'package:bloc/bloc.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:meta/meta.dart';

import '../option_enum.dart';
import '../shared_functions.dart';

part 'user_values_state.dart';

class UserValuesCubit extends Cubit<UserValuesState> {
  UserValuesCubit() : super(UserValuesInitial());

  final key = user_values_key;

  void addToUserCoreValues(String quote) async{
    var newUserValues = await manageStoredItems(quote: quote, key: key, option: ManageItem.add);
    emit(UserValuesUpdated(newUserValues));
  }

  void deleteFromCoreValues(String quote) async {
    if(core_values.contains(quote)){
      var newUserValues = await manageStoredItems(quote: quote, key: key, option: ManageItem.delete);
      emit(UserValuesUpdated(newUserValues));
    }
  }
  getValues() {
    getValuesToDisplay(key).then((value) => emit(UserValuesUpdated(value)));
  }
}
