import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/repo/find_dao_repository.dart';

class KonumSayfaCubit extends Cubit<void>{

  KonumSayfaCubit():super(LatLng(0, 0));
  var frepo = FindDaoRepository();

  void updateCocukKonum(LatLng newPosition) {
   frepo.updateCocukKonum(newPosition);
  }


}