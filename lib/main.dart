import 'package:flutter/material.dart';
import 'package:flutter_sdmga19/screens/payment_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
          backgroundColor: Colors.blue,
        ),
        body: PaymentScreen(),
      ),
    );
  }
}

