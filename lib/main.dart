import 'package:find_my_kids/ui/cubit/batarya_sayfa_cubit.dart';
import 'package:find_my_kids/ui/cubit/konum_sayfa_cubit.dart';
import 'package:find_my_kids/utils/bottom_nav_bar.dart';
import 'package:find_my_kids/utils/sound_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => KonumSayfaCubit()),
        BlocProvider(create: (context) => BataryaSayfaCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const RootPage(),
      ),
    );
  }
}
