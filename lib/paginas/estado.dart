import 'package:bandnamesapp/servicios/socket_servicio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Estado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketServicio = Provider.of<SocketServicio>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Estado Servidor ${socketServicio.estadoServidor}"),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          socketServicio.socket.emit("mensaje", [
            {
              "nombre": "Pablo",
              "mensaje": "Hola soy Pablo"
            }
          ]);
        },
      ),
    );
  }
}