import 'package:flutter/material.dart';

class CardContent extends StatelessWidget {
  //?to solve problems due to null safety using required
  const CardContent({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontSize: 18.0,
      color: Theme.of(context).textSelectionColor,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,size:80.0),
        SizedBox(height: 15.0,),
        Text(label,style: labelStyle,),
      ],
    );
  }
}
