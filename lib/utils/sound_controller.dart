
import 'dart:async';
import 'dart:developer';
import 'package:find_my_kids/utils/audio_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';

class SoundController extends ChangeNotifier{
  static final SoundController _instance = SoundController._internal();
  static SoundController get instance => _instance;
  SoundController._internal();

  FlutterSoundRecorder ? _audioRecorder;

  Duration _recordDuration = Duration.zero;

    Timer? _timer;

  String get audioTime =>  _recordDuration.toString().split('.').first.padLeft(8,"0");

  VoiceState voiceState = VoiceState.none;

  AudioRecordingsManager audioManager = AudioRecordingsManager();

  void initAudio () async {
    _audioRecorder = FlutterSoundRecorder();
    await _audioRecorder?.openRecorder();
  }

  void recordAudio () async{
    try{
      changeVoiceState(VoiceState.recording);
      print("Kayıt yapılıyor.");
      startTimer();
      String filePath = "${DateTime.now().millisecondsSinceEpoch.toString()}.wav";
      await  _audioRecorder?.startRecorder(
        toFile: filePath ,
        codec: Codec.pcm16WAV,
      );
      audioManager.audioRecordings.add(filePath); //dosya yolu listeye eklendi
    }catch(e){
      changeVoiceState(VoiceState.none);
      stopTimer();
      log(e.toString());
    }
  }

  void stopAudio () async {
    try{
      changeVoiceState(VoiceState.none);
      stopTimer();
       await _audioRecorder?.stopRecorder();

    }catch(e){
      changeVoiceState(VoiceState.none);
      stopTimer();
      log(e.toString());
    }
  }

  void pauseResumeAudio () {
    if(_audioRecorder == null ) return;
    (_audioRecorder!.isPaused) ? _resumeAudio() : _pauseAudio();
  }

  void _pauseAudio() async {
    try{
      changeVoiceState(VoiceState.paused);
      stopTimer(resetTime: false);
      await _audioRecorder?.pauseRecorder();
    }catch(e){
      changeVoiceState(VoiceState.none);
      stopTimer();
      log(e.toString());
    }
  }

  void _resumeAudio() async {
    try {
      changeVoiceState(VoiceState.recording);
      startTimer();
      await _audioRecorder?.resumeRecorder();
    }catch(e) {
      changeVoiceState(VoiceState.none);
      stopTimer();
      log(e.toString());
    }


  }

  void startTimer(){
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _recordDuration += const Duration(seconds: 1) ;
      notifyListeners();
    });

  }
  void stopTimer({bool resetTime = true}){
    _timer?.cancel();
    _timer = null;

    if(resetTime) {
      _recordDuration = Duration.zero;
      notifyListeners();
    }
  }

  void changeVoiceState (VoiceState state){
    voiceState = state;
    notifyListeners();

  }

  Future<void> playAudio(String filePath) async {
    FlutterSoundPlayer player = FlutterSoundPlayer();
    try {
      await player.startPlayer(fromURI: filePath);
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

}

enum VoiceState {
  none,
  paused,
  recording,
}