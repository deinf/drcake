import 'dart:convert';

import 'package:drcake/components/roundedButton.dart';
import 'package:drcake/components/roundedInputField.dart';
import 'package:drcake/constant/assets.dart';
import 'package:drcake/controllers/getDataCabang.dart';
import 'package:drcake/models/getCabangData.dart';
import 'package:drcake/screen/addLokasi/addLokasi.dart';
import 'package:drcake/screen/homeScreen/detailScreen.dart';
import 'package:drcake/screen/welcome/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/apiEndpoints.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // DaftarCabangController dataController = Get.put(DaftarCabangController());
  List<DaftarCabang> getDaftarCabang = [];
  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  Future<void> getDataCabangD() async {
    isLoading = true;
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
      setState(() {});
      isLoading = false;

      // print(getDaftarCabang);
    } catch (e) {
      isLoading = false;
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

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getDataCabangD();
      setState(() {});
    });

    super.initState();
  }

  Future<bool> _onWillPop() async {
    return (await showDialogG()) ?? false;
  }

  Future<void> _onRefresh() async {
    getDataCabangD();
    setState(() {});
  }

  showDialogG() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Alert')),
          content: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  "Apakah anda yakin untuk keluar aplikasi?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  SystemNavigator.pop();
                })
          ],
        );
      },
    );
  }

  void searchBook(String query) {
    final suggestion = getDaftarCabang.where((element) {
      final namaLokasi = element.namaPengujian?.toLowerCase();
      final input = query.toLowerCase();

      return namaLokasi!.contains(input);
    }).toList();

    setState(() {
      getDaftarCabang = suggestion;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            leading: GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  await prefs.remove("id");
                  await prefs.remove("username");
                  await prefs.remove("id");
                  Get.off(WelcomeScreen(), transition: Transition.rightToLeft);
                },
                child: Icon(Icons.logout_outlined)),
            title: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Search Data...",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (query) {
                if (query == "") {
                  _onRefresh();
                } else {
                  searchBook(query);
                }
              },
            ),
          ),
          body: body(size = size),
        ),
      ),
    );
  }

  int data = 0;
  Widget body(Size size) {
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Column(
        children: [
          Expanded(
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
                : getDaftarCabang == null
                    ? Container()
                    : getDaftarCabang.length == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.noData,
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Tidak ada data"),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  getDataCabangD();
                                  setState(() {});
                                },
                                child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: kPrimmaryColorLight,
                                        borderRadius: BorderRadius.circular(8)),
                                    alignment: Alignment.center,
                                    child: const Text("Refresh",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white))),
                              )
                            ],
                          )
                        : RefreshIndicator(
                            color: kPrimaryColor,
                            onRefresh: _onRefresh,
                            child: ListView.builder(
                                itemCount: getDaftarCabang.length,
                                itemBuilder: (context, item) {
                                  return GestureDetector(
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                      getDaftarCabang[item].lokasi!.sort(
                                            (a, b) => a.ranking!
                                                .compareTo(b.ranking!),
                                          );
                                      var data = await Get.to(
                                          DetaiLLokasiScreen(
                                            id: getDaftarCabang[item].sId,
                                            lokasi:
                                                getDaftarCabang[item].lokasi,
                                            namaLokasi: getDaftarCabang[item]
                                                .namaPengujian,
                                          ),
                                          transition: Transition.rightToLeft);
                                      if (data['data'] == "hapus") {
                                        _onRefresh();
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 5),
                                      width: size.width,
                                      height: 130,
                                      // decoration: new BoxDecoration(boxShadow: [
                                      //   CustomBoxShadow(
                                      //       color: Colors.black,
                                      //       offset: Offset(5.0, 5.0),
                                      //       blurRadius: 5.0,
                                      //       blurStyle: BlurStyle.outer)
                                      // ]),
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 3,
                                        surfaceTintColor: Colors.white,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  8))),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.location_city,
                                                            color:
                                                                kPrimmaryColorLight,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            getDaftarCabang[
                                                                    item]
                                                                .namaPengujian!,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                        getDaftarCabang[item]
                                                            .deskripsi!,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 20),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      width: size.width,
                                                      child: const Text(
                                                        "Detail",
                                                        style: TextStyle(
                                                            color:
                                                                kPrimmaryColorLight),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
          ),
          RoundedButton(
            text: "Daftar Lokasi Baru",
            press: () {
              FocusScope.of(context).unfocus();
              Get.to(const AddLokasiScreen(),
                  transition: Transition.rightToLeft);
            },
            width: size.width * 0.9,
            color: kPrimaryColor,
          )
        ],
      ),
    );
  }
}

class CustomBoxShadow extends BoxShadow {
  final BlurStyle blurStyle;

  const CustomBoxShadow({
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    this.blurStyle = BlurStyle.normal,
  }) : super(color: color, offset: offset, blurRadius: blurRadius);

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(this.blurStyle, blurSigma);
    assert(() {
      if (debugDisableShadows) result.maskFilter = null;
      return true;
    }());
    return result;
  }
}
