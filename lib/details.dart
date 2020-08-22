import 'students.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'convertidor.dart';
import 'package:image_picker/image_picker.dart';

class DetailPage extends StatelessWidget{

  final Student student;
  DetailPage(this.student);

  TextEditingController _fotoController = TextEditingController();
  String imagen;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("USER DATA"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Container(
        width: 700,
        height: 800,
        color: Colors.grey[850],
        child: SingleChildScrollView(
          child: Card(
            color: Colors.grey[850],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                ),
                //FOTOGRAFIA
                CircleAvatar(
                  radius: 85,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    minRadius: 80.0,
                    maxRadius:  80.0,
                    backgroundColor: Colors.white,
                    backgroundImage: Convertir.imageFromBase64sString(student.foto).image,
                  ),
                ),
                new Padding(padding: EdgeInsets.all(15.0),),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person),
                    Text("Datos de Usuario",
                      style: TextStyle(
                          fontSize: 15
                      ),
                    ),
                  ],
                ),
                new Divider(
                    color: Colors.blueGrey[600],
                    indent: 20,
                    endIndent: 20,
                    thickness: 3.0),
                new Padding(padding: EdgeInsets.all(15.0),),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(student.firstName.toString().toUpperCase()+" "+student.lastName1.toString().toUpperCase()+" "+student.lastName2.toString().toUpperCase(),
                      style: TextStyle(
                          fontSize: 20
                      ),),
                  ],
                ),
                //MATRICULA
                new Padding(padding: EdgeInsets.all(10.0),),
                Chip(
                  backgroundColor: Colors.blueGrey[600],
                  padding: const EdgeInsets.symmetric(vertical: 3,horizontal:60),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.filter_list),
                  ),
                  label: Text('Matricula: ${student.matricula}'),
                ),
                new Padding(padding: EdgeInsets.all(10.0),),
                Chip(
                  backgroundColor: Colors.blueGrey[600],
                  padding: const EdgeInsets.symmetric(vertical: 3,horizontal:60),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.email),
                  ),
                  label: Text('E-mail: ${student.email}'),
                ),
                new Padding(padding: EdgeInsets.all(10.0),),
                Chip(
                  backgroundColor: Colors.blueGrey[600],
                  padding: const EdgeInsets.symmetric(vertical: 3,horizontal:60),
                  avatar: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.phone),
                  ),
                  label: Text('Telefono: ${student.phone}'),
                ),
                SizedBox(
                  height: 170.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}