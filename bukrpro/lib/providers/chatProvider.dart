import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:rxdart/rxdart.dart';

import '../models/chatModel.dart';
import '../models/conversationModel.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  final AudioRecorder _record = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _filePath;
  bool _isRecording = false;
  bool _isPlaying = false;

  String _errorMessage = '';

  String? audioFilePath;

  Chatmodel? _chatmodel;

  Chatmodel? get chatModel => _chatmodel;

  final ImagePicker _picker = ImagePicker();

  List<ChatMessage> get messages => _messages;

  String get errorMessage => _errorMessage;
  String? get filePath => _filePath;
  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;

  setSelectedchat(Chatmodel chatModel) {
    _chatmodel = chatModel;
  }

  setchat(List<ChatMessage> messages) {
    _messages = messages;
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  Future<void> sendImageFromCamera(bool isSentByMe) async {
    try {
      final XFile? capturedImage =
          await _picker.pickImage(source: ImageSource.camera);
      if (capturedImage != null) {
        String? filePath = capturedImage.path;
        String fileName = capturedImage.name;
        FileType fileType = _determineFileType('jpg');

        _messages.add(ChatMessage(
          message: '',
          isSentByMe: isSentByMe,
          filePath: filePath,
          fileName: fileName,
          fileType: fileType,
        ));
        _errorMessage = ''; // Clear any previous errors
      } else {
        _errorMessage = 'No image selected.';
      }
    } catch (e) {
      _errorMessage = 'Failed to capture image: $e';
    }
    notifyListeners();
  }

  Future<void> sendFromGallery(bool isSentByMe) async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String? filePath = pickedImage.path;
        String fileName = pickedImage.name;
        FileType fileType = _determineFileType('jpg');

        _messages.add(ChatMessage(
          message: '',
          isSentByMe: isSentByMe,
          filePath: filePath,
          fileName: fileName,
          fileType: fileType,
        ));
        _errorMessage = '';
      } else {
        _errorMessage = 'No image selected.';
      }
    } catch (e) {
      _errorMessage = 'Failed to pick image from gallery: $e';
    }
    notifyListeners();
  }

  Future<void> sendFile(bool isSentByMe) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.any);
      if (result != null) {
        String? filePath = result.files.single.path;
        String fileName = result.files.single.name;
        FileType fileType = _determineFileType(result.files.single.extension);

        _messages.add(ChatMessage(
          message: '',
          isSentByMe: isSentByMe,
          filePath: filePath,
          fileName: fileName,
          fileType: fileType,
        ));
        _errorMessage = '';
      } else {
        _errorMessage = 'No file selected.';
      }
    } catch (e) {
      _errorMessage = 'Failed to pick file: $e';
    }
    notifyListeners();
  }

  Future<void> sendAudio(bool isSentByMe) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.audio);
      if (result != null) {
        String? filePath = result.files.single.path;
        String fileName = result.files.single.name;
        FileType fileType = _determineFileType(result.files.single.extension);

        _messages.add(ChatMessage(
          message: '',
          isSentByMe: isSentByMe,
          filePath: filePath,
          fileName: fileName,
          fileType: fileType,
        ));
        _errorMessage = '';
      } else {
        _errorMessage = 'No audio file selected.';
      }
    } catch (e) {
      _errorMessage = 'Failed to pick audio file: $e';
    }
    notifyListeners();
  }

  void sendMessage(String? message, bool isSentByMe, {String? filePath}) {
    _messages.add(ChatMessage(
      audiofile: filePath,
      message: message,
      isSentByMe: isSentByMe,
    ));

    if (isSentByMe && filePath == null) {
      _simulateResponse();
    }

    if (filePath != null) {
      _filePath = null;
    }
    notifyListeners();
  }

  void _simulateResponse() {
    Future.delayed(Duration(seconds: 2), () {
      _messages.add(ChatMessage(
        message: "hi response",
        isSentByMe: false,
      ));
      notifyListeners();
    });
  }

  // audio player session

  List<AudioRecorder> audioList = [];
  final RecorderController recorderController = RecorderController();
  final PlayerController playerController = PlayerController();

  // Request Microphone Permission
  Future<bool> _requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }

  // Start Recording with waveform visualization
  Future<void> startRecording() async {
    _filePath = null;
    if (await _requestMicrophonePermission()) {
      final directory = await getApplicationDocumentsDirectory();
      _filePath =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';

      if (await _record.hasPermission()) {
        await _record.start(
          const RecordConfig(),
          path: _filePath.toString(),
        );
        recorderController.record().then(
          (value) {
            // audioList.add(_record);
          },
        ); // Start showing waveforms
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
      _isPlaying = false;
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

  // custom  play

  Future<void> playAudioCM(String? filepath) async {
    if (filepath != null && File(filepath).existsSync()) {
      _isPlaying = true;
      playerController.preparePlayer(
          path: filepath, shouldExtractWaveform: true);
      await _audioPlayer.setFilePath(filepath);
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

  // cleear audio data
  //
  onClear() {
    _filePath = null;
    notifyListeners();
  }

  // just audio  waveform
  final progressStream = BehaviorSubject<WaveformProgress>();

  // Future<void> _init() async {
  //   final audioFile =
  //       File(p.join((await getTemporaryDirectory()).path, 'waveform.mp3'));
  //   try {
  //     await audioFile.writeAsBytes(
  //         (await rootBundle.load('audio/waveform.mp3')).buffer.asUint8List());
  //     final waveFile =
  //         File(p.join((await getTemporaryDirectory()).path, 'waveform.wave'));
  //     JustWaveform.extract(audioInFile: audioFile, waveOutFile: waveFile)
  //         .listen(progressStream.add, onError: progressStream.addError);
  //   } catch (e) {
  //     progressStream.addError(e);
  //   }
  // }
}

FileType _determineFileType(String? extension) {
  if (extension == null) return FileType.any;
  if (['jpg', 'jpeg', 'png', 'gif'].contains(extension.toLowerCase())) {
    return FileType.image;
  }
  return FileType.any;
}
