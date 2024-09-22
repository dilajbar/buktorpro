import 'package:bukrpro/providers/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          height: 150,
          child: Column(
            children: <Widget>[
              const Text(
                'Select an action',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.file_open, size: 30),
                    onPressed: () {
                      Provider.of<ChatProvider>(context, listen: false)
                          .sendFile(true);
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt, size: 30),
                    onPressed: () {
                      Provider.of<ChatProvider>(context, listen: false)
                          .sendImageFromCamera(true);
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.contact_page, size: 30),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.headphones, size: 30),
                    onPressed: () {
                      Provider.of<ChatProvider>(context, listen: false)
                          .sendAudio(true);
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_album, size: 30),
                    onPressed: () {
                      Provider.of<ChatProvider>(context, listen: false)
                          .sendFromGallery(true);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
