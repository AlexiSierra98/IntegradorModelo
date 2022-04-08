class UserModel {
  String? email;
  String? Nombre;
  String? ApellidoPaterno;
  String? ApellidoMaterno;


  UserModel({this.email, this.Nombre, this.ApellidoPaterno, this.ApellidoMaterno});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      email: map['email'],
      Nombre: map['Nombre'],
      ApellidoPaterno: map['apellidoPaterno'],
      ApellidoMaterno: map['apellidoMaterno'],

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'Nombre': Nombre,
      'ApellidoPaterno': ApellidoPaterno,
      'ApellidoMaterno': ApellidoMaterno,

    };
  }
}