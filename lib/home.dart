import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Students.dart';
import 'package:flutter/material.dart';
import 'bd_connections.dart';
import 'insert.dart';
import 'update.dart';
import 'delete.dart';
import 'convertidor.dart';
import 'select.dart';

class homepage extends StatefulWidget {
  homepage() : super();
  final String title = "MySQL conexión";

  @override
  homepageState createState() => homepageState();
}

class homepageState extends State<homepage> {
  List<Student> _Students;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _firstnameConroller;
  TextEditingController _lastname1Conroller;
  TextEditingController _lastname2Conroller;
  TextEditingController _emailConroller;
  TextEditingController _phoneConroller;
  TextEditingController _matriculaConroller;
  TextEditingController _fotoConroller;

  Student _selectStudent;
  bool _isUpdating;
  String imagen;
  //String _titleProgress;

  @override
  void initState() {
    super.initState();
    _Students = [];
    _isUpdating = false;
    Student _selectedStudent;
    //_titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _firstnameConroller = TextEditingController();
    _lastname1Conroller = TextEditingController();
    _lastname2Conroller = TextEditingController();
    _emailConroller = TextEditingController();
    _phoneConroller = TextEditingController();
    _matriculaConroller = TextEditingController();
    _fotoConroller = TextEditingController();
    //Llamar al método que llena la DataTable
    _selectData;
  }


  //Métodos de manejar de la BD

