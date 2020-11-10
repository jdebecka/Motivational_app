import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

Future<SharedPreferences> getPreferences() async => await SharedPreferences.getInstance();

Future<List<String>> getUserSavedValues() async => await SharedPreferences.getInstance().then((value) => value.getStringList(user_values_key) ?? []);

Future<List<String>> valuesToDisplay() => getUserSavedValues().then((value) => List.from(core_values)..addAll(value));
