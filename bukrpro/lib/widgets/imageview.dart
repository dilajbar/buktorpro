import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FullImageView extends StatelessWidget {
  final File imageFile;

  FullImageView({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: InteractiveViewer(
        panEnabled: true,
        boundaryMargin: const EdgeInsets.all(20),
        minScale: 1,
        maxScale: 4,
        child: Image.file(
          imageFile,
        ),
      )),
    );
  }
}
