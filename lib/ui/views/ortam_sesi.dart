import 'package:find_my_kids/utils/sound_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/audio_list.dart';


class OrtamSesi extends StatefulWidget {
  const OrtamSesi({Key? key}) : super(key: key);

  @override
  State<OrtamSesi> createState() => _OrtamSesiState();
}

class _OrtamSesiState extends State<OrtamSesi> {


  AudioRecordingsManager audioManager = AudioRecordingsManager();

  @override
  void initState() {
    super.initState();
    Provider.of<SoundController>(context, listen: false).initAudio();

  }


  @override
  Widget build(BuildContext context) {

    var ekranBilgisi = MediaQuery.of(context);
    final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    final SoundController soundController = context.watch();


    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: audioManager.audioRecordings.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Kayıt ${index + 1}'),
                      subtitle: Text(audioManager.audioRecordings[index]),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_)=>
                                AlertDialog(
                                actions: [
                                  IconButton(onPressed: (){}, icon:const Icon(Icons.play_circle_outline))
                                ],
                        )
                        );
                        /*String selectedFilePath = audioManager.audioRecordings[index];
                        print('Seçilen dosya yolu: $selectedFilePath');
                        soundController.playAudio(selectedFilePath);*/
                      },
                    );
                  },
                ),
              ),
              Container(
                width: ekranGenisligi,
                height: 90,
                color: Colors.orangeAccent,
                child: Column(
                  children: [
                    Text(soundController.audioTime,
                      style: const TextStyle(fontSize: 24),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        playerIcon(
                          onPressed: soundController.recordAudio,
                          icon: Icons.mic,
                        ),
                        if(soundController.voiceState != VoiceState.none)
                        playerIcon(
                          onPressed:soundController.pauseResumeAudio,
                          icon: soundController.voiceState == VoiceState.recording?  Icons.pause_circle_outline : Icons.play_circle_outline,
                        ),
                        if(soundController.voiceState != VoiceState.none)
                          playerIcon(
                            onPressed: soundController.stopAudio,
                            icon: Icons.stop_circle_outlined,
                          ),

                      ],
                    ),
                  ],
                ),
              ),



            ],
          )
      ),
    );
  }

}

class playerIcon extends StatelessWidget {
  const playerIcon({super.key,
     required this.icon, required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: Icon(icon), color: Colors.white,iconSize: 32,);
  }
}
