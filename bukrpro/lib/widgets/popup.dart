import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../controllers/chatcontroller.dart'; // Ensure the correct ChatController import

class IconPopup extends StatefulWidget {
  @override
  State<IconPopup> createState() => _IconPopupState();
}

class _IconPopupState extends State<IconPopup> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ChatController>().onClear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatController = Get.find<ChatController>();

    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              const Text(
                'Select an action',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.file_open, size: 30),
                      onPressed: () {
                        chatController.sendFile(true, DateTime.now());
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt, size: 30),
                      onPressed: () {
                        chatController.sendImageFromCamera(
                            true, DateTime.now());
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.contact_page, size: 30),
                      onPressed: () {
                        // Add any contact functionality here
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.headphones, size: 30),
                      onPressed: () {
                        chatController.sendAudio(true, DateTime.now());
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.photo_album, size: 30),
                      onPressed: () {
                        chatController.sendFromGallery(true, DateTime.now());
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
