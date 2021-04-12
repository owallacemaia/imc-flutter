import 'dart:math';
import 'package:flutter/material.dart';

class CalculoWidget extends StatefulWidget {
  @override
  _CalculoWidgetState createState() => _CalculoWidgetState();
}

class _CalculoWidgetState extends State<CalculoWidget> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _operacao;
  int _sexo;
  int _radioValue1;
  int _radioValue2;
  String _infoText = "Informe seus dados!";

  @override
  void initState() { 
    super.initState();
    _operacao = 0;
    _sexo = 0;
  }

  void _sexoSel(int valor){
    setState(() {
      _radioValue1 = valor;
      switch(_radioValue1){
        case 0:
          _sexo = 0; //Masculino
          break;
        case 1:
          _sexo = 1; //Femenino
          break;
      }
    });
  }

  void _operacaoSel(int valor){
    setState(() {
      _radioValue2 = valor;
      switch(_radioValue2){
        case 0:
          _operacao = 0; //IMC
          break;
        case 1:
          _operacao = 1; //IAC
          break;
      }
    });
  }

  void _calculateIMC() {
    switch(_sexo){
      case 0:{
            setState(() {
          double weight = double.parse(weightController.text);
          double height = double.parse(heightController.text) / 100;
          double imc = weight / (height * height);
          if (imc < 18.6) {
            _infoText = "Abaixo do peso ${imc.toStringAsPrecision(3)}";
          } else if (imc >= 18.6 && imc < 24.9) {
            _infoText = "Peso ideal ${imc.toStringAsPrecision(3)}";
          } else if (imc >= 24.9 && imc < 29.9) {
            _infoText = "Levemente acima do peso ${imc.toStringAsPrecision(3)}";
          } else if (imc >= 29.9 && imc < 34.9) {
            _infoText = "Obesidade Grau I ${imc.toStringAsPrecision(3)}";
          } else if (imc >= 34.9 && imc < 39.9) {
            _infoText = "Obesidade Grau II ${imc.toStringAsPrecision(3)}";
          } else if (imc >= 40.0) {
            _infoText = "Obesidade Grau III ${imc.toStringAsPrecision(3)}";
          }
        });

        break;
      }

      case 1:{
            setState(() {
          double weight = double.parse(weightController.text);
          double height = double.parse(heightController.text) / 100;
          double imc = weight / (height * height);
          if (imc < 18.6) {
            _infoText = "Abaixo do peso ${imc.toStringAsPrecision(3)}";
          } else if (imc >= 18.6 && imc < 24.9) {
            _infoText = "Peso ideal ${imc.toStringAsPrecision(3)}";
          } else if (imc >= 24.9 && imc < 29.9) {
            _infoText = "Levemente acima do peso ${imc.toStringAsPrecision(3)}";
          } else if (imc >= 29.9 && imc < 34.9) {
            _infoText = "Obesidade Grau I ${imc.toStringAsPrecision(3)}";
          } else if (imc >= 34.9 && imc < 39.9) {
            _infoText = "Obesidade Grau II ${imc.toStringAsPrecision(3)}";
          } else if (imc >= 40.0) {
            _infoText = "Obesidade Grau III ${imc.toStringAsPrecision(3)}";
          }
        });

        break;
      }
    }
  }

    void _calculateIAC() {
    switch(_sexo){
      case 0:{
          setState(() {
          double haunch = double.parse(weightController.text);
          double height = double.parse(heightController.text) / 100;
          double iac = (haunch / height * sqrt(height)) - 18;
          if (iac < 20.0) {
            _infoText = "Normal ${iac.toStringAsPrecision(3)}";
          } else if (iac >= 25.0) {
            _infoText = "Sobrepeso ${iac.toStringAsPrecision(3)}";
          } else{
            _infoText = "Obesidade";
          }
        });
        break;
      }

      case 1:{
          setState(() {
          double haunch = double.parse(weightController.text);
          double height = double.parse(heightController.text) / 100;
          double iac = (haunch / height * sqrt(height)) - 18;
          if (iac < 32) {
            _infoText = "Normal ${iac.toStringAsPrecision(3)}";
          } else if (iac >= 38) {
            _infoText = "Sobrepeso ${iac.toStringAsPrecision(3)}";
          } else{
            _infoText = "Obesidade";
          }
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (KG)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty)
                    return "Insira Seu Peso!";
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: _operacao == 0 ? "Altura (cm)" : "Quadril",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty)
                    return _operacao == 0 ? "Insira sua altura" : "Insira o tamanho do seu quadril";
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                         _operacao == 0 ? _calculateIMC() : _calculateIAC();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _radioValue1,
                    onChanged: _sexoSel,
                    activeColor: Colors.green,
                  ),
                  Text("Homem"),
                  Radio(
                    value: 1,
                    groupValue: _radioValue1,
                    onChanged: _sexoSel,
                    activeColor: Colors.green,
                  ),
                  Text("Mulher"),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _radioValue2,
                    onChanged: _operacaoSel,
                    activeColor: Colors.green,
                  ),
                  Text("IMC"),
                  Radio(
                    value: 1,
                    groupValue: _radioValue2,
                    onChanged: _operacaoSel,
                    activeColor: Colors.green,
                  ),
                  Text("IAC"),
                ],
              ),
            ],
          ),
        ),
      );
  }
}