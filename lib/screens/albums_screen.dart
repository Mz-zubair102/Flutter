import 'dart:convert';

import 'package:api/models/album_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/todos_models.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  List<AlbumModels> Albumslist=[];
  Future<List<AlbumModels>> getalbums()async{

    Uri uri=Uri.parse("https://jsonplaceholder.typicode.com/albums");
    http.Response responsealbums=await http.get(uri);
    var decodebody =jsonDecode(responsealbums.body) as List;
    Albumslist=List<AlbumModels>.from(
        decodebody.map((json) => AlbumModels.fromJson(json))).toList();
    return Albumslist;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      title: Text("Albums Screen"),
      ),
      body: FutureBuilder<List<AlbumModels>>(
        future: getalbums(),
        builder: (BuildContext context,AsyncSnapshot<List<AlbumModels>> snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasData){
            return ListView.builder(
            itemCount: snapshot.data!.length,
                itemBuilder: (Context, int index){
              return ListTile(
                title: Text(snapshot.data![index].title),
                subtitle: Text(snapshot.data![index].userId.toString()),
              );
            });
          }
          else if(snapshot.hasError){
            return Center(child: Text("${snapshot.error}"),);
          }
          else{
            return Center(child: Text("Please wait"),);
          }
        },),
    );
  }
}
