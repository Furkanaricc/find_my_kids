
import 'package:find_my_kids/data/repo/find_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KameraSayfaCubit extends Cubit<void>{
  KameraSayfaCubit():super(0);
  var frepo = FindDaoRepository();

  void savePhoto(String photoPath) {
   frepo.savePhoto(photoPath);
  }

  void saveVideo(String videoPath) {
    frepo.saveVideo(videoPath);
  }

}