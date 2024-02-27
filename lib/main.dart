import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trsnslation_app/domain/translation_data_model.dart';

void main() {
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

  // bool showHindi = false;
  void loadData() async {
    final res = await rootBundle.loadString('local_data.json');
    final translationData =
        TranslationDataModel.fromJson(jsonDecode(res) as Map<String, dynamic>);

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
  const CardItemWidget({super.key,required this.modelInstance});
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
                  Visibility(
                    visible: showHindi,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.modelInstance.value ?? '',
                      ),
                    ),
                  ),
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
