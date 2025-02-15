import 'package:shared_preferences/shared_preferences.dart';

const userLoggedIn = 'user';
const userRegisterd = 'userRegisterd';

class SharedPreferenceDatas {
  sharedPrefSignup() async {
    final sharedpref = await SharedPreferences.getInstance();
    final value = await sharedpref.setBool(userRegisterd, true);
  }

  sharedPrefSignIn() async {
    final sharedpref = await SharedPreferences.getInstance();
    final value = await sharedpref.setBool(userLoggedIn, true);
  }

  sharedPrefLeftTeam() async {
    final sharedpref = await SharedPreferences.getInstance();
    final value = await sharedpref.setBool(userLoggedIn, false);
  }

  logout() async {
    final sharedpref = await SharedPreferences.getInstance();
    final value = await sharedpref.setBool(userLoggedIn, false);

    final value2 = await sharedpref.setBool(userRegisterd, false);
  }
}
