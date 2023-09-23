import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Stream<SpamWidget> spamStream() async* {
  while (true) {
    await Future.delayed(const Duration(seconds: 1));
    yield const SpamWidget();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Test app'),
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
  List<Widget> spams = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: SizedBox(
            height: 300,
            width: 350,
            child: StreamBuilder(
                stream: spamStream(),
                builder: (context, AsyncSnapshot<SpamWidget> snapshot) {
                  if (!snapshot.hasData) return const SizedBox.shrink();
                  spams = [...spams, snapshot.data!];
                  return ListView(
                    children: spams,
                  );
                }),
          ),
        ));
  }
}

class SpamWidget extends StatelessWidget {
  const SpamWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 100, right: 100),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 5)),
        child: const Text('Spam',
            style: TextStyle(
                color: Colors.red, fontSize: 50, fontWeight: FontWeight.bold)),
      );
}
