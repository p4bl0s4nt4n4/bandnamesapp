import 'package:flutter/material.dart';

import '../modelos/banda.dart';

class Inicio extends StatefulWidget {
  @override
  _Inicio createState() => _Inicio();

}

class _Inicio extends State<Inicio> {
  List<Banda> bandas = [
    Banda(
        id: "1",
        nombre: "Metallica",
        votos: 0
    ),
    Banda(
        id: "2",
        nombre: "Slipknot",
        votos: 0
    ),
    Banda(
        id: "3",
        nombre: "Michael Jackson",
        votos: 0
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplicación de Bandas", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bandas.length,
        itemBuilder: (context, index) => buildListTile(bandas[index])
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: agregarNuevaBanda,
      ),
    );
  }

  Widget buildListTile(Banda banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 15.0),
        color: Colors.redAccent,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      child: ListTile(
        key: Key(banda.id),
        leading: CircleAvatar(
          child: Text(banda.nombre.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(banda.nombre),
        trailing: Text("${banda.votos}", style: TextStyle(fontSize: 20)),
        onTap: () {
          print(banda.nombre);
        },
      ),
      onDismissed: (direction) {
        this.bandas.remove(banda);
        setState((){});
      },
    );
  }

  agregarNuevaBanda() {
    final textController = new TextEditingController();

    showDialog(context: context, builder: (builder) {
      return AlertDialog(
        title: Text("Nueva banda"),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
              child: Text("Agregar"),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => agregarBandaALista(textController.text)
          )
        ],
      );
    });
  }

  void agregarBandaALista(String nombre) {
    if(nombre.length > 1) {
      this.bandas.add(new Banda(id: DateTime.now().toString(), nombre: nombre));
      setState(() {});
    }

    Navigator.pop(context);
  }
}