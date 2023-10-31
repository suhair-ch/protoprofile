import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:protoprofile/firebase_options.dart';
import 'package:protoprofile/model/loginmodel.dart';
import 'package:protoprofile/unusedfile/saveddata.dart';
import 'package:protoprofile/view/loginview.dart';
import 'package:protoprofile/view/profilepage.dart';
import 'package:protoprofile/view/signuppage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SavedData());
  }
}
