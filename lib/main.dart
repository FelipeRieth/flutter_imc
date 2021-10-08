import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String _infoText = "Informe seus dados";

  TextEditingController weightController = TextEditingController();

  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  void _resetField(){
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados";
    });



  }


  void _calcularIMC(){
    setState(() {

      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if(imc < 18.6){
        _infoText = "Abaixo do peso, IMC: ${imc.toStringAsPrecision(4)}";
      }else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Peso ideal, IMC: ${imc.toStringAsPrecision(4)}";
      }
      else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente acima do ideal, IMC: ${imc.toStringAsPrecision(4)}";
      }
      else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade grau I, IMC: ${imc.toStringAsPrecision(4)}";
      }
      else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Obesidade grau II, IMC: ${imc.toStringAsPrecision(4)}";
      }
      else if(imc >= 40){
        _infoText = "Obesidade grau III, IMC: ${imc.toStringAsPrecision(4)}";
      }


    });


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Calculo IMC"),actions: [
        IconButton(onPressed: (){
          _resetField();
        }, icon: Icon(Icons.refresh))
      ],),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(padding: EdgeInsets.all(30),child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Icon(Icons.person, color: Colors.blue,size: 120,),

            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "Insira seu peso!";
                }
              },
              controller: weightController,
              style: TextStyle(color: Colors.blue, fontSize: 20),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Peso (kg)",
                labelStyle: TextStyle(color: Colors.blue, fontSize: 30),
              ),
            ),

            Container(width: 20,height: 20,),
            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                    return "Insira sua altura!";
                }
              },
              controller: heightController,
              style: TextStyle(color: Colors.blue, fontSize: 20),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: TextStyle(color: Colors.blue, fontSize: 30),
              ),
            ),

            Container(width: 20,height: 20,),

            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  _calcularIMC();
                }
              },
              child: Text('Calcular',style: TextStyle(
                fontSize: 30,

              ),),
            ),

            Container(width: 20,height: 20,),
            Text(_infoText,textAlign: TextAlign.center,style: TextStyle(
              fontSize: 30,
              color: Colors.blueAccent,

            ),),


          ],
        ),
      ))
    );
  }
}
