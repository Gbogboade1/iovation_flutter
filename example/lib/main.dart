import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:iovation_flutter/iovation_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await IovationFlutter.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  bool loading = false;
  updateLoading(bool status){
    setState(() {
      loading  = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            MaterialButton(
              onPressed: () async{
               updateLoading(true);
                final result = await IovationFlutter.initializeIovation(subscriberKey: '87654321');
               updateLoading(false);
                print(result);

              },
              child:const Text('Init Iovation'),
              color: Colors.red,
            ),
            MaterialButton(
              onPressed: () async{
                updateLoading(true);
                final result = await IovationFlutter.getBlackBoxString();
                updateLoading(false);
                print(result);

              },
              child:const Text('Get String'),
              color: Colors.green,
            ),
            if(loading)Center(child: CircularProgressIndicator(),),
          ],
        ),
      ),
    );
  }
}
