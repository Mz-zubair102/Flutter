import 'dart:convert';
import 'dart:ffi';
import 'package:api/models/users_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/text_field.dart';


class CreatePostScreen extends StatefulWidget {
  final int userid;
  final UsersModels userdetail;
  const CreatePostScreen({Key? key, required this.userid,required this.userdetail}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  GlobalKey<FormState> _formkey=GlobalKey();
  TextEditingController titlecontroller=TextEditingController();
  TextEditingController bodycontroller=TextEditingController();
  bool isloading=false;
  Future<bool> addpostofuser()async{
    setState(() {isloading=true;});
    Uri uri=Uri.parse("https://jsonplaceholder.typicode.com/posts");
    Map<String, dynamic> data={
      "userId":"${widget.userid}",
      "title":"${titlecontroller.text}",
      "body":"${bodycontroller.text}",
    };
    Map<String, String> header={
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final response=await http.post(uri,headers: header,body: jsonEncode(data));
    setState(() {isloading=false;});
    if(response.statusCode==200||response.statusCode==201){
      return true;
    }else{
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        title: Text("Crete ${widget.userdetail.name} Post Screen"),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextInputField(
                  hinttext: "Title",
                  label: "Title...",
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
                SizedBox(height: 15,),
                TextInputField(
                  hinttext: "Body",
                  label: "Body...",
                  mycontroller: bodycontroller,
                  // Validator: (String? input){
                  //   if (input == null || input.isEmpty) {
                  //     return "Body is required";
                  //   } else if ((!RegExp(r'^[a-z A-Z]+$').hasMatch(input))) {
                  //     return 'Please Enter only Alphabets ';
                  //   }else{
                  //     return input;
                  //   }
                  // },
                  isbody: true,

                ),
            SizedBox(height: 15,),
                TextButton(
                    onPressed: ()async {
                      if (_formkey.currentState!.validate()) {
                        bool status = await addpostofuser();
                        var snackBar = SnackBar(
                          content: Text(status? "Successfully data is transferred":"Failed"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pop();
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context){return ValueScreen(countervalue: count);}));
                      };
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        elevation: 15,
                        backgroundColor: Colors.cyan,
                        shadowColor: Colors.red,
                        shape:BeveledRectangleBorder(
                          borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomLeft: Radius.circular(10)),
                        )
                    ),
                    child:Text("Create",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                    ),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



