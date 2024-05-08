import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randomizer!!!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Randomizer!!!'),
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
  int _number = 0;
  String _msg = '';

  // Generate a random number between 0 and 100, and check if it is even or odd, then update the state
  // with the new number and message.
  void _getRandomNumber() {
    setState(() {     
      var rng = Random();
      _number = rng.nextInt(100); 
      if (_number % 2 == 0) {
        _msg = 'par.';
      } else {
        _msg = 'impar.';
      }
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
              'Presiona el botón randomizador',
              style: TextStyle(fontSize: 30, color: Colors.red)
            ),
            if (_number > 0) 
              Text(
                '$_number', 
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            if (_number > 0)
              Text('el numero obtenido es $_msg', style: const TextStyle(fontSize: 30, color: Colors.red)),
              
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getRandomNumber,
        tooltip: 'Randomize',
        hoverColor: Colors.red,
        child: const Icon(Icons.report_gmailerrorred_sharp), 
      ), 
    );
  }
}
