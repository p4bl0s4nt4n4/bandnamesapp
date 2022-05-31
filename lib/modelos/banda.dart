class Banda {
  String id;
  String nombre;
  int votos;

  Banda({required this.id, required this.nombre, this.votos = 0});

  factory Banda.fromJson(Map json) => Banda(
    id: json["id"],
    nombre: json["nombre"],
    votos: json["votos"]
  );
}