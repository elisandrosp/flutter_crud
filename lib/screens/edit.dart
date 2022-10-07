import 'package:flutter/material.dart';
import 'package:flutter_crud/models/cliente.dart';
import 'package:flutter_crud/api/api_cliente.dart';

class Edit extends StatefulWidget {
  int clienteId;
  Edit({Key? key, required this.clienteId}) : super(key: key);
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtCep = TextEditingController();
  TextEditingController txtEstado = TextEditingController();
  TextEditingController txtCidade = TextEditingController();
  TextEditingController txtBairro = TextEditingController();
  TextEditingController txtRua = TextEditingController();
  TextEditingController txtNumero = TextEditingController();
  String? resultado;

  //função para atualizar os dados do cliente
  atualizarCliente() async {
    var cliente = Cliente(
        widget.clienteId,
        txtNome.text,
        txtEmail.text,
        txtCep.text,
        txtEstado.text,
        txtCidade.text,
        txtBairro.text,
        txtRua.text,
        txtNumero.text);

    //instancia da api , salva os dados e redireciona para a lista
    ApiCliente api = ApiCliente();
    await api.atualizar(cliente);
    Navigator.pushNamed(context, "/list");
  }

  //função para carregar os dados do cliente
  carregarCliente(int id) async {
    //instancia da api, e faz a chamada para buscar os dados do cliente passando como parametro o Id do cliente
    ApiCliente api = ApiCliente();
    var cliente = await api.get(id);
    //seta os valores retornados da api para a tela em seus respectivos campos
    setState(() {
      txtNome.text = cliente.name;
      txtEmail.text = cliente.email;
      txtCep.text = cliente.zipCode;
      txtEstado.text = cliente.state;
      txtCidade.text = cliente.city;
      txtBairro.text = cliente.district;
      txtRua.text = cliente.street;
      txtNumero.text = cliente.streetNumber;
    });
  }

  @override
  void initState() {
    //ao abrir a tela, é chamado a funcão para carregar os dados
    carregarCliente(widget.clienteId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Cadastro de cliente"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              controller: txtNome,
              decoration: const InputDecoration(
                  labelText: "Nome completo", enabled: true),
            ),
            TextField(
              keyboardType: TextInputType.text,
              controller: txtEmail,
              decoration:
                  const InputDecoration(labelText: "E-mail", enabled: true),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: txtCep,
              decoration:
                  const InputDecoration(labelText: "CEP", enabled: true),
            ),
            TextField(
              controller: txtRua,
              decoration:
                  const InputDecoration(labelText: "Rua", enabled: true),
            ),
            TextField(
              controller: txtBairro,
              decoration:
                  const InputDecoration(labelText: "Bairro", enabled: true),
            ),
            TextField(
              controller: txtCidade,
              decoration:
                  const InputDecoration(labelText: "Cidade", enabled: true),
            ),
            TextField(
              controller: txtEstado,
              decoration:
                  const InputDecoration(labelText: "Estado", enabled: true),
            ),
            TextField(
              controller: txtNumero,
              decoration:
                  const InputDecoration(labelText: "Número", enabled: true),
            ),
            ElevatedButton(
                onPressed: atualizarCliente,
                child: Text("Salvar"),
                style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    minimumSize: const Size.fromHeight(50))),
          ],
        ),
      ),
    );
  }
}
