import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContainerWidget extends StatelessWidget {
  late IconData iconName;
  late String iconText;
  late String iconRoute;
  ContainerWidget(IconData icon, String text, String route) {
    iconName = icon;
    iconText = text;
    iconRoute = route;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, iconRoute);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Icon(
                  iconName,
                  color: Theme.of(context).buttonColor,
                  size: 40,
                )),
            SizedBox(height: 15),
            Text(iconText,
              style: TextStyle(
                color: Theme.of(context).buttonColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Theme.of(context).accentColor,
          ),
        ]),
      ),
    );
  }
}
