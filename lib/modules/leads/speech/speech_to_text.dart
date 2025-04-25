import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceNoteWidget extends StatefulWidget {
  final void Function(String text) onResult;

  const VoiceNoteWidget({super.key, required this.onResult});

  @override
  _VoiceNoteWidgetState createState() => _VoiceNoteWidgetState();
}

class _VoiceNoteWidgetState extends State<VoiceNoteWidget> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _manuallyStopped = false;
  String _fullText = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    await _speech.initialize(
      onError: (error) {
        print('🎙️ Speech error: $error');
      },
      onStatus: (status) {
        print('🎙️ Speech status: $status');
        if ((status == 'done' || status == 'notListening') && !_manuallyStopped) {
          setState(() => _isListening = false);
          // Restartuj nasłuch po upłynięciu limitu czasu
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) _startListening();
          });
        }
      },
    );
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _isListening = true;
        _manuallyStopped = false; // resetujemy ręczne zatrzymanie
      });

      _speech.listen(
        listenFor: const Duration(minutes: 1), // każda sesja trwa max 1 minutę
        pauseFor: const Duration(seconds: 0),
        listenOptions: stt.SpeechListenOptions(
          listenMode: stt.ListenMode.dictation,
          partialResults: true,
          cancelOnError: false,
        ),
        onResult: (result) {
          setState(() {
            _fullText = result.recognizedWords;
          });
          widget.onResult(_fullText);
        },
      );
    } else {
      print('❌ Speech not available');
    }
  }

  void _stopListening() {
    _manuallyStopped = true; // użytkownik sam kliknął stop
    _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
      onPressed: _isListening ? _stopListening : _startListening,
    );
  }
}
