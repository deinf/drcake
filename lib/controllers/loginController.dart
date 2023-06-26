import 'dart:convert';

import 'package:drcake/models/login/getUserDataLogin.dart';
import 'package:drcake/screen/homeScreen/homeScreen.dart';
import 'package:drcake/utils/apiEndpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<GetUserData> getUserData = [];

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> getDataUser() async {
    getUserData.clear();
    try {
      // var headers = {'Content-type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginUser);

      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);
      List data = json;
      data.forEach((element) {
        getUserData.add(GetUserData.fromJson(element));
      });

      final SharedPreferences pref = await _prefs;

      // final Map<String, dynamic> parsed = jsonDecode(response.body);
      // getUserData = GetUserData.fromJson(parsed[0]);

      // var id = json['_id'];
      // print(json);
      // await pref.setString("id", id);

      getUserData.forEach((element) async {
        if (usernameController.text == element.username &&
            passwordController.text == element.password) {
          await pref.setString("id", element.sId!);
          await pref.setString("username", element.username!);
          await pref.setString("id", element.password!);

          Get.off(const HomeScreen(), transition: Transition.rightToLeft);
          // print(true);
        }
        // print(element.username);
      });
      usernameController.clear();
      passwordController.clear();
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Error"),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
