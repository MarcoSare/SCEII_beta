class visitante {
  late  String id_usuario;
  late String id_visitante;
  late String nombre;
  late String apellidos;
  late String correo;
  late String institucion;
  late String password;
  late String genero;
  late String fecha_nac;

  visitante(this.id_usuario, this.id_visitante,this.nombre, this.apellidos);

  visitante.add(this.nombre,this.apellidos,this.correo,this.institucion,this.password,this.genero,this.fecha_nac);


}