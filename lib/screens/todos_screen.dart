import 'dart:convert';

import 'package:api/models/todos_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TododsScreen extends StatefulWidget {
  const TododsScreen({Key? key}) : super(key: key);

  @override
  State<TododsScreen> createState() => _TododsScreenState();
}

class _TododsScreenState extends State<TododsScreen> {
  List<TodosModels> todoslist=[];
  Future<List<TodosModels>> gettodos()async{
    Uri uri=Uri.parse("https://jsonplaceholder.typicode.com/todos");
    http.Response responsetodos=await http.get(uri);
    var decodebody =jsonDecode(responsetodos.body) as List;
    todoslist=List<TodosModels>.from(
        decodebody.map((json) => TodosModels.fromJson(json))).toList();
    return todoslist;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Todos List"),
        ),
        body: FutureBuilder<List<TodosModels>>(
          future: gettodos(),
          builder: (BuildContext context,AsyncSnapshot<List<TodosModels>> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            else if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder:(Context,int index){
                    TodosModels todosdetail=snapshot.data![index];
                    return ListTile(
                      title:Text(todosdetail.title),
                      subtitle:Text (todosdetail.userId.toString()),
                    );
                  });
            }
            else if(snapshot.hasError){
              return Center(child: Text("${snapshot.error}"),);
            }
            else{
              return Center(child: Text("Please wait"),);
            };
          },
        )
    );
  }
}
