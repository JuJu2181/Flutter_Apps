
import 'package:flutter/material.dart';
import 'package:flutter_app/themes/ThemeModeManager.dart';
import 'package:flutter_app/views/widgets/container_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  late ThemeModeManager themeData;
  HomePage(ThemeModeManager themeMode) {
    themeData = themeMode;
  }

  @override
  _HomePageState createState() => _HomePageState(themeData);
}

class _HomePageState extends State<HomePage> {
  final ThemeModeManager themeData;
  _HomePageState(this.themeData);
  void _changeThemeMode() {
    themeData.changeTheme();
  }

  @override
  Widget build(BuildContext context) {
    final mode = themeData.themeMode;
    final List<Widget> _gridContainers = [
      ContainerWidget(FontAwesomeIcons.dice,'Dice Game','/dicegame'),
      ContainerWidget(FontAwesomeIcons.music, 'Xylophone',            '/xylophone'),
      ContainerWidget(FontAwesomeIcons.weight ,'BMI',                 '/bmi_calculator'),
      ContainerWidget(FontAwesomeIcons.questionCircle, 'Quiz',        '/quiz_home')
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page',
          style: TextStyle(
              color: Theme.of(context).buttonColor,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: _changeThemeMode,
              icon: (mode == ThemeMode.dark)
                  ? Icon(Icons.lightbulb)
                  : Icon(Icons.lightbulb_outline_rounded)),
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: CustomScrollView(
          primary: false,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(20),
              sliver: SliverGrid.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: _gridContainers,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
