import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_crud/models/endereco.dart';

class ApiCep {
  // busca o endereço passando o cep de parâmetro
  Future<Endereco> consultaCep(String ziCode) async {
    String url = "https://viacep.com.br/ws/$ziCode/json";
    http.Response response;
    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);
    //monta o objeto endereço com os dados retornados da api
    Endereco endereco = Endereco(ziCode, retorno["uf"], retorno["localidade"],
        retorno["bairro"], retorno["logradouro"]);
    return endereco;
  }
}
