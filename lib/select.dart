import 'convertidor.dart';
import 'students.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'details.dart';

class Select extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}


class _myHomePageState extends State<Select> {
  //get fechStudent => null;
  String searchString = "";
  bool _isSearching = false;
  TextEditingController searchController = TextEditingController();




  Future<List<Student>> fetchStudent() async {
    String url = "http://192.168.3.20/Students/GetStudent.php";
    try {
      final response = await http.get(url);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: _isSearching ? TextField(
          decoration: InputDecoration(
              hintText: "Buscando..."),
          onChanged: (value) {
            setState(() {
              searchString = value;
            });
          },
          controller: searchController,
        )
            :Text("SELECT USER",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        actions: <Widget>[
          !_isSearching ? IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                searchString = "";
                this._isSearching = !this._isSearching;
              });
            },
          )
              :IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                this._isSearching = !this._isSearching;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: FutureBuilder(
            future: fetchStudent(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // print(fetchStudent());
              if (snapshot.hasData) {
                return  ListView.builder(
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Student student = snapshot.data[index];
                    return snapshot.data[index].matricula.contains(searchController.text)
                        ? ListTile(
                      leading: CircleAvatar(
                        minRadius: 30.0,
                        maxRadius: 30.0,
                        backgroundColor: Colors.white,
                        backgroundImage: Convertir.imageFromBase64sString(   '${student.foto}',).image,
                      ),
                      title: new Text(
                        '${student.firstName}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: new Text(
                        '${student.matricula}',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context)=> DetailPage(snapshot.data[index])));
                      },
                    )
                        :Container();
                  },
                );
              }
              return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ));
            },
          ),
        ),
      ),
    );
  }
}