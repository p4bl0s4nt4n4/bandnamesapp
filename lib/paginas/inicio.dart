import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'package:bandnamesapp/modelos/banda.dart';
import 'package:bandnamesapp/servicios/socket_servicio.dart';

class Inicio extends StatefulWidget {
  @override
  _Inicio createState() => _Inicio();

}

class _Inicio extends State<Inicio> {

  List<Banda> bandas = [];

  @override
  Widget build(BuildContext context) {
    final socketServicio = Provider.of<SocketServicio>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Aplicación de Bandas", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketServicio.estadoServidor == EstadoServidor.EnLinea
                ? Icon(Icons.check_circle, color: Colors.blue[300])
                : Icon(Icons.offline_bolt, color: Colors.red)
            ),
          )
        ],
      ),
      body: Column(
        children: [
          _mostrarGraficas(),
          Expanded(
            child: ListView.builder(
                itemCount: bandas.length,
                itemBuilder: (context, index) => buildListTile(bandas[index])
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: agregarNuevaBanda,
      ),
    );
  }

  Widget buildListTile(Banda banda) {
    final socketServicio = Provider.of<SocketServicio>(context, listen: false);
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
          socketServicio.socket.emit("votar-banda", {"id": banda.id});
        },
      ),
      onDismissed: (direction) {
        final socketServicio = Provider.of<SocketServicio>(context, listen: false);
        socketServicio.socket.emit("eliminar-banda", {"id": banda.id});
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
      final socketServicio = Provider.of<SocketServicio>(context, listen: false);
      socketServicio.socket.emit("crear-banda", {"nombre": nombre});
    }

    Navigator.pop(context);
  }

  @override
  void initState() {
    final socketServicio = Provider.of<SocketServicio>(context, listen: false);
    socketServicio.socket.on("bandas-activas", (data) {
      final datos = json.decode(data);
      this.bandas = (datos as List).map((b) => Banda.fromJson(b)).toList();
      setState((){});
    });
    super.initState();
  }

  @override
  void dispose() {
    final socketServicio = Provider.of<SocketServicio>(context, listen: false);
    socketServicio.socket.off("bandas-activas");
    super.dispose();
  }

  Widget _mostrarGraficas() {
    Map<String, double> mapa = Map.fromIterable(this.bandas, key: (e) => e.nombre, value: (e) => e.votos.toDouble());

    if(mapa.isNotEmpty){
      return Container(
        width: double.infinity,
        height: 200,
        margin: EdgeInsets.only(top: 10.0),
        child: PieChart(
          dataMap: mapa,
          chartType: ChartType.disc,
          chartValuesOptions: ChartValuesOptions(
              showChartValuesInPercentage: true
          ),
        ),
      );
    }

    return Container(
      child: Text("Cargando..."),
    );
  }
}