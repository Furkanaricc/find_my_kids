class AudioRecordingsManager {
  static final AudioRecordingsManager _instance = AudioRecordingsManager._internal();
  factory AudioRecordingsManager() => _instance;

  AudioRecordingsManager._internal();

  List<String> audioRecordings = [];
}