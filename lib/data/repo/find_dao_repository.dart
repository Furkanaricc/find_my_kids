import 'dart:convert';
import 'package:find_my_kids/utils/auth_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../entitiy/cocuklar.dart';
import '../entitiy/cocuklar_cevap.dart';

class FindDaoRepository{

  late Cocuklar cocuk;
  List<Cocuklar> cocuklarList = []; // Boş bir çocuklar listesi oluşturuldu



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

  Future<void> updateEbeveynId() async{
     AuthService _authService = AuthService();
    String? userId = await _authService.getUserId();
     if (userId != null) {
       // Elde ettiğimiz userId değerini kullanabiliriz
       this.cocuk.ebeveyn_id = userId;
     }
  }
  // Yeni bir çocuk nesnesini güncelleyen ve listeye ekleyen metod
  void updateCocuk(Cocuklar updatedCocuk) {
    cocuk = updatedCocuk; // Güncellenmiş çocuk nesnesini cocuk değişkenine ata
    cocuklarList.add(cocuk); // Güncellenmiş çocuğu listeye ekle
  }



}

