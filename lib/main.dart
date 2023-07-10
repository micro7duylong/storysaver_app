import 'package:com.qksoft.storysaverfacebook/models/product.dart';
import 'package:com.qksoft.storysaverfacebook/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        scaffoldBackgroundColor: Colors.grey[800],
        // useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.black),
        cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark),
        brightness: Brightness.dark,
      ),
      home: SplashScreen(),
    );
  }
}
