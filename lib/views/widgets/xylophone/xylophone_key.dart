import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class XyloPhoneKey extends StatelessWidget {
  void playSound(int noteNumber) async {
    final audioPlayer = AudioPlayer();

    var duration = await audioPlayer
        .setAsset('assets/music/xylophone/xylophone_$noteNumber.wav');
    try {
      audioPlayer.playerStateStream.listen((state) {
        if (!state.playing) {
          audioPlayer.play();
        } else {
          print("already playing");
        }
      });
    } on PlayerException catch (e) {
      print('Error: ${e.message}');
    } catch (e) {
      print(e);
    }
  }

  late Color keyColor;
  late int noteNumber;

  XyloPhoneKey(Color _color, int _noteNumber) {
    keyColor = _color;
    noteNumber = _noteNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlatButton(
        color: keyColor,
        onPressed: () {
          playSound(noteNumber);
          print('$noteNumber played');
        },
        child: Text('$noteNumber'),
      ),
    );
  }
}
