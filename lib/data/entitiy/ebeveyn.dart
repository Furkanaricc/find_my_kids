import 'package:find_my_kids/data/entitiy/cocuklar.dart';

class Ebeveyn {
  String ebeveyn_id;
  String ebeveyn_adi;
  Cocuklar cocuk;

  Ebeveyn({
    required this.ebeveyn_id,
    required this.ebeveyn_adi,
    required this.cocuk
  });
}