import 'package:flutter/material.dart';

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  String _binary = "0";
  String _decimal = "0"; // _decimal = int.parse(_binary, radix: 2).toRadixString(10);
  bool binary2Decimal = true;

  void _changeBinary2Decimal() {
    setState(() {
      binary2Decimal = !binary2Decimal;
    });
  }

  void _onPressed(int k) {
    setState(() {
      switch (k) {
        case 0:
          _binary = _binary + "0";
          _decimal = int.parse(_binary, radix: 2).toRadixString(10);
          break;
        case 1:
          _binary = _binary + "1";
          _decimal = int.parse(_binary, radix: 2).toRadixString(10);
          break;
        case 2:
          _binary = "";
          _decimal = "0";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: MaterialButton(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  binary2Decimal?"Binary -> Decimal": "Decimal -> Binary", 
                  style: TextStyle(color: Colors.blueAccent)
                ),
                onPressed: () {
                  _changeBinary2Decimal();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerRight,
              child: Text(
                '$_binary',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  fontSize: 35
                ),
              )
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(8.0),
              child: Text('$_decimal',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                  fontSize: 35
                )
              )
            ),
            Expanded(flex: 3, child:binary2Decimal? _binary2DecimalConverter() : _decimal2BinaryConverter(),),
            _resetButton()
          ]),
    );
  }

  Widget _numberButton(int number) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          color: Colors.blueAccent,
          onPressed: () {
            _onPressed(number);
          },
          child: Text(number.toString(),
            style: new TextStyle(
              fontSize: 26.0,
              color: Colors.white,
            )
          )
        ),
      ),
    );
  }

  Widget _resetButton() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          color: Colors.blueAccent,
          onPressed: () {
            _onPressed(2);
          },
          child: Text("Reset", style: new TextStyle( fontSize: 20.0, color: Colors.white))
        ),
      ),
    );
  }

  Widget _binary2DecimalConverter() {
    return SizedBox(
      height: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _numberButton(1),
          Spacer(),
          _numberButton(0),
        ]
      ),
    );
  }

 Widget _decimal2BinaryConverter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        for (var i = 1; i <= 3; i++) 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              for (var j = 1; j <= 3; j++) 
                _decimalButton(i*j)
            ],
          ),
          _decimalButton(0)
      ]
    );
 }

 MaterialButton _decimalButton(int i) {
    return MaterialButton(
      color: Colors.blueAccent,
      padding: EdgeInsets.all(32.0),
      child: Text( '$i', style: TextStyle(color: Colors.white,fontSize: 32.0)),
      onPressed: () {
        setState(() {
          _decimal += '$i';
          _binary = _binary = int.parse(_decimal, radix: 10).toRadixString(2);
        });
      },
    );
  }
}