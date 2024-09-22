import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/audioProvider.dart';

import 'package:audio_waveforms/audio_waveforms.dart'; // Import for visualizations

class AudioRecorderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('audio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (audioProvider.isRecording)
              AudioWaveforms(
                enableGesture: true,
                size: Size(MediaQuery.of(context).size.width / 2, 50),
                recorderController: audioProvider.recorderController,
                waveStyle: const WaveStyle(
                  waveColor: Colors.white,
                  extendWaveform: true,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: const Color(0xFF1E1B26),
                ),
                padding: const EdgeInsets.only(left: 18),
                margin: const EdgeInsets.symmetric(horizontal: 15),
              ),
            SizedBox(height: 20),
            // Record/Stop Recording Button
            ElevatedButton(
              onPressed: audioProvider.isRecording
                  ? audioProvider.stopRecording
                  : audioProvider.startRecording,
              child: Text(audioProvider.isRecording
                  ? 'Stop Recording'
                  : 'Start Recording'),
            ),
            SizedBox(height: 20),
            // Play/Stop Audio Button with waveform animation during playback
            if (audioProvider.filePath != null)
              Column(
                children: [
                  AudioFileWaveforms(
                    playerWaveStyle: const PlayerWaveStyle(
                      scaleFactor: 0.9,
                      fixedWaveColor: Colors.red,
                      liveWaveColor: Colors.white,
                      waveCap: StrokeCap.butt,
                    ),
                    size: Size(MediaQuery.of(context).size.width / 2, 50),
                    playerController: audioProvider.playerController,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: const Color(0xFF1E1B26),
                    ),
                    padding: const EdgeInsets.only(left: 18),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: audioProvider.isPlaying
                        ? audioProvider.stopAudio
                        : audioProvider.playAudio,
                    child: Text(audioProvider.isPlaying
                        ? 'Stop Playing'
                        : 'Play Audio'),
                  ),
                ],
              ),
            SizedBox(height: 20),
            if (audioProvider.filePath != null)
              Text('Recorded file path: ${audioProvider.filePath}'),
          ],
        ),
      ),
    );
  }
}
