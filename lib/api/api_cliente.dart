import 'package:flutter_crud/models/clienteLista.dart';
import 'package:flutter_crud/models/cliente.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiCliente {
  //url da api de cadastro de cliente
  String baseUrl = "https://apicliente_homologacao.papauster.com.br";
  // lista de todos clientes cadastrados
  Future<List<ClienteLista>> listar() async {
    var url = "$baseUrl/client/list";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return clienteListaFromJson(response.body.toString());
    } else {
      Future<List<ClienteLista>> empty;
      empty = Future.value([]);
      return empty;
    }
  }

  //adiciona um cliente
  Future<bool> adicionar(Cliente data) async {
    var url = "$baseUrl/client/create";
    final response = await http.post(
      Uri.parse(url),
      headers: {"content-type": "application/json"},
      body: clientToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //atualiza os dados do cliente
  Future<bool> atualizar(Cliente data) async {
    var url = "$baseUrl/client/update";
    final response = await http.put(
      Uri.parse(url),
      headers: {"content-type": "application/json"},
      body: clientToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // delete cliente passando o Id do cliente como parametro
  Future<bool> delete(int id) async {
    //monta a url do enpoint de delete
    var url = "$baseUrl/Client/delete/$id";
    final response = await http.delete(
      Uri.parse(url),
      headers: {"content-type": "application/json"},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /// busca a informação do cliente pelo Id
  Future<Cliente> get(int id) async {
    var url = "$baseUrl/client/$id";
    final response = await http.get(Uri.parse(url));

    Map<String, dynamic> retorno = json.decode(response.body);
    //monta e posteriormente retorna o objeto cliente
    Cliente cliente = Cliente(
        retorno["id"],
        retorno["name"],
        retorno["email"],
        retorno["zipCode"],
        retorno["state"],
        retorno["city"],
        retorno["district"],
        retorno["street"],
        retorno["streetNumber"]);
    return cliente;
  }
}
