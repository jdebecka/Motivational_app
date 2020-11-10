import 'package:core_values_app/cubits/option_enum.dart';
import 'package:core_values_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getPreferences() async =>
    SharedPreferences.getInstance();

Future<List<String>> getUserSavedValues({String key}) async =>
    SharedPreferences.getInstance()
        .then((value) => value.getStringList(key) ?? []);

Future<List<String>> getValuesToDisplay(key) =>
    getUserSavedValues(key: key).then((value) => List.from(core_values)..addAll(value));

Future<List<String>> manageStoredItems({String quote, ManageItem option, String key}) async {
  var userValues = await getUserSavedValues(key: key);
  if (quote.isNotEmpty) {
    if(option == ManageItem.add)
      userValues.add(quote);
    else
      userValues.remove(quote);
    userValues = userValues.toSet().toList();
    getPreferences().then((value) => value.setStringList(key, userValues));
  }
  return userValues;
}

