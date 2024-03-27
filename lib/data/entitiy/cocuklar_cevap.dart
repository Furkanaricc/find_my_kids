import 'cocuklar.dart';

class CocuklarCevap {
  List<Cocuklar> cocuklar ;
  int success;

  CocuklarCevap({
    required this.cocuklar,
    required this.success
  });

  factory CocuklarCevap.fromJson(Map<String,dynamic> json){
    int success = json["success"] as int ;
    var jsonArray = json["cocuklar"] as List;
    List<Cocuklar> cocuklar = jsonArray.map((JsonArrayNesnesi) => Cocuklar.fromJson(JsonArrayNesnesi)).toList();

    return CocuklarCevap(cocuklar: cocuklar, success: success);

  }
}