import 'dart:convert';
import 'package:api/models/users_models.dart';
import 'package:api/screens/users_profile_screens.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/text_widget.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}
class _UsersListScreenState extends State<UsersListScreen> {
  List<UsersModels> userlist = [];

  Future<List<UsersModels>> getUser() async {
    Uri uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
    http.Response response = await http.get(uri);
    var decodebody = jsonDecode(response.body) as List;
    // for (int i = 0; i < decodebody.length; i++) {
    //   userlist.add(UsersModels.fromJson(decodebody[i]));
    //   setState(() {});
    // }
    userlist=List<UsersModels>.from(decodebody.map((json) => UsersModels.fromJson(json))).toList();
    return userlist;
  }
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   var resUser = getUser();
  // }
  @override
  Widget build(BuildContext context) {
   /** return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("USERS LIST"),
        backgroundColor: Colors.cyan,
      ),
      body: userlist.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: userlist.length,
              itemBuilder: (context, index) {
                UsersModels userdetail = userlist[index];
                // return ListTile(
                //   title: Text(userlist[index].name),
                //   subtitle: Text(userlist[index].email),
                // );
                return GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersProfileScreen(detail: userdetail)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 20),
                    height: 90,
                    width: 380,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight:Radius.circular(10)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.grey.shade300,
                              Colors.lightBlueAccent.shade100,
                            ]
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,spreadRadius:0.5)
                        ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(title: "Name", detail: userdetail.name),
                                SizedBox(height: 5,),
                                TextWidget(title: "Email", detail: userdetail.email)
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_outlined,color: Colors.grey.shade600,size: 32,),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );**/
    //Future Builder
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("USERS LIST"),
          backgroundColor: Colors.cyan,
        ),
      body: FutureBuilder<List<UsersModels>>(
        future: getUser(),
          builder: (BuildContext context,AsyncSnapshot<List<UsersModels>> snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  UsersModels? userdetail = snapshot.data![index];
                  return GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersProfileScreen(userdetail: userdetail)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 20),
                      height: 90,
                      width: 380,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight:Radius.circular(10)),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey.shade300,
                                Colors.lightBlueAccent.shade100,
                              ]
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,spreadRadius:0.5)
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(title: "Name", detail: userdetail.name),
                                  SizedBox(height: 5,),
                                  TextWidget(title: "Email", detail: userdetail.email)
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios_outlined,color: Colors.grey.shade600,size: 32,),
                          ],
                        ),
                      ),
                    ),
                  );
                });
      }
          else if(snapshot.hasError){
            return Center(child: Text("${snapshot.error}"));
      }
          else{
            return Center(child: Text("Please Wait"));
      }
      }
    ));
  }
}
