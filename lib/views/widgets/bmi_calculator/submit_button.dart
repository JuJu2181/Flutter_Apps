import 'package:flutter/material.dart';

class SubmitBtn extends StatelessWidget {
  const SubmitBtn(
      {required this.btnText,required this.onPressed});
  final String btnText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).textSelectionColor,
    );

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Center(
          child: Text(
            btnText,
            style: labelStyle,
          ),
        ),
        margin: EdgeInsets.only(top: 10.0),
        color: Theme.of(context).primaryColor,
        height: 60.0,
        width: double.infinity,
      ),
    );
  }
}
