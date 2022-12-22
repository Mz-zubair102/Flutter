import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/photos_models.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({Key? key}) : super(key: key);

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  List<PhotosModels> photoslist=[];
  Future<List<PhotosModels>> getphotos()async{
    Uri uri=Uri.parse("https://jsonplaceholder.typicode.com/photos");
    http.Response responsephotos=await http.get(uri);
    var decodebody=jsonDecode(responsephotos.body) as List;
    photoslist=List<PhotosModels>.from(decodebody.map((json) => PhotosModels.fromJson(json))).toList();
    return photoslist;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Comments List"),
      ),
      body: FutureBuilder<List<PhotosModels>>(
        future: getphotos(),
        builder: (context,AsyncSnapshot<List<PhotosModels>> snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder: (context, int index){
                PhotosModels photosdetail=snapshot.data![index];
              return ListTile(
                title: Text(photosdetail.title),
                subtitle: Text(photosdetail.id.toString()),
              );
            });
          }
          else if(snapshot.hasError){
            return Center(child: Text("${snapshot.data!}"),);
          }
          else{
            return Center(child: Text("Please wait"),);
          }
        })
    );
  }
}
