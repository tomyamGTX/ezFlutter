import 'package:ez_flutter/providers/auth.provider.dart';
import 'package:ez_flutter/providers/location.provider.dart';
import 'package:ez_flutter/screen/landing.page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'firebase_options.dart';

// ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppUser()),
        ChangeNotifierProvider(create: (context) => LocationProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EZFlutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen.navigate(
          backgroundColor: Colors.white,
          name: 'asset/rives/intro.riv',
          next: (context) => const LandingPage(),
          until: () => Future.delayed(const Duration(seconds: 2)),
          startAnimation: 'Landing',
        ),
      ),
    );
  }
}
