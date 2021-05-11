import 'package:flutter/material.dart';
//?custom material button for round icon button
class RoundIconButton extends StatelessWidget {
  RoundIconButton({required this.icon, required this.onPressed});
  final IconData icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: () {
        print("Round icon pressed");
        onPressed();
      },
      shape: CircleBorder(),
      fillColor: Theme.of(context).shadowColor,
      constraints: BoxConstraints.tightFor(
        width: 25.0,
        height: 25.0,
      ),
      elevation: 6.0,
    );
  }
}
