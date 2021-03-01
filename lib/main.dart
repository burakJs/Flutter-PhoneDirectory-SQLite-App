import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi/KisiDetaySayfa.dart';
import 'package:kisiler_uygulamasi/KisiKayitSayfa.dart';
import 'package:kisiler_uygulamasi/Kisiler.dart';
import 'package:kisiler_uygulamasi/KisilerDao.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  Future<List<Kisiler>> tumKisilerGoster() async {
    List kisilerListesi = await KisilerDao().tumKisiler();

    return kisilerListesi;
  }

  Future<List<Kisiler>> aramaYap(String aramaKelimesi) async {
    List kisilerListesi = await KisilerDao().kelimeArama(aramaKelimesi);

    return kisilerListesi;
  }

  Future<void> sil(int kisiId) async {
    await KisilerDao().kisiSil(kisiId);
    setState(() {});
  }

  Future<bool> uygulumayiKapat() async {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            uygulumayiKapat();
          },
        ),
        title: aramaYapiliyorMu
            ? TextField(
                decoration: InputDecoration(
                  hintText: "Arama yapılacak metni giriniz...",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (text) {
                  setState(() {
                    aramaKelimesi = text;
                  });
                },
              )
            : Text("Kişiler Uygulaması"),
        actions: [
          IconButton(
            icon: Icon(
              aramaYapiliyorMu ? Icons.cancel : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = !aramaYapiliyorMu;
              });
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: uygulumayiKapat,
        child: FutureBuilder<List<Kisiler>>(
          future: aramaYapiliyorMu ? aramaYap(aramaKelimesi) : tumKisilerGoster(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var kisilerListesi = snapshot.data;
              return ListView.builder(
                itemCount: kisilerListesi.length,
                itemBuilder: (context, index) {
                  var kisi = kisilerListesi[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KisiDetaySayfa(
                            kisi: kisi,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              kisi.kisiAd,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              kisi.kisiTel,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                sil(kisi.kisiId);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => KisiKayitSayfa()));
        },
        tooltip: 'Kişi Ekle',
        child: Icon(Icons.add),
      ),
    );
  }
}
