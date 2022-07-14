import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lionsbot/db/rest_data.dart';
import 'package:lionsbot/db/user.dart';
import '../screen/login_screen.dart';
import '../screen/profile_screen.dart';

class AuthenticationService extends GetxService {
  bool isLogged = false;
  late String name;
  late String username;
  late String profile;

  void logOut() {
    isLogged = false;
  }

  void login(String username, String password) async {
    try {
      User user = await RestData().login(username, password);
      var usr = user.toMap();
      name = usr["name"];
      username = usr["username"];
      profile = usr["pic"];

      isLogged = true;
      Get.to(() => ProfileScreen());
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "Invalid UserName or Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void processLogout() {
    logOut();
    Get.offAll(() => LoginScreen());
  }
}
