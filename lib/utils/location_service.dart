import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationService {

  late Location _location;
  bool _serviceAktif = false;
  PermissionStatus? _grantedPermission;

  LocationService(){
    _location = Location();

  }

  Future<bool> _checkPermission() async {

    if(await _checkService()){
      _grantedPermission = await _location.hasPermission();
      if(_grantedPermission == PermissionStatus.denied){
        _grantedPermission = await _location.requestPermission();
      }
    }
    return _grantedPermission == PermissionStatus.granted;
  }


  Future<bool> _checkService() async {
    try{
      _serviceAktif = await _location.serviceEnabled();
      if(!_serviceAktif){
        _serviceAktif = await _location.requestService();
      }
    }on PlatformException catch(error){
      print("error code is ${error.code} and message = ${error.message}");
      _serviceAktif = false ;
      await _serviceAktif;
    }
    return _serviceAktif;
  }

  Future <LocationData?> getLocation() async{
    if(await _checkPermission()){
      final locationData = await _location.getLocation();
      return locationData;
    }
    return null;
  }

}