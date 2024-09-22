import 'dart:math';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bukrpro/providers/chatProvider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:provider/provider.dart';
import 'package:voice_message_package/voice_message_package.dart';

class IconPopup extends StatefulWidget {
  @override
  State<IconPopup> createState() => _IconPopupState();
}

class _IconPopupState extends State<IconPopup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<ChatProvider>().onClear();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatPro = context.watch<ChatProvider>();
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

                  //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.file_open, size: 30),
                      onPressed: () {
                        Provider.of<ChatProvider>(context, listen: false)
                            .sendFile(true);
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt, size: 30),
                      onPressed: () {
                        Provider.of<ChatProvider>(context, listen: false)
                            .sendImageFromCamera(true);
                         Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.contact_page, size: 30),
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
                      icon: const Icon(Icons.photo_album, size: 30),
                      onPressed: () {
                        Provider.of<ChatProvider>(context, listen: false)
                            .sendFromGallery(true);
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(chatPro.isRecording ? Icons.cancel : Icons.mic,
                          size: 30),
                      onPressed: () {
                        if (chatPro.isRecording) {
                          chatPro.stopRecording();
                        } else {
                          chatPro.startRecording();
                        }
                        // Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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
                Row(
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
                          /// do something on pause
                        },
                        onPlaying: () {
                          /// do something on playing
                        },
                        onError: (err) {
                          /// do somethin on error
                        },
                      ),
                      // maxDuration: const Duration(seconds: 10),
                      // isFile: false,
                      innerPadding: 12,
                      cornerRadius: 20,
                    ),
                    IconButton(
                      iconSize: 28,
                      icon: const CircleAvatar(child: Center(child: Icon(Icons.send, color: Colors.black))),
                      onPressed: () async {
                        chatPro.sendMessage(null, true,filePath: chatPro.filePath);
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

// audio form wave widget and custom painter

class AudioWaveformWidget extends StatefulWidget {
  final Color waveColor;
  final double scale;
  final double strokeWidth;
  final double pixelsPerStep;
  final Waveform waveform;
  final Duration start;
  final Duration duration;

  const AudioWaveformWidget({
    Key? key,
    required this.waveform,
    required this.start,
    required this.duration,
    this.waveColor = Colors.blue,
    this.scale = 1.0,
    this.strokeWidth = 5.0,
    this.pixelsPerStep = 8.0,
  }) : super(key: key);

  @override
  _AudioWaveformState createState() => _AudioWaveformState();
}

class _AudioWaveformState extends State<AudioWaveformWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: AudioWaveformPainter(
          waveColor: widget.waveColor,
          waveform: widget.waveform,
          start: widget.start,
          duration: widget.duration,
          scale: widget.scale,
          strokeWidth: widget.strokeWidth,
          pixelsPerStep: widget.pixelsPerStep,
        ),
      ),
    );
  }
}

class AudioWaveformPainter extends CustomPainter {
  final double scale;
  final double strokeWidth;
  final double pixelsPerStep;
  final Paint wavePaint;
  final Waveform waveform;
  final Duration start;
  final Duration duration;

  AudioWaveformPainter({
    required this.waveform,
    required this.start,
    required this.duration,
    Color waveColor = Colors.blue,
    this.scale = 1.0,
    this.strokeWidth = 5.0,
    this.pixelsPerStep = 8.0,
  }) : wavePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..color = waveColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (duration == Duration.zero) return;

    double width = size.width;
    double height = size.height;

    final waveformPixelsPerWindow = waveform.positionToPixel(duration).toInt();
    final waveformPixelsPerDevicePixel = waveformPixelsPerWindow / width;
    final waveformPixelsPerStep = waveformPixelsPerDevicePixel * pixelsPerStep;
    final sampleOffset = waveform.positionToPixel(start);
    final sampleStart = -sampleOffset % waveformPixelsPerStep;
    for (var i = sampleStart.toDouble();
        i <= waveformPixelsPerWindow + 1.0;
        i += waveformPixelsPerStep) {
      final sampleIdx = (sampleOffset + i).toInt();
      final x = i / waveformPixelsPerDevicePixel;
      final minY = normalise(waveform.getPixelMin(sampleIdx), height);
      final maxY = normalise(waveform.getPixelMax(sampleIdx), height);
      canvas.drawLine(
        Offset(x + strokeWidth / 2, max(strokeWidth * 0.75, minY)),
        Offset(x + strokeWidth / 2, min(height - strokeWidth * 0.75, maxY)),
        wavePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant AudioWaveformPainter oldDelegate) {
    return false;
  }

  double normalise(int s, double height) {
    if (waveform.flags == 0) {
      final y = 32768 + (scale * s).clamp(-32768.0, 32767.0).toDouble();
      return height - 1 - y * height / 65536;
    } else {
      final y = 128 + (scale * s).clamp(-128.0, 127.0).toDouble();
      return height - 1 - y * height / 256;
    }
  }
}
