import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefernces {
  final LOGGED_USER_ID_KEY = 'tododay_logged_user_id';
  final LOGGED_USER_NAME_KEY = 'tododay_logged_user_name';
  final LOGGED_USER_EMAIL_KEY = 'tododay_logged_user_email';

  Future<void> saveUserDataToPrefs(int id, String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(LOGGED_USER_ID_KEY, id.toString());
    prefs.setString(LOGGED_USER_EMAIL_KEY, email);
    prefs.setString(LOGGED_USER_NAME_KEY, name);
  }

  Future<int?> getLoggedUserIDFromPrefs() async {
    print("============== GETTING ID FROM PREFS =============");
    final prefs = await SharedPreferences.getInstance();
    String? p = prefs.getString(LOGGED_USER_ID_KEY);
    if (p != null) {
      return int.parse(p);
    } else {
      return null;
    }
  }

  Future<String> getEmailFromPrefs() async {
    print("============== GETTING EMAIL FROM PREFS =============");
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(LOGGED_USER_EMAIL_KEY)!;
  }

  Future<String> getLoggedUserNameFromPrefs() async {
    print("============== GETTING NAME FROM PREFS =============");
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(LOGGED_USER_NAME_KEY)!;
  }

  void removeUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(LOGGED_USER_ID_KEY);
    prefs.remove(LOGGED_USER_NAME_KEY);
    prefs.remove(LOGGED_USER_EMAIL_KEY);
  }
}
