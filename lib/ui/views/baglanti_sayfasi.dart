import 'package:flutter/material.dart';

class BaglantiSayfasi extends StatefulWidget {
  const BaglantiSayfasi({Key? key}) : super(key: key);

  @override
  State<BaglantiSayfasi> createState() => _BaglantiSayfasiState();
}

class _BaglantiSayfasiState extends State<BaglantiSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FindMyBaby"),
        backgroundColor: Colors.amber,
        centerTitle: true,

      ),
      body: Container(
        child: Text("Baglanti Sayfasi"),
      ),
    );
  }
}
