import 'dart:convert';
import 'package:api/models/comment_models.dart';
import 'package:api/models/post_models.dart';
import 'package:api/models/users_models.dart';
import 'package:api/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'create_comments_screen.dart';

class UsersCommentsScreen extends StatefulWidget {
  final PostsModels userpostdetail;
  final UsersModels userdetail;
  const UsersCommentsScreen(
      {Key? key, required this.userpostdetail, required this.userdetail})
      : super(key: key);

  @override
  State<UsersCommentsScreen> createState() => _UsersCommentsScreenState();
}

class _UsersCommentsScreenState extends State<UsersCommentsScreen> {
  List<CommentsModels> usercommentlist = [];
  Future<List<CommentsModels>> getcommentsofuser() async {
    //1-convert URL to Uri
    Uri uri = Uri.parse(
        "https://jsonplaceholder.typicode.com/comments?userid=${widget.userpostdetail.id}");
    //2-Use Uri to call Api
    http.Response response = await http.get(uri);
    //3-Decode Response body
    var decodebody = jsonDecode(response.body) as List;
    usercommentlist = List<CommentsModels>.from(
        decodebody.map((json) => CommentsModels.fromJson(json))).toList();
    return usercommentlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("User ${widget.userdetail.name} Comments Info"),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(title: "Name", detail:widget.userdetail.name ),
                      SizedBox(height: 5,),
                      TextWidget(title: "Email", detail:widget.userdetail.email ),
                      SizedBox(height: 5,),
                      Text(
                        "Title :",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${widget.userpostdetail.title}"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Email :",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("${widget.userpostdetail.body}"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateCommentsScreen(
                              postid: widget.userpostdetail.id,
                              userdetail: widget.userdetail,
                            )));
                  },
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      elevation: 15,
                      backgroundColor: Colors.cyan,
                      shadowColor: Colors.red,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                      )),
                  child: Text(
                    "Create Comments",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              FutureBuilder<List<CommentsModels>>(
                future: getcommentsofuser(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CommentsModels>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (Context, int index) {
                          CommentsModels? usercommentsdetail =
                              snapshot.data![index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name :",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlue),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(usercommentsdetail.name),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Body Detail :",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlue),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(usercommentsdetail.body),
                                ],
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else {
                    return Center(
                      child: const Text("Please wait"),
                    );
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
