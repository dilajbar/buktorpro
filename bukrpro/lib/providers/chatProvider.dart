import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';

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

  void sendMessage(String message, bool isSentByMe) {
    _messages.add(ChatMessage(
      message: message,
      isSentByMe: isSentByMe,
    ));
    notifyListeners();

    if (isSentByMe) {
      _simulateResponse();
    }
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
}

FileType _determineFileType(String? extension) {
  if (extension == null) return FileType.any;
  if (['jpg', 'jpeg', 'png', 'gif'].contains(extension.toLowerCase())) {
    return FileType.image;
  }
  return FileType.any;
}
