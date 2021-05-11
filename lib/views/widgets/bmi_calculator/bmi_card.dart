import 'package:flutter/material.dart';

class BmiCard extends StatelessWidget {
  const BmiCard({required this.colour, this.cardChild, this.onPress});
  final Color colour;
  final Widget? cardChild; //declaration of nullable parameters
  final VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: colour,
          //   )
          // ],
          color: colour,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
