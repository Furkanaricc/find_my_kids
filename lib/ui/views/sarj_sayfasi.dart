import 'package:flutter/material.dart';

class SarjSayfasi extends StatefulWidget {
  const SarjSayfasi({Key? key}) : super(key: key);

  @override
  State<SarjSayfasi> createState() => _SarjSayfasiState();
}

class _SarjSayfasiState extends State<SarjSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FindMyBaby"),
        backgroundColor: Colors.amber,
        centerTitle: true,

      ),
      body: Container(
        child: Text("Şarj Sayfasi"),
      ),
    );
  }
}
