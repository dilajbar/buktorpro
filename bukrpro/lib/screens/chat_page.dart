import 'dart:io';
import 'package:bukrpro/widgets/popup.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/conversationModel.dart';
import '../providers/audioProvider.dart';
import '../providers/chatProvider.dart';

class ChatPage extends StatelessWidget {
  ChatPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final TextEditingController _msgcontroller = TextEditingController();

    ChatProvider chatmodel = context.watch<ChatProvider>();
    final messeges = chatmodel.chatModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(messeges!.name.toString()),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                return ListView.builder(
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatProvider.messages[index];
                    return _buildMessageBubble(message, context);
                  },
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
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
              IconButton(
                iconSize: 28,
                icon: Icon(Icons.attach_file, color: Colors.black),
                onPressed: () {
                  _showIconPopup(context);
                },
              ),
              IconButton(
                iconSize: 28,
                icon: Icon(Icons.camera_alt_outlined, color: Colors.black),
                onPressed: () {
                  Provider.of<ChatProvider>(context, listen: false)
                      .sendImageFromCamera(true);
                },
              ),
              IconButton(
                iconSize: 28,
                icon: Icon(Icons.send, color: Colors.black),
                onPressed: () async {
                  if (_msgcontroller.text.trim().isNotEmpty) {
                    Provider.of<ChatProvider>(context, listen: false)
                        .sendMessage(_msgcontroller.text, true);
                    _msgcontroller.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildMessageBubble(ChatMessage message, context) {
  if (message.filePath != null) {
    return Align(
      alignment:
          message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: _buildFileWidget(message, context),
      ),
    );
  }

  return Align(
    alignment:
        message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: message.isSentByMe ? Colors.blue[200] : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        message.message,
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
}

Widget _buildFileWidget(ChatMessage message, context) {
  if (message.fileType == FileType.image && message.filePath != null) {
    //   final imageProvider = Image.file(File(message.filePath!)).image;
    return GestureDetector(
      onTap: () {
        // showImageViewer(context, imageProvider, onViewerDismissed: () {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 4, // Add a border
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Image.file(
          File(message.filePath!),
          width: 300,
          height: 300,
          fit: BoxFit.cover,
        ),
      ),
    );
  } else {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.attach_file, color: Colors.black),
          Text(
            message.fileName ?? 'Unknown file',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

void _showIconPopup(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return IconPopup();
    },
  );
}
