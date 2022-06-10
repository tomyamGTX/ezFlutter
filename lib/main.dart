import 'package:ez_flutter/providers/animation.provider.dart';
import 'package:ez_flutter/providers/auth.provider.dart';
import 'package:ez_flutter/providers/azan.time.provider.dart';
import 'package:ez_flutter/providers/db.provider.dart';
import 'package:ez_flutter/providers/local.provider.dart';
import 'package:ez_flutter/providers/location.provider.dart';
import 'package:ez_flutter/providers/payment.provider.dart';
import 'package:ez_flutter/providers/sandbox.payment.provider.dart';
import 'package:ez_flutter/screen/landing.page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ms_material_color/ms_material_color.dart';
import 'package:provider/provider.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'firebase_options.dart';

// ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int color = GetStorage().read('theme') ?? 0xfff44336;

  void changeColor(int colour) {
    if (mounted) {
      setState(() {
        if (colour == 0) {
          color = 0xfff44336;
          GetStorage().write('theme', color);
        }
        if (colour == 1) {
          color = 0xffffc107;
          GetStorage().write('theme', color);
        }
        if (colour == 2) {
          color = 0xff9c27b0;
          GetStorage().write('theme', color);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppUser>(create: (context) => AppUser()),
        ChangeNotifierProvider<LocationProvider>(
            create: (context) => LocationProvider()),
        ChangeNotifierProvider<AzanProvider>(
            create: (context) => AzanProvider()),
        ChangeNotifierProvider<SandBoxPaymentProvider>(
            create: (context) => SandBoxPaymentProvider()),
        ChangeNotifierProvider<PaymentProvider>(
            create: (context) => PaymentProvider()),
        ChangeNotifierProvider<DB>(create: (context) => DB()),
        ChangeNotifierProvider<LocalProvider>(
            create: (context) => LocalProvider()),
        ChangeNotifierProvider<AnimationProvider>(
            create: (context) => AnimationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EZFlutter',
        theme: ThemeData(primarySwatch: MsMaterialColor(color)),
        home: SplashScreen.navigate(
          backgroundColor: Colors.white,
          name: 'asset/rives/intro.riv',
          next: (context) => const LandingPage(),
          until: () => Future.delayed(const Duration(seconds: 1)),
          startAnimation: 'Landing',
        ),
      ),
    );
  }
}
