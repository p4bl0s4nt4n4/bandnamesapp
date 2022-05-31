import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum EstadoServidor {
  EnLinea,
  FueraLinea,
  Conectando
}

class SocketServicio with ChangeNotifier {
  EstadoServidor _estadoServidor = EstadoServidor.Conectando;
  late IO.Socket _socket;

  SocketServicio() {
    this._initConfig();
  }

  EstadoServidor get estadoServidor => this._estadoServidor;
  IO.Socket get socket => this._socket;

  void _initConfig(){
    this._socket = IO.io("http://192.168.1.204:5000", IO.OptionBuilder()
        .setTransports(["websocket"])
        .enableAutoConnect()
        .build()
    );

    this._socket.onConnect((data) {
      this._estadoServidor = EstadoServidor.EnLinea;
      notifyListeners();
    });

    this._socket.onDisconnect((_) {
      this._estadoServidor = EstadoServidor.FueraLinea;
      notifyListeners();
    });
  }
}