import 'dart:convert';

import 'package:drcake/components/roundedButton.dart';
import 'package:drcake/constant/assets.dart';
import 'package:drcake/screen/addLokasi/item/addLokasiItem.dart';
import 'package:drcake/screen/homeScreen/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/addLokaiModel.dart';
import '../../utils/apiEndpoints.dart';

class TambahDaftarLokasi extends StatefulWidget {
  AddLokasiModel tambahLokasi;

  TambahDaftarLokasi({super.key, required this.tambahLokasi});

  @override
  State<TambahDaftarLokasi> createState() => _TambahDaftarLokasiState();
}

class _TambahDaftarLokasiState extends State<TambahDaftarLokasi> {
  List<Lokasi> lokasi = [];

  @override
  void initState() {
    // TODO: implement initState
    if (widget.tambahLokasi.lokasi != null) {
      if (widget.tambahLokasi.lokasi!.length != 0) {
        widget.tambahLokasi.lokasi!.clear();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              if (widget.tambahLokasi.lokasi == null) {
                Get.back();
              } else {
                if (widget.tambahLokasi.lokasi!.isEmpty) {
                  Get.back();
                } else {
                  setState(() {
                    showDialogG();
                  });
                }
              }
            },
            child: Container(
                width: 20,
                height: 20,
                color: Colors.transparent,
                child: const Icon(Icons.arrow_back))),
        title: const Text(
          "Daftar Lokasi",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        width: double.infinity,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text("Pengujian : "),
                Text(widget.tambahLokasi.namaPengujian!),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            widget.tambahLokasi.lokasi == null
                ? Expanded(
                    child: Container(
                        alignment: Alignment.center, child: nullScreen()))
                : widget.tambahLokasi.lokasi!.length == 0
                    ? Expanded(
                        child: Container(
                            alignment: Alignment.center, child: nullScreen()))
                    : Expanded(
                        child: ListView.builder(
                            itemCount: widget.tambahLokasi.lokasi?.length ?? 0,
                            itemBuilder: (context, item) {
                              return Card(
                                surfaceTintColor: Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        child: Row(children: [
                                          Text((item + 1).toString()),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                              child: Text(
                                            "${widget.tambahLokasi.lokasi?[item].namaLokasi}",
                                            style: const TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              var data = await Get.to(
                                                  TambahLokasiItem(
                                                    isEdit: true,
                                                    lokasi: widget.tambahLokasi
                                                        .lokasi?[item],
                                                    index: item,
                                                  ),
                                                  transition:
                                                      Transition.rightToLeft);
                                              lokasi.add(data['lokasi']);

                                              if (data['lokasi'] != null) {
                                                // print("ini lo $data");
                                                // widget.tambahLokasi.lokasi
                                                //     ?.add(Lokasi(namaLokasi: "ADSDD"));
                                                if (data['isEdit'] == true) {
                                                  // print("ini ele");
                                                  widget.tambahLokasi.lokasi
                                                      ?.removeAt(data['index']);
                                                  widget.tambahLokasi.lokasi =
                                                      lokasi;
                                                }

                                                setState(() {});
                                              }
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                )),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              widget.tambahLokasi.lokasi
                                                  ?.removeAt(item);
                                              setState(() {});
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
            Row(
              children: [
                Expanded(
                  child: RoundedButton(
                    text: "Tambah",
                    press: () async {
                      var data = await Get.to(const TambahLokasiItem(),
                          transition: Transition.rightToLeft);

                      lokasi.add(data['lokasi']);

                      if (data['lokasi'] != null) {
                        // print("ini lo $data");
                        // widget.tambahLokasi.lokasi
                        //     ?.add(Lokasi(namaLokasi: "ADSDD"));

                        widget.tambahLokasi.lokasi = lokasi;

                        // print(widget.tambahLokasi.lokasi?.length);
                        setState(() {});
                      }

                      // print(widget.tambahLokasi.namaPengujian);
                      // print(widget.tambahLokasi.deskripsi);
                      // print(widget.tambahLokasi.apikey);
                      // widget.tambahLokasi.lokasi?.forEach((element) {
                      //   // print("ini element ${element.namaLokasi}");
                      // });
                    },
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RoundedButton(
                    text: "Simpan",
                    press: () {
                      // print(widget.tambahLokasi.lokasi!.length);
                      if (widget.tambahLokasi.lokasi != null) {
                        if (widget.tambahLokasi.lokasi!.length != 0) {
                          loadingDialog();
                        } else {
                          showDialog(
                              context: Get.context!,
                              builder: (context) {
                                return const SimpleDialog(
                                  title: Text("Error"),
                                  contentPadding: EdgeInsets.all(20),
                                  children: [
                                    Text("Masukkan paling tidak 2 data lokasi")
                                  ],
                                );
                              });
                        }
                      } else {
                        showDialog(
                            context: Get.context!,
                            builder: (context) {
                              return const SimpleDialog(
                                title: Text("Error"),
                                contentPadding: EdgeInsets.all(20),
                                children: [
                                  Text("Masukkan paling tidak 2 data lokasi")
                                ],
                              );
                            });
                      }
                    },
                    color: kPrimaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Future<void> sendDataLokasi() async {
    try {
      var headers = {'Content-type': 'application/json'};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.getCabang);

      // print(jsonEncode(body));

      http.Response response = await http.post(url,
          body: jsonEncode(widget.tambahLokasi), headers: headers);

      final json = jsonDecode(response.body);

      Get.offAll(const HomeScreen(), transition: Transition.rightToLeft);
    } catch (e) {
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
                  "Data akan dihapus, yakin untuk kembali?",
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
                  Navigator.of(context).pop();
                  Get.back();
                })
          ],
        );
      },
    );
  }

  Widget nullScreen() {
    return Column(
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
      ],
    );
  }

  loadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            alignment: Alignment.center,
            height: 150,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Loading"),
              ],
            ),
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context); //pop dialog
      // _login();
      sendDataLokasi();
    });
  }
}
