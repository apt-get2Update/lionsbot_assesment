import 'db.dart';
import 'user.dart';

class RestData {
  Future<User> login(String username, String password) async {
    var db = DatabaseHelper();
    User userRetorno = await db.checkUser(username, password);
    if (userRetorno != null) {
      return new Future.value(userRetorno);
    } else {
      return Future.error("loginfailed");
    }
  }
}
