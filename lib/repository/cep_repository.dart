import 'package:viacepapp/model/cep_model.dart';
import 'package:viacepapp/repository/back4app_custon_dio.dart';

class CepRepository {
  var _custonDio = Back4AppCustonDio();

  CepRepository();

  Future<ListaCepModel> obterCeps() async {
    var url = "/Ceps";
    var result = await _custonDio.dio.get(url);
    return ListaCepModel.fromJson(result.data);
  }

  Future<void> addCep(CepModel cepModel) async {
    try {
      var response =
          await _custonDio.dio.post("/Ceps", data: cepModel.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeCep(String objectId) async {
    try {
      var response = await _custonDio.dio.delete("/Ceps/$objectId");
    } catch (e) {
      throw e;
    }
  }
}
