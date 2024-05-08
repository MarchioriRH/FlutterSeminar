    
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
  int _counter = 0;
  var _layout=MainAxisAlignment.center;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _nextLayout() {
    setState(() {
        _layout=_nextEnumLayout(_layout);
    });
  }

  MainAxisAlignment _nextEnumLayout(MainAxisAlignment value) {
    final nextIndex = (value.index + 1) % MainAxisAlignment.values.length;
    return MainAxisAlignment.values[nextIndex];
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
          mainAxisAlignment: _layout,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
             
            const Text(
              'Current layout:',
            ),
            Text(
              '$_layout',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.blue,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.plus_one,color: Colors.white),
            label: 'Increment',
            backgroundColor: Colors.blueAccent,
            onTap: _incrementCounter,
          ),
          SpeedDialChild(
            child: const Icon(Icons.layers_outlined,color: Colors.white),
            label: 'Layout',
            backgroundColor: Colors.blueAccent,
            onTap: _nextLayout,
          ),
        ],
      ),       
    );
  }
}
