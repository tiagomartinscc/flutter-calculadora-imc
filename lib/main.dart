import 'package:flutter/material.dart';

void main () {
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _infoText = "Informe seus dados";
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetField() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculate () {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      print(imc);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc <= 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc <= 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc <= 34.9) {
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc <= 40 ) {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetField)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.amber),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.amber)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.amber, fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu peso";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.amber)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.amber, fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua altura";
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        calculate();
                      }
                    },
                    child: Text("Calcular", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    color: Colors.amber,
                  ),
                ),
              ),
              Text(_infoText, textAlign: TextAlign.center, style: TextStyle(color: Colors.amber, fontSize: 25.0),)
            ],
          ),
        ),
      ),
    );
  }
}
