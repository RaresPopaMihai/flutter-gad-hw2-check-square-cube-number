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
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _numberController = TextEditingController();
  String errorTextValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Number Shapes"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Please input a number to see if it is square or triangular.',
            style: TextStyle(
              fontSize: 25
            ),
          ),
          TextField(
            controller: _numberController,
            keyboardType: const TextInputType.numberWithOptions( decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              errorText: errorTextValue.isEmpty ? null : errorTextValue
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          setState(() {
          int? number;
          String inputNumber = _numberController.text;
          number = int.tryParse(inputNumber);
          if(number == null){
            errorTextValue = "Please enter a valid number!";
          }else{
            if(!errorTextValue.isEmpty){
              errorTextValue = "";
            }
            String message = "";
            if(isSquare(number)&& isTriangle(number)){
              message = "Number ${number} is both SQUARE and TRIANGULAR.";
            }else if(isSquare(number)){
              message = "Number ${number} is SQUARE.";
            }else if(isTriangle(number)){
              message = "Number ${number} is TRIANGULAR.";
            }
            else{
              message = "Number ${number} is neither SQUARE or TRIANGULAR.";
            }
            popDialog(number, message);
          }
        });
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.check),
      ),
    );
  }

  bool isSquare(int value){
    return sqrt(value)%1 == 0;
  }

  bool isTriangle(int value){
    int cubeRoot = pow(value, 1 / 3).round();
    return cubeRoot * cubeRoot * cubeRoot == value;
  }

  Future popDialog(int number, String message) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(number.toString()),
        content: Text(message),
      ),
  );
}

