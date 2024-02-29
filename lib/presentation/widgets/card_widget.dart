import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class CardItemWidget extends StatefulWidget {
  const CardItemWidget({super.key, required this.modelInstanceValue});
  final String modelInstanceValue;

  @override
  State<CardItemWidget> createState() => _CardItemWidgetState();
}

class _CardItemWidgetState extends State<CardItemWidget> {
  bool showHindi = false;
  @override
  void initState() {
    showHindi = false;
    super.initState();
  }

  Future<String> hindiTranslation(String str) async {
    OnDeviceTranslator onDeviceTranslator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.english,
        targetLanguage: TranslateLanguage.hindi);
    String response = await onDeviceTranslator.translateText(str);
    onDeviceTranslator.close();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            // height: 80,
            width: double.infinity,
            child: Card(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.modelInstanceValue,
                    ),
                  ),
                  showHindi
                      ? FutureBuilder(
                          future: hindiTranslation(widget.modelInstanceValue),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  snapshot.data ?? '',
                                ),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.none) {
                              return const Text("No data");
                            }
                            return const CircularProgressIndicator();
                          })
                      : Container(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showHindi = !showHindi;
                      });
                    },
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: Card(
                          color: Colors.blue,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Read In Hindi',
                              style: TextStyle(color: Colors.amber),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
