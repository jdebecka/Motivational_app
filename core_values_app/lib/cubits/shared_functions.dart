import 'package:core_values_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> getPreferences() async =>
    await SharedPreferences.getInstance();

Future<List<String>> getUserSavedValues({String key}) async =>
    await SharedPreferences.getInstance()
        .then((value) => value.getStringList(key) ?? []);

Future<List<String>> getValuesToDisplay() =>
    getUserSavedValues().then((value) => List.from(core_values)..addAll(value));

void addNewCoreValue({String quote, String key}) async {
  var userValues = await getUserSavedValues(key: key);
  if (quote.isNotEmpty) {
    userValues.add(quote);
    userValues = userValues.toSet().toList();
    getPreferences().then((value) => value.setStringList(key, userValues));
  }
}

void deleteCoreValue({String quote, String key}) async {
  var userValues = await getUserSavedValues(key: key);
  if (quote.isNotEmpty) {
    var didDelete = userValues.remove(quote);
    if (didDelete)
      print('Yaaas');
      getPreferences().then((value) => value.setStringList(key, userValues));
  }
}
