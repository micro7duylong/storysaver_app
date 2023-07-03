import 'package:com.qksoft.storysaverfacebook/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
