import 'package:flutter/material.dart';

class PurchaseButton extends StatelessWidget {
  const PurchaseButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.purple, borderRadius: BorderRadius.circular(14)),
        child: Center(
          child: Text(
            'Continue',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
