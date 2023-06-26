import 'dart:convert';

import 'package:drcake/models/getCabangData.dart';
import 'package:drcake/models/login/getUserDataLogin.dart';
import 'package:drcake/utils/apiEndpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DaftarCabangController extends GetxController {
  List<DaftarCabang> getDaftarCabang = [];
  TextEditingController controller = TextEditingController();

  Future<void> getDaftarCabangData() async {
    getDaftarCabang.clear();
    try {
      // var headers = {'Content-type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.getCabang);

      http.Response response = await http.get(url);

      final json = jsonDecode(response.body);
      List data = json;
      data.forEach((element) {
        getDaftarCabang.add(DaftarCabang.fromJson(element));
      });

      // print(getDaftarCabang);
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
