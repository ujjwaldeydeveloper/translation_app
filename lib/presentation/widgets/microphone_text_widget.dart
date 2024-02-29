import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../utills/global.dart' as globals;

class MicroPhoneTextWidget extends StatefulWidget {
  const MicroPhoneTextWidget({super.key});

  @override
  State<MicroPhoneTextWidget> createState() => _MicroPhoneTextWidgetState();
}

class _MicroPhoneTextWidgetState extends State<MicroPhoneTextWidget> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  // double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            globals.globalEditTextVar = _text;
            // if (val.hasConfidenceRating && val.confidence > 0) {
            //   _confidence = val.confidence;
            // }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(alignment: Alignment.topLeft, child: Text(_text)),
          Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                  onPressed: _listen,
                  child: Icon(_isListening ? Icons.mic : Icons.mic_off))),
        ],
      ),
    );
  }
}
