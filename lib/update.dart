import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Students.dart';
import 'package:flutter/material.dart';
import 'bd_connections.dart';
import 'convertidor.dart';
import 'package:image_picker/image_picker.dart';

class Update extends StatefulWidget {
  Update() : super();
  final String title = "MySQL BD Connection";

  @override
  homepageState createState() => homepageState();
}

class homepageState extends State<Update> {
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

  //******************************************************************
  //Métodos de manejar de la BD

  //Desplegar la snackbar
  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  _createTable() {
    //_showProgress('Creating Table...');
    BDConnections.createTable().then((result) {
      if ('sucess' == result) {
        _showSnackBar(context, result);
        //_showProgress(widget.title);
      }
    });
  }


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

  //UPDATE DATA
  _updateData(Student student){
    setState(() {
      _isUpdating = true;
    });

    BDConnections.updateData(student.id, _firstnameConroller.text, _lastname1Conroller.text, _lastname2Conroller.text, _emailConroller.text, _phoneConroller.text, _matriculaConroller.text, imagen).then((result){
      if('success' == result){
        _selectData; //REFRESH LIST AFTER UPDATE
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  //DELETE DATA
  _deleteData(Student student){
    //_showSnackBar('Deleting Student...');
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

  //METODO PARA FOTO
  pickImagefromGallery(){
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile){
      String  imgString = Convertir.base64String(imgFile.readAsBytesSync());
      imagen = imgString;
      //Navigator.of(context).pop();
      _fotoConroller.text = "Campo lleno";
      return imagen;
    });
  }



  SingleChildScrollView _body() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(label: Text('ID')),
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


                DataCell(Text(student.id),
                    onTap: (){
                      _showValues(student);
                      // Set the selected student to update
                      _selectStudent = student;
                      // Set flag updating tu true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    }),

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

                DataCell(Convertir.imageFromBase64sString(student.foto),
                    onTap: (){
                      _showValues(student);
                      // Set the selected student to update
                      _selectStudent = student;
                      // Set flag updating tu true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    }),
              ]),
          ).toList(),
        ),
      ),
    );
  }

  //******************************************************************
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        title: Text("UPDATE DATA"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              BDConnections.createTable();
            },),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              BDConnections.selectData();
            },)
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: _fotoConroller,
                      decoration: InputDecoration(
                          labelText: "Photo",
                          suffixIcon: RaisedButton(
                            color: Colors.blueGrey[600],
                            onPressed: pickImagefromGallery,
                            child: Text("Select image", textAlign: TextAlign.center,),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(controller: _firstnameConroller,
                      decoration: InputDecoration.collapsed(hintText: "First Name"),),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(controller: _lastname1Conroller,
                        decoration: InputDecoration.collapsed(hintText: "Last Name 1"),)
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(controller: _lastname2Conroller,
                        decoration: InputDecoration.collapsed(hintText: "Last Name 2"),)
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(controller: _emailConroller,
                        decoration: InputDecoration.collapsed(hintText: "E-mail"),)
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(controller: _phoneConroller,
                        decoration: InputDecoration.collapsed(hintText: "Phone"),)
                  ),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: TextField(controller: _matriculaConroller,
                        decoration: InputDecoration.collapsed(hintText: "Matricula"),)
                  ),
                  //ADD AN UPDATE BUTTON AND A CANCEL BUTTON
                  //SHOW ONLY WHEN UPDATING DATA
                  _isUpdating ?
                  new Row(
                    children: <Widget>[
                      OutlineButton(
                        child: Text('UPDATE'),
                        onPressed: (){
                          _updateData(_selectStudent);
                          _clearValues();
                          _showSnackBar(context, 'Datos actualizados correctamente');
                        },
                      ),
                      OutlineButton(
                        child: Text('CANCEL'),
                        onPressed: (){
                          setState(() {
                            _isUpdating = false;
                          });
                          _clearValues();
                        },
                      ),
                    ],
                  ):Container(),
                ],
              ),
            ),
            Expanded(
              child: _body(),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: (){
          _insertData();
        },
        child: Icon(Icons.add),
      ),*/
    );
  }
}