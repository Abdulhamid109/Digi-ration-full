import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newdigiration/Responsive/responsive_Desktop/loginScreen.dart';
import 'package:newdigiration/Responsive/responsive_layout.dart';
import 'package:newdigiration/Responsive/responsive_mobile/loginScreen.dart';
import 'package:newdigiration/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const ResponsiveLayout(mobile_responsive: LoginScreenMobile(), desktop_responsive: LoginScreenDesktop()),
    );
  }
}

