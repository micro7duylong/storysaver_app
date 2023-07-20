import 'package:flutter/material.dart';

class Supcription extends StatelessWidget {
  const Supcription({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}
