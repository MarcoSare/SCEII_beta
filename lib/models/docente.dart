class docente {
  late  String id_usuario;
  late String id_docente;
  late String nombre;
  late String apellidos;
  late String correo;
  late String password;
  late String genero;
  late String fecha_nac;

  docente(this.id_usuario, this.id_docente,this.nombre, this.apellidos);

  docente.add(this.nombre,this.apellidos,this.correo,this.password,this.genero,this.fecha_nac);

}