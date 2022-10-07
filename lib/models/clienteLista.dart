import 'dart:convert';

class ClienteLista {
  final int id;
  final String name;
  final String email;

  ClienteLista(this.id, this.name, this.email);

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email};
  }

  ClienteLista.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'email': email};
}

List<ClienteLista> clienteListaFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<ClienteLista>.from(
      data.map((item) => ClienteLista.fromJson(item)));
}

String clienteListaToJson(ClienteLista data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
