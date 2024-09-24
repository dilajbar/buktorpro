import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bukrpro/providers/chatProvider.dart';
import 'package:bukrpro/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voice_message_package/voice_message_package.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key, required TextEditingController msgcontroller})
      : _msgcontroller = msgcontroller;

  final TextEditingController _msgcontroller;

  @override
  Widget build(BuildContext context) {
    final chatPro = context.watch<ChatProvider>();
    return Row(
      children: [
        if (!chatPro.isRecording && chatPro.filePath == null)
          Expanded(
            child: TextField(
              autofocus: false,
              canRequestFocus: false,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              controller: _msgcontroller,
              //focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        if (chatPro.isRecording)
          AudioWaveforms(
            enableGesture: true,
            size: Size(MediaQuery.of(context).size.width / 2, 50),
            recorderController: chatPro.recorderController,
            waveStyle: const WaveStyle(
              middleLineColor: Colors.transparent,
              waveColor: Colors.green,
              extendWaveform: true,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: const Color(0xFF1E1B26),
            ),
            padding: const EdgeInsets.only(left: 18),
            margin: const EdgeInsets.symmetric(horizontal: 15),
          ),
        if (chatPro.filePath != null && !chatPro.isRecording)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VoiceMessageView(
                  controller: VoiceController(
                    maxDuration: const Duration(minutes: 5),
                    isFile: true,
                    audioSrc: chatPro.filePath!,
                    onComplete: () {
                      /// do something on complete
                    },
                    onPause: () {
                      /// do something on
                    },
                    onPlaying: () {
                      // do something on playing
                    },
                    onError: (err) {
                      /// do somethin on error
                    },
                  ),
                  innerPadding: 12,
                  cornerRadius: 20,
                ),
                IconButton(
                  iconSize: 28,
                  icon: const CircleAvatar(
                      child:
                          Center(child: Icon(Icons.send, color: Colors.black))),
                  onPressed: () async {
                    chatPro.sendMessage(null, true, DateTime.now(),
                        filePath: chatPro.filePath);
                    // Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        if (chatPro.filePath == null || chatPro.isRecording)
          Row(
            children: [
              IconButton(
                iconSize: 28,
                icon: const Icon(Icons.attach_file, color: Colors.black),
                onPressed: () {
                  _showIconPopup(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                    onLongPress: () {
                      chatPro.startRecording();
                    },
                    onLongPressUp: () {
                      chatPro.stopRecording();
                    },
                    child: Icon(chatPro.isRecording ? Icons.cancel : Icons.mic,
                        size: 30)),
              ),
              IconButton(
                iconSize: 28,
                icon: const Icon(Icons.send, color: Colors.black),
                onPressed: () async {
                  if (_msgcontroller.text.trim().isNotEmpty) {
                    chatPro.sendMessage(
                        _msgcontroller.text, true, DateTime.now());
                    _msgcontroller.clear();
                  }
                },
              ),
            ],
          )
      ],
    );
  }

  void _showIconPopup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return IconPopup();
      },
    );
  }
}
