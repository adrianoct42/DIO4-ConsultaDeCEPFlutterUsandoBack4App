import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:viacepapp/model/cep_model.dart';
import 'package:viacepapp/repository/cep_repository.dart';
import 'package:viacepapp/screens/cep_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  var dio = Dio();
  TextEditingController cepController = TextEditingController();
  CepRepository cepRepository = CepRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Consulta de CEPs com Back4App"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Digite o CEP",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 16),
              TextField(
                maxLength: 8,
                keyboardType: TextInputType.number,
                controller: cepController,
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                  onPressed: () async {
                    // Usando o ViaCEP:
                    var response = await dio.get(
                        "https://viacep.com.br/ws/${cepController.text}/json/");
                    if (cepController.text.length == 8 &&
                        response.statusCode == 200) {
                      var json = response.data;
                      // print(json);

                      // Mandando pro Back4App:
                      await cepRepository.addCep(
                        CepModel.criar(
                          cepController.text,
                          json['logradouro'],
                          json['bairro'],
                          json['localidade'],
                          json['uf'],
                        ),
                      );

                      cepController.text = "";

                      const snackBar = SnackBar(
                        content: Text("CEP salvo no histórico!"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text("Adicionar CEP")),
              const SizedBox(height: 32),
              const Text(
                "Caso queira visualizar todos os CEPs já pesquisados, clique no botão abaixo:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (bc) => CepScreen(cepRepository)));
                    });
                  },
                  child: const Text("Histórico de CEPs")),
            ],
          ),
        ),
      ),
    );
  }
}
