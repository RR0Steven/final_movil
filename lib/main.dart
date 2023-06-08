//import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'package:intl/intl.dart';

import 'ExchangeRate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController copController = TextEditingController();
  final TextEditingController usdController = TextEditingController();
  final ExchangeRate exchangeRates = ExchangeRate();
  String convertedCOPtoUSD = '';
  String convertedUSDtoCOP = '';

  void convertCOPtoUSD() {
    final copAmount = double.tryParse(copController.text);
    if (copAmount != null) {
      exchangeRates.convertCOPtoUSD(copAmount).then((result) {
        setState(() {
          convertedCOPtoUSD = result;
        });
      });
    }
  }

  void convertUSDtoCOP() {
    final usdAmount = double.tryParse(usdController.text);
    if (usdAmount != null) {
      exchangeRates.convertUSDtoCOP(usdAmount).then((result) {
        setState(() {
          convertedUSDtoCOP = result;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Conversor de Moneda'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'COP a USD',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: copController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Cantidad en COP'),
              ),
              ElevatedButton(
                onPressed: convertCOPtoUSD,
                child: Text('Convertir'),
              ),
              SizedBox(height: 16.0),
              Text(
                'USD a COP',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: usdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Cantidad en USD'),
              ),
              ElevatedButton(
                onPressed: convertUSDtoCOP,
                child: Text('Convertir'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Resultado:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text('COP a USD: \$ $convertedCOPtoUSD'),
              Text('USD a COP: \$ $convertedUSDtoCOP'),
            ],
          ),
        ),
      ),
    );
  }
}