  //Desplegar la snackbar
  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }


  //CREATE TABLE
  _createTable() {
    //_showProgress('Creating Table...');
    BDConnections.createTable().then((result) {
      if ('sucess' == result) {
        _showSnackBar(context, result);
        //_showProgress(widget.title);
      }
    });
  }

  //INSERT DATA
  _insertData() {
    if (_firstnameConroller.text.isEmpty || _lastname1Conroller.text.isEmpty || _lastname2Conroller.text.isEmpty || _emailConroller.text.isEmpty || _phoneConroller.text.isEmpty || _matriculaConroller.text.isEmpty) {
      print("Empy fields");
      return;
    }
    //_showProgress('Adding Student...');
    BDConnections.insertData(_firstnameConroller.text, _lastname1Conroller.text, _lastname2Conroller.text, _emailConroller.text, _phoneConroller.text, _matriculaConroller.text, _fotoConroller.text)
        .then((result) {
      if ('sucess' == result) {
        _showSnackBar(context, result);
        _firstnameConroller.text = "";
        _lastname1Conroller.text = "";
        _lastname2Conroller.text = "";
        _emailConroller.text = "";
        _phoneConroller.text = "";
        _matriculaConroller.text = "";
        _fotoConroller.text = "";

        //Llamar la consulta general
        _selectData;  //REFRESH LIST AFTER ADDING
        _clearValues();
      }
    });
  }

  //SELECT DATA
  get _selectData {
    //_showSnackBar('Loading Student...');
    BDConnections.selectData().then((students) {
      setState(() {
        _Students = students;
      });
      //Verificar si tenemos algo de retorno
      _showSnackBar(context, "Data Acquired");
      print("size of Students ${students.length}");
    });
  }



  //DELETE DATA
  _deleteData(Student student){
    BDConnections.deleteData(student.id).then((result){
      if('success' == result){
        _selectData; //REFRESH LIST AFTER DELETE
      }
    });
  }

  //CLEAR TEXTFIELD VALUES
  _clearValues(){
    _firstnameConroller.text = "";
    _lastname1Conroller.text = "";
    _lastname2Conroller.text = "";
    _emailConroller.text = "";
    _phoneConroller.text = "";
    _matriculaConroller.text = "";
    _fotoConroller.text = "";
  }

  _showValues(Student student){
    _firstnameConroller.text = student.firstName;
    _lastname1Conroller.text = student.lastName1;
    _lastname2Conroller.text = student.lastName2;
    _emailConroller.text = student.email;
    _phoneConroller.text = student.phone;
    _matriculaConroller.text = student.matricula;
    imagen = student.foto;
  }

  //table
  SingleChildScrollView _body() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          //DataColumn(label: Text('ID')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Last Name 1')),
          DataColumn(label: Text('Last Name 2')),
          DataColumn(label: Text('E-mail')),
          DataColumn(label: Text('Phone')),
          DataColumn(label: Text('Matricula')),
          DataColumn(label: Text('Fotografía')),
          //SHOW A DELETE BUTTON
          //DataColumn(label: Text('DELETE'))
        ],
        rows: _Students.map((student) => DataRow(
            cells: [
              //COMO ESTA EN EL ARCHIVO STUDENT.DART
              //ADD TAP IN ROW AND POPULATE THE TEXTFIELDS WITH THE CORRESPONDING VALUES TO UPDATE

              DataCell(Text(student.firstName.toUpperCase()),
                  onTap: (){
                    _showValues(student);
                    // Set the selected student to update
                    _selectStudent = student;
                    // Set flag updating tu true to indicate in Update Mode
                    setState(() {
                      _isUpdating = true;
                    });
                  }),

              DataCell(Text(student.lastName1.toUpperCase()),
                  onTap: (){
                    _showValues(student);
                    // Set the selected student to update
                    _selectStudent = student;
                    // Set flag updating tu true to indicate in Update Mode
                    setState(() {
                      _isUpdating = true;
                    });
                  }),

              DataCell(Text(student.lastName2.toUpperCase()),
                  onTap: (){
                    _showValues(student);
                    // Set the selected student to update
                    _selectStudent = student;
                    // Set flag updating tu true to indicate in Update Mode
                    setState(() {
                      _isUpdating = true;
                    });
                  }),

              DataCell(Text(student.email.toUpperCase()),
                  onTap: (){
                    _showValues(student);
                    // Set the selected student to update
                    _selectStudent = student;
                    // Set flag updating tu true to indicate in Update Mode
                    setState(() {
                      _isUpdating = true;
                    });
                  }),

              DataCell(Text(student.phone.toUpperCase()),
                  onTap: (){
                    _showValues(student);
                    // Set the selected student to update
                    _selectStudent = student;
                    // Set flag updating tu true to indicate in Update Mode
                    setState(() {
                      _isUpdating = true;
                    });
                  }),

              DataCell(Text(student.matricula.toUpperCase()),
                  onTap: (){
                    _showValues(student);
                    // Set the selected student to update
                    _selectStudent = student;
                    // Set flag updating tu true to indicate in Update Mode
                    setState(() {
                      _isUpdating = true;
                    });
                  }),

              DataCell(Convertir.imageFromBase64sString(student.foto)),

            ]),
        ).toList(),
      ),
    );
  }

  //******************************************************************
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      //MENU LATERAL
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/imagen.jpg"),
                      fit: BoxFit.cover
                  )
              ),
              padding: EdgeInsets.all(60),
              child: Text("   Actions  ",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_to_home_screen, color: Colors.greenAccent),
              title: Text("Pagina principal",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context)
                        => new homepage()
                    ));
              },),
            ListTile(
              leading: Icon(Icons.exposure_plus_1, color: Colors.greenAccent),
              title: Text("Insert ",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context)
                        => new Insert()
                    ));
              },),
            ListTile(
              leading: Icon(Icons.system_update_alt, color: Colors.greenAccent),
              title: Text("Update",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20
                ),),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context)
                        => new Update()
                    ));
              },),
            ListTile(
              leading: Icon(Icons.delete_sweep, color: Colors.greenAccent),
              title: Text("Delete",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 20
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(
                        builder: (context)
                        => new Delete()
                    ));
              },),
            ListTile(
                leading: Icon(Icons.search, color: Colors.greenAccent),
                title: Text("Select",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(
                          builder: (context)
                          => new Select()
                      ));
                }
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[700],
        title: Text("Mysql"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.plus_one),
            onPressed: (){
              BDConnections.createTable();
            },),
          IconButton(
            icon: Icon(Icons.check_circle_outline),
            onPressed: (){
              BDConnections.selectData();
            },)
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: _body(),
            ),
          ],
        ),
      ),
    );
  }
}