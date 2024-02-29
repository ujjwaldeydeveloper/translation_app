import 'package:flutter/material.dart';
import 'package:trsnslation_app/presentation/widgets/card_widget.dart';
import '../utills/global.dart' as globals;

class TextSubmitWidget extends StatefulWidget {
  const TextSubmitWidget({super.key});

  @override
  State<TextSubmitWidget> createState() => _TextSubmitWidgetState();
}

class _TextSubmitWidgetState extends State<TextSubmitWidget> {
  final _controller = TextEditingController();

  String enterText = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            // suffixIcon: Icon(Icons.save),
            labelText: 'Enter Text',
          ),
          controller: _controller,
          onChanged: (value) {
            setState(() {
              enterText = value;
            });
          },
        ),
        ElevatedButton(
            onPressed: () {
              if (_controller.value.text.isNotEmpty) {
                globals.globalEditTextVar = _controller.value.text;
              }
              Navigator.of(context).pop();
            },
            child: const Text('Save')),
      ],
    );
  }
}
