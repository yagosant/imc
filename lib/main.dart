import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    //passando a tela principal
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//classe que vai ter interação, criação da tela
class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  //funcao de refresh
  void _resetFields() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.5) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Normal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 25.0 && imc < 29.9) {
        _infoText = "Sobre Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 30.0 && imc < 39.9) {
        _infoText = "Obesidade (${imc.toStringAsPrecision(3)})";
      } else {
        _infoText = "Obesidade grave (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //criando a Appbar
      appBar: AppBar(
        title: Text("Calculo de IMC"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
        ],
      ),

      //colocando cor de fundo
      backgroundColor: Colors.white,

      //alterando o corpo
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.orange,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso em Kg",
                          labelStyle: TextStyle(color: Colors.orange)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.orange, fontSize: 15.0),
                      controller: pesoController,
                    validator: (value){
                        if(value.isEmpty){
                      return "Prencha o campo";
                    }
                    },
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura em Centimentros",
                          labelStyle: TextStyle(color: Colors.orange)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.orange, fontSize: 15.0),
                      controller: alturaController,
                    validator: (value){
                        if(value.isEmpty){
                      return "Prencha o campo";
                    }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            _calculate();
                          }
                        },
                        child: Text("Calcular",
                            style: TextStyle(
                                color: Colors.white, fontSize: 15.0)),
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.orange, fontSize: 15.0),
                  )
                ],
              ),
          ),
          )
      );

  }
}
