import 'package:find_my_kids/utils/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//const LatLng currentLocation = LatLng(39.925533, 32.866287);

class KonumSayfasi extends StatefulWidget {
  const KonumSayfasi({Key? key}) : super(key: key);

  @override
  State<KonumSayfasi> createState() => _KonumSayfasiState();
}

class _KonumSayfasiState extends State<KonumSayfasi> {
  late GoogleMapController mapController;
  String? lat, long, country, adminArea;
  late LatLng? currentLocation;
  BitmapDescriptor manIcon = BitmapDescriptor.defaultMarker;


  @override
  void initState() {
    super.initState();
    //setCustomMakerIcon();
    getLocation();
  }

  /* ICON EKLEME
  void setCustomMakerIcon() {
    ImageConfiguration configuration = ImageConfiguration(size: Size(22, 22));

    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "images/man.png")
        .then(
      (icon) {
        manIcon = icon;
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;
    print("Ekran Yuksekliği: $ekranYuksekligi,");
    print("Ekran Genisliği: $ekranGenisligi");

    return Scaffold(
      appBar: AppBar(
        title: Text("FindMyBaby"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                updateLocation();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: currentLocation != null
          ? GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLocation!,
          zoom: 15,
        ),
        markers: <Marker>{
          Marker(
            markerId: MarkerId('currentLocationMarker'),
            position: currentLocation!,
            icon: manIcon,
            infoWindow: const InfoWindow(
              title: 'Anlık Konum',
              snippet: 'Anlık konum.',
            ),
          ),
        },
        onMapCreated: (controller) {
          mapController = controller;
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
    /*
           -> Konum servisleri entegrasyonu yapılacak
           -> Kullanıcılar uygulamada konumlarını paylaşmayı seçtiklerinde,
              bu  konum bilgisini bir sunucuya göndermelisiniz.
              Sunucu, bu bilgiyi diğer kullanıcılara gönderebilir.
              Kullanıcılar bu bilgiyi almak için sunucuya istek yapmalıdır.
           -> Haritada konum gözükecek sayfada gözüken harita olacak

          */
  }

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();

    if (locationData != null) {
      setState(() {
        lat = locationData.latitude!.toStringAsFixed(6);
        long = locationData.longitude!.toStringAsFixed(6);
        currentLocation = LatLng(
          double.parse(lat!),
          double.parse(long!),
        );
        print("${lat}");
        print("${long}");
      });
    }
  }

  void updateLocation() {
    getLocation();
  }
}
