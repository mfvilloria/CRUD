class Nota {
  int? id;
  String Nombre;
  String Apellido;

  Nota({this.id, required this.Nombre, required this.Apellido});

  Nota.empty(this.id, this.Nombre, this.Apellido);

  Map<String, dynamic> toMap(){
    return {'id' : id, 'Nombre' : Nombre, 'Apellido' : Apellido};
  }
}