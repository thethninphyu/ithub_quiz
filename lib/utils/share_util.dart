import 'package:shared_preferences/shared_preferences.dart';

class StoreUserData {
  setRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("ROLE", role);
  }

  getRole() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString("ROLE");
  }
}
