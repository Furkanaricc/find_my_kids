import 'package:find_my_kids/ui/cubit/anasayfa_cubit.dart';
import 'package:find_my_kids/ui/cubit/batarya_sayfa_cubit.dart';
import 'package:find_my_kids/ui/cubit/kamera_sayfa_cubit.dart';
import 'package:find_my_kids/ui/cubit/konum_sayfa_cubit.dart';
import 'package:find_my_kids/ui/cubit/ortam_sesi_sayfa_cubit.dart';
import 'package:find_my_kids/ui/views/login_screen/login_screen.dart';
import 'package:find_my_kids/utils/auth_provider.dart';
import 'package:find_my_kids/utils/bottom_nav_bar.dart';
import 'package:find_my_kids/utils/locator.dart';
import 'package:find_my_kids/utils/sound_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  setupLocator();
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
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => OrtamSesiSayfaCubit()),
        BlocProvider(create: (context) => KameraSayfaCubit()),
        ChangeNotifierProvider(create: (context) => SoundController()),
        ChangeNotifierProvider<AuthProvider>(create: (context) => locator.get<AuthProvider>(),)


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
