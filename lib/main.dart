import 'package:ez_flutter/providers/auth.provider.dart';
import 'package:ez_flutter/screen/landing.page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

// ...

Future<void> main() async {
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
      providers: [ChangeNotifierProvider(create: (context) => AppUser())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EZFlutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LandingPage(),
      ),
    );
  }
}
