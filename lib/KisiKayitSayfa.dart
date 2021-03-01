import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi/KisilerDao.dart';
import 'package:kisiler_uygulamasi/main.dart';

class KisiKayitSayfa extends StatefulWidget {
  @override
  _KisiKayitSayfaState createState() => _KisiKayitSayfaState();
}

class _KisiKayitSayfaState extends State<KisiKayitSayfa> {
  var tfKisiAd = TextEditingController();
  var tfKisiTel = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> kayit(String kisiAd, String kisiTel) async {
    await KisilerDao().kisiEkle(kisiAd, kisiTel);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
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
            kayit(tfKisiAd.text, tfKisiTel.text);
          }
        },
        tooltip: 'Kişi Kayıt',
        icon: Icon(Icons.save),
        label: Text("Kaydet"),
      ),
    );
  }
}
