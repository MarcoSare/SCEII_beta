class alumno {
  late  String id_usuario;
  late String id_alumno;
  late String nombre;
  late String apellidos;
  late String correo;
  late String noControl;
  late String password;
  late String genero;
  late String semestre;
  late String carrera;
  late String fecha_nac;

  alumno(this.id_usuario, this.id_alumno,this.nombre, this.apellidos);

  alumno.add(this.nombre,this.apellidos,this.correo,this.noControl,this.password,this.genero,this.semestre,this.carrera,this.fecha_nac);

}
