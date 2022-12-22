import 'package:api/screens/comments_list_screen.dart';
import 'package:api/screens/photos_screen.dart';
import 'package:api/screens/post_list_screen.dart';
import 'package:api/screens/todos_screen.dart';
import 'package:api/screens/users_list_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/button_pressed.dart';
import 'albums_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Main Screen"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonPressed(
                  iconss: Icon(Icons.account_circle_outlined,color:Colors.lightBlueAccent),
                  buttonname: "Users Screen",
                  onpressesd: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersListScreen()));
                  },
                ),
                ButtonPressed(
                  iconss: Icon(Icons.account_circle_outlined,color:Colors.lightBlueAccent
                  ),
                  buttonname:"Post List Screen",
                  onpressesd:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>PostListScreen()));} ,),
                ButtonPressed(
                    iconss: Icon(Icons.comment,color:Colors.lightBlueAccent),
                    buttonname:"Comments List Screen",
                onpressesd:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentsListScreens()));}
                ),
                ButtonPressed(
                  iconss: Icon(Icons.album,color:Colors.lightBlueAccent),
                  buttonname: "Albums Screen",
                onpressesd: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AlbumsScreen()));},
                ),
                ButtonPressed(
                  iconss: Icon(Icons.today_outlined,color:Colors.lightBlueAccent),
                  buttonname: "Todos Screen",
                  onpressesd: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>TododsScreen()));},
                ),
                ButtonPressed(
                  iconss: Icon(Icons.photo,color:Colors.lightBlueAccent),
                  buttonname: "Photos Screen",
                  onpressesd: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>PhotosScreen()));},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

