import 'package:flutter/material.dart';
import 'package:bandnamesapp/paginas/inicio.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiAplicacion',
      initialRoute: "inicio",
      routes: {
        "inicio": ( _ ) => Inicio()
      },
    );
  }
}