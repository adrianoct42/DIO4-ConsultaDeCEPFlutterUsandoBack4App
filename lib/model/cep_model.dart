class ListaCepModel {
  List<CepModel> listaCeps = [];

  ListaCepModel(this.listaCeps);

  ListaCepModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      listaCeps = <CepModel>[];
      json['results'].forEach((v) {
        listaCeps.add(CepModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = listaCeps.map((v) => v.toJson()).toList();
    return data;
  }
}

class CepModel {
  String objectId = "";
  String createdAt = "";
  String updatedAt = "";
  String cep = "";
  String logradouro = "";
  String bairro = "";
  String localidade = "";
  String uf = "";

  // Construtor:
  CepModel.criar(
      this.cep, this.logradouro, this.bairro, this.localidade, this.uf);

  CepModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    return data;
  }
}
