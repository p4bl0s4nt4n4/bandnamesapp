import 'package:bandnamesapp/servicios/socket_servicio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bandnamesapp/paginas/inicio.dart';
import 'package:bandnamesapp/paginas/estado.dart';

void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => SocketServicio())
      ],
      child: MaterialApp(
        title: 'MiAplicacion',
        initialRoute: "inicio",
        routes: {
          "inicio": ( _ ) => Inicio(),
          "estado": ( _ ) => Estado()
        },
      ),
    );
  }
}