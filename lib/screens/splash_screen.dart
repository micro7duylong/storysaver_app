import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:storysaver_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay of 3 seconds before navigating to the next screen
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(),
            SizedBox(height: 16),
            _buildText(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      child: Image(image: AssetImage('assets/images/notebook_logo.png')),
    );
  }

  Widget _buildText() {
    return Container(
        child: Text(
      'Story Saver',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ));
  }
}
