import 'package:kisiler_uygulamasi/Kisiler.dart';
import 'package:kisiler_uygulamasi/VeritabaniYardimcisi.dart';

class KisilerDao {
  Future<List<Kisiler>> tumKisiler() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kisiler(satir["kisi_id"], satir["kisi_ad"], satir["kisi_tel"]);
    });
  }

  Future<List<Kisiler>> kelimeArama(String aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM kisiler WHERE kisi_ad like '%$aramaKelimesi%'");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kisiler(satir["kisi_id"], satir["kisi_ad"], satir["kisi_tel"]);
    });
  }

  Future<void> kisiEkle(String kisiAd, String kisiTel) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var kisi = Map<String, dynamic>();
    kisi["kisi_ad"] = kisiAd;
    kisi["kisi_tel"] = kisiTel;
    await db.insert("kisiler", kisi);
  }

  Future<void> kisiSil(int kisiId) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    await db.delete("kisiler", where: "kisi_id=?", whereArgs: [kisiId]);
  }

  Future<void> kisiGuncelle(int kisiId, String kisiAd, String kisiTel) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var kisi = Map<String, dynamic>();
    kisi["kisi_id"] = kisiId;
    kisi["kisi_ad"] = kisiAd;
    kisi["kisi_tel"] = kisiTel;

    await db.update("kisiler", kisi, where: "kisi_id=?", whereArgs: [kisiId]);
  }
}
