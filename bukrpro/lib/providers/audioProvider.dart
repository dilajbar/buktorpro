import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart'; // For visualizing audio

class AudioProvider with ChangeNotifier {
  final AudioRecorder _record = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final RecorderController recorderController = RecorderController();
  final PlayerController playerController = PlayerController();

  String? _filePath;
  bool _isRecording = false;
  bool _isPlaying = false;

  String? get filePath => _filePath;
  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;

  // Request Microphone Permission
  Future<bool> _requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }

  // Start Recording with waveform visualization
  Future<void> startRecording() async {
    if (await _requestMicrophonePermission()) {
      final directory = await getApplicationDocumentsDirectory();
      _filePath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';

      if (await _record.hasPermission()) {
        await _record.start(
          RecordConfig(),
          path: _filePath.toString(),
        );
        recorderController.record(); // Start showing waveforms
        _isRecording = true;
        notifyListeners();
      }
    }
  }

  Future<void> stopRecording() async {
    if (_isRecording) {
      await _record.stop();
      recorderController.stop();
      _isRecording = false;
      notifyListeners();
    }
  }

  Future<void> playAudio() async {
    if (_filePath != null && File(_filePath!).existsSync()) {
      _isPlaying = true;
      playerController.preparePlayer(
          path: _filePath!, shouldExtractWaveform: true);
      await _audioPlayer.setFilePath(_filePath!);
      await _audioPlayer.play();
      notifyListeners();
    }
  }

  //Stop Audio Playback
  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    playerController
        .updateFrequency; // Stop waveform animation on playback stop
    _isPlaying = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    recorderController.dispose();
    playerController.dispose();
    super.dispose();
  }
}
