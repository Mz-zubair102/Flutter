import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/comment_models.dart';
import 'package:http/http.dart' as http;

class CommentsListScreens extends StatefulWidget {
  const CommentsListScreens({Key? key}) : super(key: key);

  @override
  State<CommentsListScreens> createState() => _CommentsListScreensState();
}

class _CommentsListScreensState extends State<CommentsListScreens> {
  List<CommentsModels> commentslist = [];

  Future<List<CommentsModels>> getcomments() async {
    //1-convert url to uri
    Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/comments");
    //2-use Uri to call Api
    http.Response responsecomments = await http.get(uri);
    //3-Decode Response body
    var decodebody = jsonDecode(responsecomments.body) as List;
    //4- use loop for jsonlist to Model list
    commentslist = List<CommentsModels>.from(
        decodebody.map((json) => CommentsModels.fromJson(json))).toList();
    return commentslist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Comments List"),
      ),
      body: FutureBuilder<List<CommentsModels>>(
        future: getcomments(),
          builder: (BuildContext context,AsyncSnapshot<List<CommentsModels>> snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                  itemBuilder:(Context,int index){
                return ListTile(
                  title:Text(snapshot.data![index].name),
                  subtitle:Text (snapshot.data![index].body),
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
