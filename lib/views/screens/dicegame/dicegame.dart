
import 'package:flutter/material.dart';
import 'package:flutter_app/themes/ThemeModeManager.dart';
import 'dart:math';
import 'package:just_audio/just_audio.dart';

class DiceGame extends StatefulWidget {
  late ThemeModeManager themeData;
  DiceGame(ThemeModeManager themeMode) {
    themeData = themeMode;
  }
  @override
  _DiceGameState createState() => _DiceGameState(themeData);
}

class _DiceGameState extends State<DiceGame> {
  final ThemeModeManager themeData;
  _DiceGameState(this.themeData);
  void _changeThemeMode() {
    themeData.changeTheme();
  }

  @override
  Widget build(BuildContext context) {
    final mode = themeData.themeMode;

    String getRandomDiceValue() {
      int diceValue = Random().nextInt(6) + 1;
      return diceValue.toString();
    }

    String diceScore = getRandomDiceValue();
    final audioPlayer = AudioPlayer();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dice Game'),
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
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.monitor),
                    SizedBox(width: 10),
                    Text(
                      'Score: ' + diceScore,
                      style: TextStyle(
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    var duration = await audioPlayer
                        .setAsset('assets/music/dicegame/dice_sound.wav');
                    audioPlayer.play();
                    setState(() {
                      diceScore = getRandomDiceValue();
                    });
                  },
                  child: Container(
                    width: 200,
                    height: 200,
                    padding: EdgeInsets.all(10),
                    child: (mode == ThemeMode.light)
                        ? Image(
                        image: AssetImage(
                            'assets/img/dicegame/dice_' + diceScore + '.png'))
                        : Image(
                        image: AssetImage('assets/img/dicegame/dice_black_' +
                            diceScore +
                            '.png')),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
