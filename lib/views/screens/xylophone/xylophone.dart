import 'package:flutter/material.dart';
import 'package:flutter_app/themes/ThemeModeManager.dart';
import 'package:flutter_app/views/widgets/xylophone/xylophone_key.dart';

class Xylophone extends StatefulWidget {
  late ThemeModeManager themeData;
  Xylophone(ThemeModeManager themeMode) {
    themeData = themeMode;
  }
  @override
  _XylophoneState createState() => _XylophoneState(themeData);
}

class _XylophoneState extends State<Xylophone> {
  final ThemeModeManager themeData;
  _XylophoneState(this.themeData);
  void _changeThemeMode() {
    themeData.changeTheme();
  }

  @override
  Widget build(BuildContext context) {
    final mode = themeData.themeMode;
    final List<Widget> keyList = [
      XyloPhoneKey(Colors.red, 1),
      XyloPhoneKey(Colors.orange, 2),
      XyloPhoneKey(Colors.yellow, 3),
      XyloPhoneKey(Colors.green, 4),
      XyloPhoneKey(Colors.blue, 5),
      XyloPhoneKey(Colors.indigo, 6),
      XyloPhoneKey(Colors.purple, 7),
      XyloPhoneKey(Colors.brown, 8),
      XyloPhoneKey(Colors.teal ,9),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Xylophone'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: _changeThemeMode,
              icon: (mode == ThemeMode.dark)
                  ? Icon(Icons.lightbulb)
                  : Icon(Icons.lightbulb_outline_rounded)),
        ],
      ),
      body: SafeArea(
        child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: keyList,
        ),
          ),
      ),
    );
  }
}
