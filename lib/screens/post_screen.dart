import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/post_models.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<PostsModels> postlist=[];
  Future<PostsModels> createpost()async{
    //1-convert URL to Uri
    Uri uri=Uri.parse("https://jsonplaceholder.typicode.com/posts");
    Map<String, dynamic> data={
      "userId":123,
      "title":"Flutter",
      "body":"EXD",
    };
    //2-Use Uri to call Api
    http.Response response=await http.post(uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        //3-Encode Response data
      body: jsonEncode(data)
    );
    var decodebody=jsonDecode(response.body);
    PostsModels post=PostsModels.fromJson(decodebody);
    // postlist.add(post);
    // print(response.body);
    // print(response.statusCode);
    return post;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      centerTitle: true,
      title: Text("Create Post"),
    ),
      body: FutureBuilder<PostsModels>(
        future: createpost(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child:CircularProgressIndicator());
          }
          else if(snapshot.hasData){
            return Center(
              child: Container(
                height: 100,
                width: 250,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data!.id.toString()),
                    Text(snapshot.data!.userId.toString()),
                    Text(snapshot.data!.body.toString()),
                  ],
                ),
              ),
            );
          }
          else if(snapshot.hasError){
            return Center(child: Text("${snapshot.error}"),);
          }
          else{
            return Center(child: Text("Please wait"),);
          }
        },
      ),
    );
  }
}