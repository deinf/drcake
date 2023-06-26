import 'dart:convert';

import 'package:drcake/utils/apiEndpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../screen/homeScreen/homeScreen.dart';

class RegistrationController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> registerUser() async {
    try {
      if (usernameController.text != "") {
        if (passwordController.text != "") {
          var headers = {'Content-type': 'application/json'};
          var url = Uri.parse(
              ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.registerUser);
          Map body = {
            "username": usernameController.text.trim(),
            "password": passwordController.text,
            "apikey": "masuk321"
          };
          // print(url);
          // print(jsonEncode(body));

          http.Response response =
              await http.post(url, body: jsonEncode(body), headers: headers);
          final SharedPreferences pref = await _prefs;
          final json = jsonDecode(response.body);
          var id = json['_id'];

          // print(json);
          await pref.setString("id", id);
          await pref.setString("username", json['username']);
          await pref.setString("id", json['password']);
          usernameController.clear();
          passwordController.clear();
          Get.off(const HomeScreen(), transition: Transition.rightToLeft);
        } else {
          showDialog(
              context: Get.context!,
              builder: (context) {
                return const SimpleDialog(
                  // title: const Text("Error"),
                  contentPadding: EdgeInsets.all(20),
                  children: [Text("Isi Password")],
                );
              });
        }
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return const SimpleDialog(
                // title: const Text(""),
                contentPadding: EdgeInsets.all(20),
                children: [Text("Isi Username")],
              );
            });
      }
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
