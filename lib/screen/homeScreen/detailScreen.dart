import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/roundedButton.dart';
import '../../constant/assets.dart';
import '../../models/getCabangData.dart';
import '../../utils/apiEndpoints.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DetaiLLokasiScreen extends StatefulWidget {
  List<Lokasi>? lokasi = [];
  String? namaLokasi;
  String? id;
  DetaiLLokasiScreen({super.key, this.lokasi, this.namaLokasi, this.id});

  @override
  State<DetaiLLokasiScreen> createState() => _DetaiLLokasiScreenState();
}

class _DetaiLLokasiScreenState extends State<DetaiLLokasiScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.white,
              leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      color: Colors.transparent,
                      height: 20,
                      width: 20,
                      child: const Icon(Icons.arrow_back))),
              centerTitle: true,
              title: const Text(
                "Detail Lokasi",
                style: TextStyle(fontSize: 16),
              )),
          body: SizedBox(
            width: double.infinity,
            height: size.height,
            child: Column(
              children: [
                Image.asset(
                  Assets.locationImg,
                  width: size.width * 0.5,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Text("Nama Pengujian : "),
                      Text(
                        widget.namaLokasi.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.lokasi!.length,
                      itemBuilder: (context, item) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          width: size.width,
                          // height: 100,
                          child: Card(
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            child: ExpansionTile(
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              childrenPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: const Border(),
                              title: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    rowData(
                                        data1: widget.lokasi![item].ranking
                                            .toString(),
                                        title1: "Rangking",
                                        data2: widget.lokasi![item].namaLokasi
                                            .toString(),
                                        title2: "Lokasi",
                                        data3: widget.lokasi![item].score!
                                            .toStringAsFixed(3)
                                            .toString(),
                                        title3: "Score"),
                                  ],
                                ),
                              ),
                              children: <Widget>[
                                const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  "Detail",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 14, color: kPrimaryColor),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Nama Lokasi",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      widget.lokasi![item].namaLokasi!,
                                      style: const TextStyle(
                                          fontSize: 14, color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Luas Lokasi",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      NumberFormat()
                                          .format(widget.lokasi![item].luas)
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 14, color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Kepadatan Penduduk",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      NumberFormat()
                                          .format(widget
                                              .lokasi![item].kepadatanpenduduk)
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 14, color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Kantor Terdekat",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      NumberFormat()
                                          .format(widget
                                              .lokasi![item].kantorterdekat)
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 14, color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Toko Kue Terdekat",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      NumberFormat()
                                          .format(widget
                                              .lokasi![item].tokokueterdekat)
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 14, color: kPrimaryColor),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                RoundedButton(
                  text: "Hapus Lokasi",
                  press: () {
                    showDialogG();
                  },
                  width: size.width * 0.9,
                  color: kPrimaryColor,
                )
              ],
            ),
          )),
    );
  }

  Widget rowData(
      {String? data1,
      String? title1,
      String? data2,
      String? title2,
      String? data3,
      String? title3}) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data1 ?? "",
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              title1 ?? "",
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            )
          ],
        ),
        const SizedBox(
          width: 30,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data2 ?? "",
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis, fontSize: 14),
              ),
              Text(
                title2 ?? "",
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              )
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data3 ?? "", style: const TextStyle(fontSize: 14)),
            Text(
              title3 ?? "",
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            )
          ],
        )
      ],
    );
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
                  "Data akan dihapus, yakin untuk hapus?",
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
                onPressed: () async {
                  Navigator.of(context).pop();
                  try {
                    var url = Uri.parse(
                        "${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.getCabang}/${widget.id!}");

                    // print(url);
                    // print(jsonEncode(body));

                    http.Response response = await http.delete(url);

                    final json = jsonDecode(response.body);

                    // print(json);
                    Get.back(result: {"data": "hapus"});
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
                })
          ],
        );
      },
    );
  }
}
