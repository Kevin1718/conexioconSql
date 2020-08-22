import 'dart:convert';
class Student {

  List<Student> studentFromJson(String str) => List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

  String studentToJson(List<Student> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  String id;
  String firstName;
  String lastName1;
  String lastName2;
  String email;
  String phone;
  String matricula;
  String foto;

  Student({this.id, this.firstName, this.lastName1, this.lastName2, this.email, this.phone, this.matricula, this.foto});

  //Patrones de diseño
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName1: json['last_name1'] as String,
      lastName2: json['last_name2'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      matricula: json['matricula'] as String,
      foto: json['foto'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name1": lastName1,
    "last_name2": lastName2,
    "email": email,
    "phone": phone,
    "matricula": matricula,
    "foto": foto,
  };

}