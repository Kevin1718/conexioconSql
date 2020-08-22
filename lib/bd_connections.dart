import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'Students.dart';

class BDConnections {

  static const SERVER = "http://192.168.3.20/Students/sqloperations.php";
  static const _CREATE_TABLE_COMMAND = "CREATE_TABLE";
  static const _SELECT_TABLE_COMMAND = "SELECT_TABLE";
  static const _INSERT_DATA_COMMAND = "INSERT_DATA";
  static const _UPDATE_DATA_COMMAND = "UPDATE_DATA";
  static const _DELETE_DATA_COMMAND = "DELETE_DATA";

  //TABLE CREATION
  static Future<String> createTable() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_COMMAND;
      final response = await http.post(SERVER, body: map);
      print('Table response: ${response.body}');

      if (200 == response.statusCode) {
        print(response.body.toString());
        return response.body;
      } else {
        return "Error";
      }
    } catch (e) {
      print("Error creating table or table already exist");
      print(e.toString());
      return "Error";
    }
  }

  //Get Data from
  static Future<List<Student>> selectData() async {
    try {
      //Mapeamos para comparar
      var map = Map<String, dynamic>();
      map['action'] = _SELECT_TABLE_COMMAND;
      //Body es lo que estamos mapeando
      final response = await http.post(SERVER, body: map);
      print('SELECT response: ${response.body}');
      if (200 == response.statusCode) {
        //Mapear la lista
        List<Student> list = parseResponse(response.body);
        return list;
      } else {
        return List<Student>();
      }
    } catch (e) {
      print("Error getting datafrom SQL Server");
      print(e.toString());
      return List<Student>();
    }
  }

  //ParseResponse Method
  static List<Student> parseResponse(String responseBody) {
    final parseData = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parseData.map<Student>((json) => Student.fromJson(json)).toList();
  }

  //INSERT DATA ON DB
  static Future<String> insertData(String first_name, String last_name1, String last_name2, String email, String phone, String matricula, imagen) async {
    try {

      var map = Map<String, dynamic>();
      map['action'] = _INSERT_DATA_COMMAND;
      map['first_name'] = first_name;
      map['last_name1'] = last_name1;
      map['last_name2'] = last_name2;
      map['email'] = email;
      map['phone'] = phone;
      map['matricula'] = matricula;
      map['foto'] = imagen;


      final response = await http.post(SERVER, body: map);
      print('INSERT response: ${response.body}');
      print(imagen);

      if (200 == response.statusCode) {
        print("Sucess");
        return response.body;
      } else {
        return "Error";
      }
    } catch (e) {
      print("Error getting datafrom SQL Server");
      print(e.toString());
      return "Error";
    }
  }

  //UPDATE DATA ON DB
  static Future<String> updateData(String id_alumno, String first_name, String last_name1, String last_name2, String email, String phone, String matricula, foto) async {
    try {
      //Mapeamos para comparar
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_DATA_COMMAND;
      map['id_alumno'] = id_alumno;
      map['first_name'] = first_name;
      map['last_name1'] = last_name1;
      map['last_name2'] = last_name2;
      map['email'] = email;
      map['phone'] = phone;
      map['matricula'] = matricula;
      map['foto'] = foto;

      //Body es lo que estamos mapeando
      final response = await http.post(SERVER, body: map);
      print('UPDATE response: ${response.body}');

      if (200 == response.statusCode) {
        print("Sucess");
        return response.body;
      } else {
        return "Error";
      }
    } catch (e) {
      print("Error getting datafrom SQL Server");
      print(e.toString());
      return "Error";
    }
  }

  //DELETE DATA ON DB
  static Future<String> deleteData(String id_alumno) async {
    try {
      //Mapeamos para comparar
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_DATA_COMMAND;
      map['id_alumno'] = id_alumno;

      //Body es lo que estamos mapeando
      final response = await http.post(SERVER, body: map);
      print('DELETE response: ${response.body}');

      if (200 == response.statusCode) {
        print("Sucess");
        return response.body;
      } else {
        return "Error";
      }
    } catch (e) {
      print("Error getting datafrom SQL Server");
      print(e.toString());
      return "Error";
    }
  }

}