class Cocuklar {
  String cocuk_id;
  String cocuk_adi;
  String ebeveyn_id;
  String cocuk_location;
  String cocuk_ses;
  String ses_ayar;
  String cocuk_batarya;
  String cocuk_fotograf;
  String cocuk_video;

  Cocuklar({
    required this.cocuk_id,
    required this.cocuk_adi,
    required this.ebeveyn_id,
    required this.cocuk_location,
    required this.cocuk_ses,
    required this.ses_ayar,
    required this.cocuk_batarya,
    required this.cocuk_fotograf,
    required this.cocuk_video
  });

  factory Cocuklar.fromJson(Map<String,dynamic>json){
    return Cocuklar(
        cocuk_id: json["cocuk_id"] as String,
        cocuk_adi: json["cocuk_adi"] as String,
        ebeveyn_id: json["ebeveyn_id"] as String,
        cocuk_location: json["cocuk_location"] as String,
        cocuk_ses: json["cocuk_ses"] as String,
        ses_ayar:json["ses_ayar"] as String,
        cocuk_batarya: json["cocuk_batarya"] as String,
        cocuk_fotograf: json["cocuk_fotograf"] as String,
        cocuk_video: json["cocuk_video"] as String
    );
  }
}