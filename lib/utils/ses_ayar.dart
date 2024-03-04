import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class SesAyar extends StatefulWidget {
  const SesAyar({Key? key}) : super(key: key);

  @override
  State<SesAyar> createState() => _SesAyarState();
}

class _SesAyarState extends State<SesAyar> {
  double anlikSes = 0.5;

  @override
  void initState() {
    PerfectVolumeControl.hideUI = false;
    Future.delayed(Duration.zero, ()async {
      anlikSes = await PerfectVolumeControl.getVolume();
      setState(() {

      });
    });
    PerfectVolumeControl.stream.listen((Volume) {
      setState(() {
        anlikSes = Volume;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100 ,
      width: 200,
      child: Column(
        children: [
          Text("Ses Ayar"),
          Slider(
            value: anlikSes,
            onChanged: (Volume) {
              anlikSes = Volume;
              PerfectVolumeControl.setVolume(Volume);
              setState(() {});
            },
            min: 0,
            max: 1,
            divisions: 100,
          ),
        ],
      ),
    );
  }
}
