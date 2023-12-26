class StoreUserData {
//  SharedPreferences prefs = await SharedPreferences.getInstance();

  Future<void> setAuthToken(String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(tokenKey, token);
  }
}
