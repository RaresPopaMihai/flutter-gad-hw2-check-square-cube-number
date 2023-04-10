import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const DoubleTriangleHWApp());
}

class DoubleTriangleHWApp extends StatelessWidget {
  const DoubleTriangleHWApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _numberController = TextEditingController();
  String _errorTextValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Shapes'),
      ),
      body: Column(
        children: <Widget>[
          const Text(
            'Please input a number to see if it is square or triangular.',
            style: TextStyle(fontSize: 25),
          ),
          TextField(
            controller: _numberController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(errorText: _errorTextValue.isEmpty ? null : _errorTextValue),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int? number;
          final String inputNumber = _numberController.text;
          number = int.tryParse(inputNumber);
          if (number == null) {
            _errorTextValue = 'Please enter a valid number!';
          } else {
            if (_errorTextValue.isNotEmpty) {
              _errorTextValue = '';
            }
            String message = '';
            if (isSquare(number) && isTriangle(number)) {
              message = 'Number $number is both SQUARE and TRIANGULAR.';
            } else if (isSquare(number)) {
              message = 'Number $number is SQUARE.';
            } else if (isTriangle(number)) {
              message = 'Number $number is TRIANGULAR.';
            } else {
              message = 'Number $number is neither SQUARE or TRIANGULAR.';
            }
            popDialog(number, message);
          }
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.check),
      ),
    );
  }

  bool isSquare(int value) {
    return sqrt(value) % 1 == 0;
  }

  bool isTriangle(int value) {
    final int cubeRoot = pow(value, 1 / 3).round();
    return cubeRoot * cubeRoot * cubeRoot == value;
  }

  Future<dynamic> popDialog(int number, String message) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(number.toString()),
            content: Text(message),
          );
        },
      );
}
