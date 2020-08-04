

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Correio extends StatefulWidget {
  @override
  _CorreioState createState() => _CorreioState();
}

class _CorreioState extends State<Correio> {

  TextEditingController _cep = TextEditingController();
  String _resultado = "resultado";

  _recuperaCep() async{
    String textoDigitado = _cep.text;
    String url = "https://viacep.com.br/ws/${textoDigitado}/json/";
    http.Response response;

    response = await http.get(url);

    Map<String,dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String cep = retorno["cep"];
    String uf = retorno["uf"];

    setState(() {
      _resultado = "${logradouro},${bairro},${localidade},${cep},${uf}";
    });

   // print("Resposta Logradouro: $logradouro Bairro: $bairro Localidade: $localidade");


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo Serviço Web"),
        backgroundColor: Colors.cyanAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText:
                    "Digite o CEP",
                ),
              style: TextStyle(
                fontSize: 22,
              ),
              controller: _cep,
              ),
            RaisedButton(
              child: Text("Clique Aqui"),
              onPressed:_recuperaCep ,
            ),
            Text(_resultado),
          ],
        ),
      ),
    );
  }
}
