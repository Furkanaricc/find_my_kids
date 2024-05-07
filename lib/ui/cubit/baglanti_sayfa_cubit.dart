import 'package:find_my_kids/data/entitiy/cocuklar.dart';
import 'package:find_my_kids/data/repo/find_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaglantiSayfasiCubit extends Cubit<List<Cocuklar>> {
  BaglantiSayfasiCubit(): super (<Cocuklar>[]);
  var frepo = FindDaoRepository();

  void updateCocuk(Cocuklar updatedCocuk) {
    frepo.updateCocuk(updatedCocuk);
  }


}