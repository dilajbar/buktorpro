import 'package:bukrpro/providers/chatProvider.dart';
import 'package:bukrpro/screens/chat_page.dart';
import 'package:bukrpro/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required TextEditingController msgcontroller,
  }) : _msgcontroller = msgcontroller;

  final TextEditingController _msgcontroller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: false,
            // canRequestFocus: false,
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
