import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  static const String id = "ResultScreen";

  ResultScreen({this.result});

  final String result;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              (widget.result=='Bacterial')?widget.result+"\nChemical sprays with copper-based bactericide and the antibiotic oxytetracycline can be used in this case":widget.result,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

