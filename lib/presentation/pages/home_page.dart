import 'package:flutter/material.dart';
import 'package:trsnslation_app/data/api_service.dart';

import '../../domain/translation_data_model.dart';
import '../widgets/card_widget.dart';
import '../widgets/edit_text_widget.dart';
import '../utills/global.dart' as globals;
import '../widgets/microphone_text_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Data> _availableData = [];

  void loadData() async {
    dynamic apiResponse = await ApiService().getTranslationData();
    setState(() {
      _availableData = apiResponse.data!;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void showModalSheet() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: const Column(
                children: [
                  TextSubmitWidget(),
                  MicroPhoneTextWidget(),
                ],
              ));
        },
      ).then((value) {
        setState(() {});
        // Navigator.of(context).pop();
        // CardItemWidget(
        //   modelInstanceValue: 'value',
        // );
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Translation App E2H'),
      ),
      body: Center(
        child: _availableData.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  Expanded(
                    // height: 300,
                    child: ListView.builder(
                        itemCount: _availableData.length,
                        itemBuilder: (context, index) {
                          // bool showHindi = false;
                          return CardItemWidget(
                              modelInstanceValue:
                                  _availableData[index].value ?? '');
                        }),
                  ),
                  CardItemWidget(modelInstanceValue: globals.globalEditTextVar),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showModalSheet,
        label: const Text('Scan'),
      ),
    );
  }
}
