import 'package:flutter/material.dart';
import 'package:flutter_crud/models/cliente.dart';
import 'package:flutter_crud/api/api_cep.dart';
import 'package:flutter_crud/api/api_cliente.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController txtId = TextEditingController();
  TextEditingController txtNome = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtCep = TextEditingController();
  TextEditingController txtEstado = TextEditingController();
  TextEditingController txtCidade = TextEditingController();
  TextEditingController txtBairro = TextEditingController();
  TextEditingController txtRua = TextEditingController();
  TextEditingController txtNumero = TextEditingController();
  String? resultado;

  // monta o obetto do cliente com os dados dos campos em tela para enviar para api salvar em banco de dados
  salvar() async {
    var cliente = Cliente(
        null,
        txtNome.text,
        txtEmail.text,
        txtCep.text,
        txtEstado.text,
        txtCidade.text,
        txtBairro.text,
        txtRua.text,
        txtNumero.text);
    //faz a chamada em api, salva os dados e redireciona para a tela de lista
    ApiCliente api = ApiCliente();
    await api.adicionar(cliente);
    Navigator.pushNamed(context, "/list");
  }

  //faz a chamada na api de preencher dados de endereço passando o cep como parametro
  preencherCep() async {
    ApiCep api = ApiCep();
    var endereco = await api.consultaCep(txtCep.text);
    setState(() {
      txtRua.text = endereco.street;
      txtBairro.text = endereco.district;
      txtCidade.text = endereco.city;
      txtEstado.text = endereco.state;
    });
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            ElevatedButton(
                onPressed: preencherCep,
                child: Text(
                  "Buscar CEP",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.purple)),
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
              onPressed: salvar,
              child: Text("Salvar"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  minimumSize: const Size.fromHeight(50)),
            ),
          ],
        ),
      ),
    );
  }
}
