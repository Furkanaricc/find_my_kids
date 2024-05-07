import 'package:flutter/material.dart';

class BaglantiSayfasi extends StatefulWidget {
  const BaglantiSayfasi({Key? key}) : super(key: key);

  @override
  State<BaglantiSayfasi> createState() => _BaglantiSayfasiState();
}

class _BaglantiSayfasiState extends State<BaglantiSayfasi> {

  var tfCocukId = TextEditingController();
  var tfCocukAdi = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FindMyBaby"),
        actions: [
          IconButton(onPressed: (){
            // Butona basıldığında showDialog fonksiyonunu kullanarak iletişim kutusunu göster
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // showDialog metodu bir widget döndürür
                return AlertDialog(
                  title: const Text('Çocuk Ekle'),
                  content:  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // İletişim kutusu içeriği burada olacak
                      TextField
                        (controller: tfCocukId ,
                        decoration:  const InputDecoration(hintText: "Cocuk Id"),
                      ),
                      TextField
                        (controller: tfCocukAdi ,
                        decoration:  const InputDecoration(hintText: "Cocuk adı"),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    // İletişim kutusu altında butonlar burada olacak
                    TextButton(
                      onPressed: () {
                        // İletişim kutusundan çıkmak için Navigator.pop kullanılır
                        Navigator.of(context).pop();
                      },
                      child: const Text('Kapat'),
                    ),
                  ],
                );
              },
            );
          }, icon:const Icon(Icons.add_circle_outline_outlined))
        ],
        backgroundColor: Colors.amber,
        centerTitle: true,

      ),
      body: Container(
        child: const Text("Baglanti Sayfasi"),
      ),
    );
  }
}
