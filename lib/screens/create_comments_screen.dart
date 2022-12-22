import 'dart:convert';

import 'package:api/models/post_models.dart';
import 'package:api/models/users_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/comment_models.dart';
import '../widgets/text_field.dart';
import '../widgets/text_widget.dart';

class CreateCommentsScreen extends StatefulWidget {
  final int postid;
  final UsersModels userdetail;
  const CreateCommentsScreen(
      {Key? key, required this.postid, required this.userdetail, })
      : super(key: key);

  @override
  State<CreateCommentsScreen> createState() => _CreateCommentsScreenState();
}

class _CreateCommentsScreenState extends State<CreateCommentsScreen> {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController bodycontroller = TextEditingController();
  bool isloading = false;
  Future<bool> addcommentsofuser() async {
    setState(() {
      isloading = true;
    });
    Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/comments");
    Map<String, dynamic> data = {
      "userId": "${widget.postid}",
      "title": "${titlecontroller.text}",
      "body": "${bodycontroller.text}",
    };
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response =
        await http.post(uri, headers: header, body: jsonEncode(data));
    setState(() {
      isloading = false;
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Crete ${widget.userdetail.name} Comments Screen"),
        backgroundColor: Colors.cyan,
      ),
      body:Form(
        key: formkey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                TextInputField(
                  hinttext: "Comments Title",
                  label: "Comments Title...",
                  mycontroller: titlecontroller,
                  // Validator: (String? input){
                  //   if (input == null || input.isEmpty) {
                  //     return "Title is required";
                  //   } else if ((!RegExp(r'^[a-z A-Z]+$').hasMatch(input))) {
                  //     return 'Please Enter only Alphabets ';
                  //   }
                  //   return null;
                  // },
                  istitle: true,
                ),
                SizedBox(
                  height: 15,
                ),
                TextInputField(
                  hinttext: "Comments Body",
                  label: "Comments Body...",
                  mycontroller: bodycontroller,
                  isbody: true,
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        bool status = await addcommentsofuser();
                        // var snackBar = SnackBar(
                        //   content: Text(status? "Successfully data is transferred":"Failed"),
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // Navigator.of(context).pop();
                        // // Navigator.of(context).push(MaterialPageRoute(builder: (context){return ValueScreen(countervalue: count);}));
                        status
                            ? showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('AlertDialog'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text("Name : ${titlecontroller.text}"),
                                          Text('Body: ${bodycontroller.text}'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Approve'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Text("Failed");
                      }
                      ;
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
                      "Create",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        fontStyle: FontStyle.italic,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
