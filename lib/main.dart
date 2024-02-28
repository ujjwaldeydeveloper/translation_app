import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trsnslation_app/domain/translation_data_model.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Data> _availableData = [];

  final localJson = {
    "statusCode": 200,
    "message": "English data that need translation to hindi",
    "data": [
      {
        "id": 11989,
        "value": "1 Year Service Warranty & 5 Years Plywood Warranty",
        "createdAt": "2024-01-06 12:08:11",
        "updatedAt": "2024-01-06 12:08:11"
      },
      {
        "id": 11990,
        "value":
            "Customer Should inform about the Changes (if any Design & colour) before\nproduction or else Customer should pay Extra",
        "createdAt": "2024-01-06 12:08:11",
        "updatedAt": "2024-01-06 12:08:11"
      },
      {
        "id": 11991,
        "value":
            "Material will be delivered 3-4 weeks the date of Confirmation of Order",
        "createdAt": "2024-01-06 12:08:11",
        "updatedAt": "2024-01-06 12:08:11"
      },
      {
        "id": 11992,
        "value":
            "Quotation cant be changed / revised once accepted by the customer",
        "createdAt": "2024-01-06 12:08:11",
        "updatedAt": "2024-01-06 12:08:11"
      },
      {
        "id": 11993,
        "value":
            "If any extra works are needed then it should be paid by customer",
        "createdAt": "2024-01-06 12:08:11",
        "updatedAt": "2024-01-06 12:08:11"
      },
      {
        "id": 11994,
        "value":
            "Custom Handles will be charged extra.Handle price may vary based of designs &\nspecifications",
        "createdAt": "2024-01-06 12:08:11",
        "updatedAt": "2024-01-06 12:08:11"
      },
      {
        "id": 11995,
        "value": "Once the Project is confirmed, the amount cannot be refunded",
        "createdAt": "2024-01-06 12:08:11",
        "updatedAt": "2024-01-06 12:08:11"
      },
      {
        "id": 11996,
        "value": "This Quote will be valid only for 15 Days",
        "createdAt": "2024-01-06 12:08:11",
        "updatedAt": "2024-01-06 12:08:11"
      },
      {
        "id": 11997,
        "value":
            "Any additional work which is out of the quotation in any aspects is to be paid extra by\nthe customer",
        "createdAt": "2024-01-06 12:08:11",
        "updatedAt": "2024-01-06 12:08:11"
      }
    ]
  };

  // bool showHindi = false;
  void loadData() async {
    // final res = await rootBundle.loadString('assets/local_data.json');
    final translationData =
        TranslationDataModel.fromJson(localJson as Map<String, dynamic>);

    setState(() {
      _availableData = translationData.data!;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bool showHindi = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Translation App E2H'),
      ),
      body: Center(
        child: _availableData.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: _availableData.length,
                itemBuilder: (context, index) {
                  // bool showHindi = false;
                  return CardItemWidget(modelInstance: _availableData[index]);
                }),
      ),
    );
  }
}

class CardItemWidget extends StatefulWidget {
  const CardItemWidget({super.key, required this.modelInstance});
  final Data modelInstance;

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
                      widget.modelInstance.value ?? '',
                    ),
                  ),
                  showHindi
                      ? FutureBuilder(
                          future: hindiTranslation(
                              widget.modelInstance.value ?? ''),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  snapshot.data ?? 'jhgjh',
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
