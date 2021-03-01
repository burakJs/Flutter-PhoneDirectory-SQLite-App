import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi/Kisiler.dart';
import 'package:kisiler_uygulamasi/KisilerDao.dart';
import 'package:kisiler_uygulamasi/main.dart';

class KisiDetaySayfa extends StatefulWidget {
  Kisiler kisi;
  KisiDetaySayfa({this.kisi});
  @override
  _KisiDetaySayfaState createState() => _KisiDetaySayfaState();
}

class _KisiDetaySayfaState extends State<KisiDetaySayfa> {
  var tfKisiAd = TextEditingController();
  var tfKisiTel = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> guncelle(int kisiId, String kisiAd, String kisiTel) async {
    await KisilerDao().kisiGuncelle(kisiId, kisiAd, kisiTel);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfKisiAd.text = kisi.kisiAd;
    tfKisiTel.text = kisi.kisiTel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişi Kayıt"),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: tfKisiAd,
                  decoration: InputDecoration(labelText: "Kişi Adı"),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Kisi Adını Boş Bırakamazsınız";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: tfKisiTel,
                  decoration: InputDecoration(labelText: "Kişi Telefon Numarası"),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Kisi Telefon Numarasını Boş Bırakamazsınız";
                    } else {
                      return null;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (formKey.currentState.validate()) {
            guncelle(widget.kisi.kisiId, tfKisiAd.text, tfKisiTel.text);
          }
        },
        tooltip: 'Kişi Güncelle',
        icon: Icon(Icons.update),
        label: Text("Güncelle"),
      ),
    );
  }
}
