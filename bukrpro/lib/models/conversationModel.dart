import 'package:file_picker/file_picker.dart';

class ChatMessage {
  final String? message;
  final bool isSentByMe;
  final String? filePath;
  final String? fileName;
  final FileType? fileType;
  final String? audiofile;
  DateTime? dateTime = DateTime.now();

  ChatMessage(
      {required this.message,
      required this.isSentByMe,
      this.filePath,
      this.fileName,
      this.fileType,
      this.audiofile,
      this.dateTime});
}
