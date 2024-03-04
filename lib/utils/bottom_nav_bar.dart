import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:find_my_kids/ui/views/baglanti_sayfasi.dart';
import 'package:find_my_kids/ui/views/homepage.dart';
import 'package:find_my_kids/ui/views/konum_sayfasi.dart';
import 'package:flutter/material.dart';


class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _body() => SizedBox.expand(
    child: IndexedStack(
      index: _currentIndex,
      children: const <Widget>[
        HomePage(),
        KonumSayfasi(),
        BaglantiSayfasi(),

      ],
    ),
  );

  Widget _bottomNavBar() => BottomNavBar(
    showElevation: true,
    selectedIndex: _currentIndex,
    onItemSelected: (index) {
      setState(() => _currentIndex = index);
    },
    items: <BottomNavBarItem>[
      BottomNavBarItem(
        title: 'Anasayfa',
        icon: const Icon(Icons.home_filled),
        activeColor: Colors.white,
        inactiveColor: Colors.amber,
        activeBackgroundColor: Colors.amber,
      ),
      BottomNavBarItem(
        title: 'Konum',
        icon: const Icon(Icons.location_on),
        activeColor: Colors.white,
        inactiveColor: Colors.amber,
        activeBackgroundColor: Colors.amber,
      ),

      BottomNavBarItem(
        title: 'Bağlantı',
        icon: const Icon(Icons.connect_without_contact),
        activeColor: Colors.white,
        inactiveColor: Colors.amber,
        activeBackgroundColor: Colors.amber,
      ),

    ],
  );
}