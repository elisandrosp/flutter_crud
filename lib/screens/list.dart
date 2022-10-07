import 'package:flutter/material.dart';
import 'package:flutter_crud/api/api_cliente.dart';
import 'package:flutter_crud/models/clienteLista.dart';
import 'package:flutter_crud/screens/edit.dart';

// Vamos precisar de uma aplicação com estado
class ClienteListView extends StatefulWidget {
  @override
  _ClienteListViewState createState() => _ClienteListViewState();
}

class _ClienteListViewState extends State<ClienteListView> {
  List<ClienteLista> clientes = List<ClienteLista>.empty(); // Lista de clientes

  // Construtor, atualiza com setState a lista declientes.
  _ClienteListViewState() {
    listarClientes();
  }
  listarClientes() async {
    ApiCliente api = ApiCliente();
    List<ClienteLista> clientesApi = await api.listar();

    setState(() {
      clientes = clientesApi;
    });
  }

  novoCliente() {
    Navigator.pushNamed(context, "/add");
  }

  excluirCliente(index) async {
    ClienteLista cliente = clientes[index];
    if (cliente.id != null) {
      ApiCliente api = ApiCliente();
      var result = await api.delete(cliente.id);
      print("--------------,///////////---------" + result.toString());
      setState(() {
        clientes.removeAt(index);
      });
    }
  }

  // Método build sobrecarregado que vai construir nossa página
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
              onPressed: novoCliente,
              icon: const Icon(Icons.add),
              color: Colors.white)
        ],
      ),
      // Aqui vem nossa lista
      body: ListView.builder(
        itemCount: clientes.length, // quantidade de elementos
        // Os elementos da lista
        itemBuilder: (context, index) {
          // Vai ser um item de lista tipo ListTile
          return ListTile(
            // No título é o nome do cliente
            title: Text(
              clientes[index].name,
              style: TextStyle(fontSize: 20.0, color: Colors.purple),
            ),
            // No subtítulo colocamos o email
            subtitle: Text(clientes[index].email),
            // Ação de clicar
            onTap: () {
              // Abrimos uma nova página, outra classe, que está no arquivo
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => Edit(clienteId: clientes[index].id),
                ),
              );
            },
            onLongPress: () {
              excluirCliente(index);
            },
          );
        },
      ),
    );
  }
}
