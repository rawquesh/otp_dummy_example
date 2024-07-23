import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  bool loading = false;
  void _showPopup() async {
    setState(() {
      loading = false;
    });
    bool badPin = false;

    String titleString = 'Please introduce below the access code sent as a text message to 12312.';

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titleString),
            content: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Pinput(
                      length: 6,
                      autofocus: true,
                      defaultPinTheme: PinTheme(
                        width: 40,
                        height: 40,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green[800]!),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 40,
                        height: 40,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 40,
                        height: 40,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Align(
                    alignment: const Alignment(-1, 0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: (badPin ? 50 : 0) * MediaQuery.of(context).textScaler.scale(1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '\nThe code you typed was incorrect.',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.green[800]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'App',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPopup,
        tooltip: 'Popup',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
