import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:find_my_kids/ui/cubit/batarya_sayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BataryaSayfasi extends StatefulWidget {
  const BataryaSayfasi({Key? key}) : super(key: key);

  @override
  State<BataryaSayfasi> createState() => _BataryaSayfasiState();
}

class _BataryaSayfasiState extends State<BataryaSayfasi> {

  var batarya = Battery();
  int yuzde = 0;
  late Timer timer;
  BatteryState bataryaDurum = BatteryState.full;
  late StreamSubscription streamSubscription ;

  @override
  void initState() {
    super.initState();
    getBataryaYuzde();
    getBataryaDurum();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getBataryaYuzde();
    });
  }


  void getBataryaYuzde () async {
    final level = await batarya.batteryLevel;
    setState(() {
      yuzde = level; // Yeni batarya yüzdesini güncelliyoruz
      // Güncel batarya yüzdesini konsola yazdırıyoruz
      print('Batarya yüzdesi güncellendi: $yuzde');
      // Güncel batarya yüzdesini Cocuklar sınıfındaki cocuk_batarya özelliğine atıyoruz
      context.read<BataryaSayfaCubit>().updateBatarya(yuzde.toString());
    });
  }

  void getBataryaDurum() async {
    streamSubscription = batarya.onBatteryStateChanged.listen((state) {
      bataryaDurum = state;
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    streamSubscription.cancel();
    super.dispose();
  }


  Widget Buildbattery (BatteryState state){
    switch(state) {
      case BatteryState.full :
        return Container(
          child: Icon(Icons.battery_full,size: 200, color: Colors.lightGreen,),
        );
      case BatteryState.charging:
        return Container(
          child: Icon(Icons.battery_charging_full,size: 200, color: Colors.lightGreen,),
        );
      case BatteryState.discharging:
      default:
        return Container(
          child: Icon(Icons.battery_alert,size: 200, color: Colors.red,),
        );

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Buildbattery(bataryaDurum),
              Text("Pil Güç Seviyesi : % ${yuzde}",
                style: const TextStyle(color: Colors.orangeAccent ,
                    fontSize: 24,fontWeight: FontWeight.bold),)
            ],
          ),
        )
    );
  }
}
//AIzaSyD4bNHbdaM4-12AidwZazldW7uRkw0BlLM
/*
   ->Batarya şarj durumu alınacak.
   ->5 dk da bir güncelleme yapılacak.
   ->Şarj durumu çocuk profilde put yapılacak, ebeveynde get yapılacak
 */