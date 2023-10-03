import 'package:flutter/material.dart';
import 'package:viacepapp/model/cep_model.dart';
import 'package:viacepapp/repository/cep_repository.dart';

class CepScreen extends StatefulWidget {
  CepScreen(this.cepRepository, {super.key});

  CepRepository cepRepository;

  @override
  State<CepScreen> createState() => _CepScreenState();
}

class _CepScreenState extends State<CepScreen> {
  ListaCepModel _cepsBack4App = ListaCepModel([]);
  bool carregando = false;

  void loadCeps() async {
    setState(() {
      carregando = true;
    });
    _cepsBack4App = await widget.cepRepository.obterCeps();
    setState(() {
      carregando = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadCeps();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("CEPs Consultados")),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: carregando
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _cepsBack4App.listaCeps.length,
                  itemBuilder: (BuildContext bc, int index) {
                    var cep = _cepsBack4App.listaCeps[index];
                    return Dismissible(
                        key: Key(cep.objectId),
                        onDismissed: (DismissDirection dismissDirection) async {
                          await widget.cepRepository.removeCep(cep.objectId);
                        },
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Column(
                            children: [
                              Text(
                                "Consulta nº ${index + 1}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Text("CEP: ${cep.cep}"),
                              Text("Cidade: ${cep.localidade}"),
                              Text("Estado: ${cep.uf}"),
                              Text(cep.logradouro),
                              Text("Bairro: ${cep.bairro}"),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ));
                  }),
        ),
      ),
    );
  }
}
