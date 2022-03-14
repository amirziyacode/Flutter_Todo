import 'package:shared_preferences/shared_preferences.dart';

class TaskerPreference {
  static SharedPreferences? _preferences;

  static const _IsSelect = "all_selected_tasks";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setStringList(List<String> allSelectedTasks) async =>
      await _preferences?.setStringList(_IsSelect, allSelectedTasks);

  static List<String>? getString() =>_preferences?.getStringList(_IsSelect);
}
