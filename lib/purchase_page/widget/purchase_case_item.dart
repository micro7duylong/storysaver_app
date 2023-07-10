import 'package:flutter/material.dart';


class PurchaseCaseItem extends StatelessWidget {
  const PurchaseCaseItem(
      {super.key,
      required this.value,
      required this.duration,
      required this.onPressed,
      required this.isSelected});
  final String value;
  final String duration;
  final bool isSelected;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        height: 68,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1 $duration',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(
                  height: 11,
                ),
                Text(
                  '$value after trial period',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            Container(
              height: 27,
              width: 27,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ?  Colors.green[500]
                    : Colors.white
              ),
              child: Center(
                child: Container(
                  height: 17,
                  width: 17,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
