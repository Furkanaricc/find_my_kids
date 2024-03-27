import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/find_dao_repository.dart';

class BataryaSayfaCubit extends Cubit<void>{

  BataryaSayfaCubit():super(0);
  var frepo = FindDaoRepository();

  void updateBatarya(String newBatarya) {
   frepo.updateBatarya(newBatarya);
  }



}