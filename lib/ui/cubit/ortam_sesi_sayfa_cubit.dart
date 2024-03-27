import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/find_dao_repository.dart';

class OrtamSesiSayfaCubit extends Cubit<void> {
  OrtamSesiSayfaCubit():super(0);
  var frepo = FindDaoRepository();

  void updateCocukSes(String newSesDosyaYolu) {
    frepo.updateCocukSes(newSesDosyaYolu);
  }
}