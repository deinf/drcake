import 'package:drcake/components/roundedButton.dart';
import 'package:drcake/constant/assets.dart';
import 'package:drcake/models/addLokaiModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TambahLokasiItem extends StatefulWidget {
  final bool isEdit;
  final int? index;
  final Lokasi? lokasi;
  const TambahLokasiItem({
    super.key,
    this.isEdit = false,
    this.lokasi,
    this.index,
  });

  @override
  State<TambahLokasiItem> createState() => _TambahLokasiItemState();
}

class _TambahLokasiItemState extends State<TambahLokasiItem> {
  TextEditingController namaLokasi = TextEditingController();
  TextEditingController luasLokasi = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController kepadatan = TextEditingController();
  TextEditingController kantorTerdekat = TextEditingController();
  TextEditingController tokoKueTerdekat = TextEditingController();
  FocusNode namaLokasifocus = FocusNode();
  FocusNode luasLokasiFocus = FocusNode();
  FocusNode hargafocus = FocusNode();
  FocusNode kepadatanFocus = FocusNode();
  FocusNode kantorTerdekatFocus = FocusNode();
  FocusNode tokoKueTerdekatFocus = FocusNode();

  bool pengecekanNama = false;
  bool pengecekanluas = false;
  bool pengecekanHarga = false;
  bool penegcekanKepadatan = false;
  bool pengecekanKantor = false;
  bool pengecekanToko = false;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.isEdit == true) {
      namaLokasi.text = widget.lokasi!.namaLokasi!;
      luasLokasi.text = widget.lokasi!.luas!.toString();
      harga.text = widget.lokasi!.harga!.toString();
      kepadatan.text = widget.lokasi!.kepadatanpenduduk!.toString();
      kantorTerdekat.text = widget.lokasi!.kantorterdekat!.toString();
      tokoKueTerdekat.text = widget.lokasi!.tokokueterdekat!.toString();

      setState(() {});
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
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          width: double.infinity,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nama Lokasi"),
                    RoundedInputField(
                      controller: namaLokasi,
                      onChanged: (value) {
                        if (value != "") {
                          pengecekanNama = false;
                        } else {
                          pengecekanNama = true;
                        }
                        setState(() {});
                      },
                      focusNode: namaLokasifocus,
                    ),
                    pengecekanNama == false
                        ? Container()
                        : Text(
                            "Nama Lokasi harus diisi!",
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 12),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Luas Lokasi"),
                    RoundedInputField(
                      controller: luasLokasi,
                      isNumber: true,
                      onChanged: (value) {
                        if (value != "") {
                          // print("sin");
                          pengecekanluas = false;
                        } else {
                          pengecekanluas = true;
                          // print("sini");
                        }
                        setState(() {});
                      },
                      focusNode: luasLokasiFocus,
                    ),
                    pengecekanluas == false
                        ? Container()
                        : Text(
                            "Luas Lokasi harus diisi!",
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 12),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Harga"),
                    RoundedInputField(
                      isNumber: true,
                      controller: harga,
                      onChanged: (value) {
                        if (value != "") {
                          pengecekanHarga = false;
                        } else {
                          pengecekanHarga = true;
                        }
                        setState(() {});
                      },
                      focusNode: hargafocus,
                    ),
                    pengecekanHarga == false
                        ? Container()
                        : Text(
                            "Harga harus diisi!",
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 12),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Kepadatan"),
                    RoundedInputField(
                      isNumber: true,
                      controller: kepadatan,
                      onChanged: (value) {
                        if (value != "") {
                          penegcekanKepadatan = false;
                        } else {
                          penegcekanKepadatan = true;
                        }
                        setState(() {});
                      },
                      focusNode: kepadatanFocus,
                    ),
                    penegcekanKepadatan == false
                        ? Container()
                        : Text(
                            "Kepadatan penduduk harus diisi!",
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 12),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Kantor Terdekat"),
                    RoundedInputField(
                      isNumber: true,
                      controller: kantorTerdekat,
                      onChanged: (value) {
                        if (value != "") {
                          pengecekanKantor = false;
                        } else {
                          pengecekanKantor = true;
                        }
                        setState(() {});
                      },
                      focusNode: kantorTerdekatFocus,
                    ),
                    pengecekanKantor == false
                        ? Container()
                        : Text(
                            "Kantor terdekat harus diisi!",
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 12),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Toko Kue Sekitar 2KM"),
                    RoundedInputField(
                      isNumber: true,
                      controller: tokoKueTerdekat,
                      onChanged: (value) {
                        if (value != "") {
                          pengecekanToko = false;
                        } else {
                          pengecekanToko = true;
                        }
                        setState(() {});
                      },
                      focusNode: tokoKueTerdekatFocus,
                    ),
                    pengecekanToko == false
                        ? Container()
                        : Text(
                            "Toko Terdekat harus diisi!",
                            style:
                                TextStyle(color: kPrimaryColor, fontSize: 12),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
              ),
              RoundedButton(
                text: "Simpan",
                press: () {
                  if (namaLokasi.text.trim() == "") {
                    namaLokasifocus.requestFocus();
                    pengecekanNama = true;
                  } else if (harga.text == "") {
                    hargafocus.requestFocus();
                    pengecekanHarga = true;
                  } else if (luasLokasi.text == "") {
                    luasLokasiFocus.requestFocus();
                    pengecekanluas = true;
                  } else if (kepadatan.text == "") {
                    kepadatanFocus.requestFocus();
                    penegcekanKepadatan = true;
                  } else if (kantorTerdekat.text == "") {
                    kantorTerdekatFocus.requestFocus();
                    pengecekanKantor = true;
                  } else if (tokoKueTerdekat.text == "") {
                    tokoKueTerdekatFocus.requestFocus();
                    pengecekanToko = true;
                  } else {
                    FocusScope.of(context).unfocus();
                    pengecekanNama = false;
                    pengecekanHarga = false;
                    pengecekanluas = false;
                    penegcekanKepadatan = false;
                    pengecekanKantor = false;
                    pengecekanToko = false;
                    Lokasi lokasi = Lokasi();
                    lokasi.namaLokasi = namaLokasi.text.trim();
                    lokasi.luas = int.parse(luasLokasi.text);
                    lokasi.harga = int.parse(harga.text);
                    lokasi.kepadatanpenduduk = int.parse(kepadatan.text);
                    lokasi.kantorterdekat = int.parse(kantorTerdekat.text);
                    lokasi.tokokueterdekat = int.parse(tokoKueTerdekat.text);
                    // print("lokasi $lokasi");

                    Get.back(result: {
                      "lokasi": lokasi,
                      "isEdit": widget.isEdit,
                      "index": widget.index
                    });
                  }
                },
                width: size.width,
                color: kPrimaryColor,
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
  final bool? isNumber;

  const RoundedInputField({
    super.key,
    this.hinText,
    this.icon,
    this.onChanged,
    this.iconColor,
    required this.controller,
    this.maxline,
    this.focusNode,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType:
            isNumber == true ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumber == true
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
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
