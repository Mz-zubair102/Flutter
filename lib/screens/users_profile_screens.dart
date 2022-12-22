import 'dart:convert';

import 'package:api/models/post_models.dart';
import 'package:api/screens/user_comment_screen.dart';
import 'package:api/widgets/users_profile_screens_builder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/users_models.dart';
import 'create_post_screen.dart';

class UsersProfileScreen extends StatefulWidget {
  final UsersModels userdetail;
  const UsersProfileScreen({Key? key, required this.userdetail}) : super(key: key);

  @override
  State<UsersProfileScreen> createState() => _UsersProfileScreenState();
}
class _UsersProfileScreenState extends State<UsersProfileScreen> {
  List<PostsModels> userpostlist=[];
  Future<List<PostsModels>> getpostofuser()async{
    //1-convert URL to Uri
    Uri uri=Uri.parse("https://jsonplaceholder.typicode.com/posts?userId=${widget.userdetail.id}");
    //2-Use Uri to call Api
    http.Response response=await http.get(uri);
    //3-Decode Response body
    var decodebody=jsonDecode(response.body) as List;
    userpostlist =List<PostsModels>.from(decodebody.map((json) => PostsModels.fromJson(json))).toList();
    return userpostlist;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("User : ${widget.userdetail.name}"),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Divider(color: Colors.cyan,height: 5,thickness: 2),
                        ),
                      ),
                      Text("Users Info",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Divider(color: Colors.cyan,height: 5,thickness: 2),
                        ),
                      ),
                    ],
                  ),
                  UsersProfileScreensBuilder(title: "Name", detail: widget.userdetail.name),
                  UsersProfileScreensBuilder(title: "Email", detail: widget.userdetail.email),
                  UsersProfileScreensBuilder(title: "Phone", detail: widget.userdetail.phone),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Divider(color: Colors.cyan,height: 5,thickness: 2),
                        ),
                      ),
                      Text("Adress Info",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Divider(color: Colors.cyan,height: 5,thickness: 2),
                        ),
                      ),
                    ],
                  ),
                  UsersProfileScreensBuilder(title: "Street", detail: widget.userdetail.address.street),
                  UsersProfileScreensBuilder(title: "Zipcode", detail: widget.userdetail.address.zipcode),
                  UsersProfileScreensBuilder(title: "Suite", detail: widget.userdetail.address.suite),
                  UsersProfileScreensBuilder(title: "Geo.lat", detail: widget.userdetail.address.geo.lat),
                  UsersProfileScreensBuilder(title: "Geo.lang", detail: widget.userdetail.address.geo.lng),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Divider(color: Colors.cyan,height: 5,thickness: 2,),
                        ),
                      ),
                      Text("Company Info",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Divider(color: Colors.cyan,height: 5,thickness: 2,),
                        ),
                      ),
                    ],
                  ),
                  UsersProfileScreensBuilder(title: "Company Name", detail: widget.userdetail.company.name),
                  UsersProfileScreensBuilder(title: "Bs", detail: widget.userdetail.company.bs),
                  UsersProfileScreensBuilder(title: "Catch Phrase", detail: widget.userdetail.company.catchPhrase),
                ],
              ),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreatePostScreen(userid: widget.userdetail.id,userdetail: widget.userdetail,)));
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context){return ValueScreen(countervalue: count);}));
                  },
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      elevation: 10,
                      backgroundColor: Colors.lightBlue,
                      shadowColor: Colors.red,
                      shape:BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomLeft: Radius.circular(10)),
                      )
                  ),
                  child:Text("Crete Post",style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                  ),)),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Divider(color: Colors.cyan,height: 5,thickness: 2),
                    ),
                  ),
                  Text("Users Post Info",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 35,),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Divider(color: Colors.cyan,height: 5,thickness: 2,),
                    ),
                  ),
                ],
              ),
              FutureBuilder<List<PostsModels>>(
                future: getpostofuser(),
                builder: (BuildContext context,AsyncSnapshot<List<PostsModels>> snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index){
                          PostsModels? userpostdetail=snapshot.data![index];
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersCommentsScreen(userpostdetail: userpostdetail,userdetail: widget.userdetail,)));
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Title :",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.lightBlue),),
                                    SizedBox(height: 5,),
                                    Text(userpostdetail.title),
                                    SizedBox(height: 5,),
                                    Text("Body Detail :",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.lightBlue),),
                                    SizedBox(height: 5,),
                                    Text(userpostdetail.body),
                                  ],
                                ),
                              ),
                            ),
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

            ],
          ),
        ),
      ),
    );
  }
}
