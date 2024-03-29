import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../entitiy/cocuklar.dart';
import '../entitiy/cocuklar_cevap.dart';

class FindDaoRepository{

  late Cocuklar cocuk;
  List<Cocuklar>parseCocuklarCevap(String cevap){
    return CocuklarCevap.fromJson(json.decode(cevap)).cocuklar;
  }

  void updateCocukKonum(LatLng newPosition) {
    // Yeni konumu Cocuklar nesnesine ata
    cocuk.cocuk_location = '${newPosition.latitude},${newPosition.longitude}';
  }

  void updateBatarya(String newBatarya) {
    cocuk.cocuk_batarya = newBatarya;
  }

  void updateCocukSes(String newSesDosyaYolu) {
    cocuk.cocuk_ses = newSesDosyaYolu;
  }
  void savePhoto(String photoPath) {
    FindDaoRepository repository = FindDaoRepository();
    repository.cocuk.cocuk_fotograf = photoPath;
  }

  void saveVideo(String videoPath) {
    FindDaoRepository repository = FindDaoRepository();
    repository.cocuk.cocuk_video = videoPath;
  }

  void updateSesAyar(String yeniSesAyar) {
    cocuk.ses_ayar = yeniSesAyar;
  }


}

