import 'package:drcake/constant/assets.dart';
import 'package:drcake/models/addLokaiModel.dart';
import 'package:drcake/screen/addLokasi/addDaftarLokasi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/roundedButton.dart';

class AddLokasiScreen extends StatefulWidget {
  const AddLokasiScreen({super.key});

  @override
  State<AddLokasiScreen> createState() => _AddLokasiScreenState();
}

class _AddLokasiScreenState extends State<AddLokasiScreen> {
  TextEditingController controllerNamaPengujian = TextEditingController();
  TextEditingController controllerdeskripsi = TextEditingController();
  AddLokasiModel tambahlokasi = AddLokasiModel();

  FocusNode judulFocus = FocusNode();
  FocusNode deskripsiFokus = FocusNode();
  bool pengecekanJudul = false;
  bool pengecekanDeskruipsi = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Daftar Lokasi",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          width: double.infinity,
          height: size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Nama Pengujian Lokasi"),
                      RoundedInputField(
                        controller: controllerNamaPengujian,
                        onChanged: (value) {
                          if (value != "") {
                            pengecekanJudul = false;
                          } else {
                            pengecekanJudul = true;
                          }
                          setState(() {});
                        },
                        focusNode: judulFocus,
                      ),
                      pengecekanJudul == false
                          ? Container()
                          : Text(
                              "Nama Pengujian harus diisi!",
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 12),
                            ),
                      // TextField(
                      //   controller: controllerNamaPengujian,
                      //   decoration: const InputDecoration(
                      //     // hintText: "Search Data...",
                      //     // border: InputBorder.none,
                      //     hintStyle: TextStyle(color: Colors.grey),
                      //   ),
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //   ),
                      //   onChanged: (query) {},
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Deskripsi"),
                      RoundedInputField(
                        focusNode: deskripsiFokus,
                        controller: controllerdeskripsi,
                        onChanged: (value) {
                          if (value != "") {
                            pengecekanDeskruipsi = false;
                          } else {
                            pengecekanDeskruipsi = true;
                          }
                          setState(() {});
                        },
                        maxline: 4,
                      ),
                      pengecekanDeskruipsi == false
                          ? Container()
                          : Text(
                              "Deskripsi harus diisi!",
                              style:
                                  TextStyle(color: kPrimaryColor, fontSize: 12),
                            ),
                      // TextField(
                      //   controller: controllerdeskripsi,
                      //   maxLines: 4,
                      //   decoration: const InputDecoration(
                      //     // hintText: "Search Data...",
                      //     // border: InputBorder.none,
                      //     hintStyle: TextStyle(color: Colors.grey),
                      //   ),
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //   ),
                      //   onChanged: (query) {},
                      // ),
                      const SizedBox(
                        height: 40,
                      ),
                    ]),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: RoundedButton(
                  width: 150,
                  text: "Next",
                  press: () {
                    FocusScope.of(context).unfocus();
                    if (controllerNamaPengujian.text.trim() == "") {
                      pengecekanJudul = true;
                      judulFocus.requestFocus();
                    } else if (controllerdeskripsi.text.trim() == "") {
                      pengecekanDeskruipsi = true;
                      deskripsiFokus.requestFocus();
                    } else {
                      FocusScope.of(context).unfocus();
                      pengecekanJudul = false;
                      pengecekanDeskruipsi = false;
                      tambahlokasi.apikey = "masuk321";
                      tambahlokasi.deskripsi = controllerdeskripsi.text.trim();
                      tambahlokasi.namaPengujian =
                          controllerNamaPengujian.text.trim();
                      Get.to(
                          TambahDaftarLokasi(
                            tambahLokasi: tambahlokasi,
                          ),
                          transition: Transition.rightToLeft);
                    }
                  },
                  color: kPrimaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kTextFieldColor,
      ),
      child: child,
    );
  }
}

class RoundedInputField extends StatelessWidget {
  final String? hinText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final Color? iconColor;
  final TextEditingController controller;
  final int? maxline;
  final FocusNode? focusNode;

  const RoundedInputField({
    super.key,
    this.hinText,
    this.icon,
    this.onChanged,
    this.iconColor,
    required this.controller,
    this.maxline,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        focusNode: focusNode,
        maxLines: maxline,
        controller: controller,
        onChanged: onChanged,
        decoration:
            InputDecoration(hintText: hinText, border: InputBorder.none),
      ),
    );
  }
}
