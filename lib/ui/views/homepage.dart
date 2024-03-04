import 'dart:async';

import 'package:find_my_kids/ui/views/camera_sayfasi.dart';
import 'package:find_my_kids/ui/views/batarya_sayfasi.dart';
import 'package:find_my_kids/ui/views/ortam_sesi.dart';
import 'package:find_my_kids/utils/ses_ayar.dart';
import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   List<String> gorselyolu = [
    "images/gorsel1.png","images/gorsel2.png"
  ];
   bool sesAcikMi =false;
   int _currentIndex = 0;
   late Timer _timer;

   @override
   void initState() {
     super.initState();
     // Timer.periodic ile her 3 saniyede bir resmi güncelleme fonksiyonu çağrılır
     _timer = Timer.periodic(Duration(seconds: 3), (timer) {
       setState(() {
         // Her 3 saniyede bir resmin değişmesini sağlar
         _changeImageIndex();
       });
     });
   }

  /* @override
   void initState() {
     super.initState();
     // Timer.periodic ile her 3 saniyede bir _changeImageIndex fonksiyonu çağrılır
     _timer = Timer.periodic(Duration(seconds: 3), (timer) {
       setState(() {
         _changeImageIndex();
       });
     });
   }
*/
   @override
   void dispose() {
     _timer.cancel(); // Timer'ı dispose ediyoruz
     super.dispose();
   }

   void _changeImageIndex() {
     setState(() {
       // Liste üyelerini döngüsel olarak gezerek indeksi arttırıyoruz
       if (_currentIndex < gorselyolu!.length - 1) {
         _currentIndex++;
       } else {
         _currentIndex = 0;
       }
     });
   }

  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;
    print("Ekran Yuksekliği: $ekranYuksekligi,");
    print("Ekran Genisliği: $ekranGenisligi");

    Future openDialog() =>showDialog(
      context: context,
      builder: (BuildContext context){
        return const Dialog(
          child: SesAyar(),
        );
      }
    );

    return Scaffold(
      appBar: AppBar(title: Text("FindMyBaby"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        
      ),
      body:ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 10,width: ekranGenisligi),

                //Görsel döndüreceğimiz alan
                //Reklam kampanya vs olabilir
                //3 saniyede bir görsel değiştiriliyor

                Padding(
                  padding: const EdgeInsets.only(right: 1.0),
                  child: SizedBox(
                    height: 200, // Listview'in yüksekliği
                    width: 300 , // Listview'in genişliği
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: gorselyolu!.length,
                        itemExtent: ekranGenisligi, // Her elemanın genişliği
                        itemBuilder: (BuildContext context, int index) {
                          return Visibility(
                            visible: index == _currentIndex,
                            child: Container(
                              child: Image.asset(gorselyolu[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: ekranGenisligi/2.5,
                        height: ekranYuksekligi/3.6,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap:(){
                                print("Bataryaya tıklandı");
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>BataryaSayfasi()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset("images/batarya.png",
                                  ),
                                ),
                              ),
                            ),
                            const Text("Şarj Durumu",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),
                          ],
                        ),


                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: (){
                          openDialog();
                          //Ses modu on-of yapılacak
                        },
                        child: Container(
                          width: ekranGenisligi/2.5,
                          height: ekranYuksekligi/3.6,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset("images/speaker.png",
                                  ),
                                ),
                              ),

                              const Text("Ses Modu",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),
                              Switch(
                                value: sesAcikMi,
                                onChanged: (newValue) {
                                  setState(() {
                                    sesAcikMi = newValue;
                                    if (PerfectVolumeControl.volume == false ){
                                        sesAcikMi = false;
                                    }else{
                                      sesAcikMi = true;
                                    }

                                  });
                                },
                                activeColor: Colors.green, // Açık durumda renk
                                inactiveTrackColor: Colors.amber, // Kapalı durumda arka plan rengi
                              ),
                            ],
                        ),
                                          ),
                      ),
                    ),

                  ],
                ),


                Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: (){
                          //Kamera girişi yapılacak- Karşıdan görüntü çekilecek
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CameraSayfasi()));

                        },
                        child: Container(
                          width: ekranGenisligi/2.5,
                          height: ekranYuksekligi/3.6,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                      "images/camera.png",
                                  ),
                                ),
                              ),
                              const Text("Kamera",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OrtamSesi()));
                        },
                        child: Container(
                          width: ekranGenisligi/2.5,
                          height: ekranYuksekligi/3.6,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                      "images/microphone.png",

                                  ),
                                ),
                              ),
                              const Text("Ortam Sesi",style: TextStyle(fontSize:16,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            )
          ],
        ),
    );
  }
}
