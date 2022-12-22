import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/post_models.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  List<PostsModels> postlist=[];
  Future<List<PostsModels>> getPosts()async{
   //1-convert URL to Uri
    Uri uri=Uri.parse("https://jsonplaceholder.typicode.com/posts");
    //2-Use Uri to call Api
    http.Response response=await http.get(uri);
    //3-Decode Response body
    var decodebody=jsonDecode(response.body) as List;
    // 4-Loop for json List to Model list
    // for(int i=0;i<decodebody.length;i++){
    //   PostsModels obj=PostsModels.fromJson(decodebody[i]);
    //   postlist.add(obj);
    //   // postlist.add(PostsModels.fromJson(decodebody[i]));
    // }
     postlist =List<PostsModels>.from(decodebody.map((json) => PostsModels.fromJson(json))).toList();
  //5-setstate
  // setState(() {});
    return postlist;
  }
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   var resgetpost=getPosts();
  // }
  @override
  Widget build(BuildContext context) {
    // PostModel obj=PostModel.fromJson(jsonResponse);
    return Scaffold(
     /** body:postlist.isEmpty?Center(child: CircularProgressIndicator()): ListView.builder(
          itemCount: postlist.length,
          itemBuilder: (context,int index){
            return ListTile(
              title: Text(postlist[index].title),
              subtitle:Text(postlist[index].body) ,
            );
         }),**/
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Post Lists Screen"),
        ),
        body:FutureBuilder<List<PostsModels>>(
          future: getPosts(),
          builder: (BuildContext context,AsyncSnapshot<List<PostsModels>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                    PostsModels? detail=snapshot.data![index];
                    return ListTile(
                      title: Text(detail.title),
                      subtitle: Text(detail.body),
                    );
                  });
            }else if(snapshot.hasError){
              return Center(child: Text("${snapshot.error}"));
            }
            else {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        )
    );
  }
}