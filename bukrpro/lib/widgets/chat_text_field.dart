import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:voice_message_package/voice_message_package.dart';
import '../controllers/chatcontroller.dart';
import 'popup.dart'; // Adjust based on your popup import path

class ChatTextField extends StatelessWidget {
  ChatTextField({super.key, required TextEditingController msgcontroller})
      : _msgcontroller = msgcontroller;

  final TextEditingController _msgcontroller;
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final chatController = Get.find<ChatController>();
    // Use GetX to find the controller
    return Row(
      children: [
        Obx(() {
          if (!chatController.isRecording.value &&
              chatController.filePath.isEmpty) {
            return Expanded(
              child: TextField(
                autofocus: false,
                focusNode: _focusNode,

                // canRequestFocus: true,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                controller: _msgcontroller,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        }),
        Obx(() {
          if (chatController.isRecording.isTrue) {
            return Expanded(
              child: Container(
                color: const Color(0xff5473bb),
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                //color: Colors.greenAccent,
                child: const Center(
                  child: Text("Recording..."),
                ),
              ),
            );
          } else {
            return Container(); // Empty container when not recording
          }
        }),
        Obx(() {
          if (chatController.filePath.value.isNotEmpty &&
              !chatController.isRecording()) {
            return Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 28,
                    icon: const CircleAvatar(
                        child: Center(
                            child: Icon(Icons.delete, color: Colors.black))),
                    onPressed: () async {
                      chatController.deleteRecordedAudio();
                    },
                  ),
                  VoiceMessageView(
                    activeSliderColor: Colors.green,
                    circlesColor: Colors.black,
                    controller: VoiceController(
                      maxDuration: const Duration(minutes: 5),
                      isFile: true,
                      audioSrc: chatController.filePath.value,
                      onComplete: () {},
                      onPause: () {},
                      onPlaying: () {},
                      onError: (err) {},
                    ),
                    innerPadding: 12,
                    cornerRadius: 20,
                  ),
                  IconButton(
                    iconSize: 28,
                    icon: const CircleAvatar(
                        child: Center(
                            child: Icon(Icons.send, color: Colors.black))),
                    onPressed: () async {
                      chatController.sendMessage(null, true, DateTime.now(),
                          filePath: chatController.filePath.value);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        }),
        Obx(() {
          if (chatController.filePath.value.isEmpty ||
              chatController.isRecording()) {
            return Row(
              children: [
                IconButton(
                  iconSize: 28,
                  icon: const Icon(Icons.attach_file, color: Colors.black),
                  onPressed: () {
                    _focusNode.requestFocus();

                    _showIconPopup(context);
                    _focusNode.unfocus();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                      onTap: () {
                        chatController.onTapHandler();
                      },
                      onLongPress: () {
                        chatController.onLongPressHandler();
                      },
                      onLongPressUp: () {
                        chatController.stopRecording();
                      },
                      child: Icon(
                          chatController.isRecording()
                              ? Icons.cancel
                              : Icons.mic,
                          size: 30)),
                ),
                IconButton(
                  iconSize: 28,
                  icon: const Icon(Icons.send, color: Colors.black),
                  onPressed: () async {
                    if (_msgcontroller.text.trim().isNotEmpty) {
                      chatController.sendMessage(
                          _msgcontroller.text, true, DateTime.now());
                      _msgcontroller.clear();
                    }
                  },
                ),
              ],
            );
          } else {
            return Container();
          }
        })
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
