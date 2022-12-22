import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final String title;
  final String detail;
  const TextWidget({Key? key, required this.title, required this.detail}) : super(key: key);

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
          Expanded(child: Text("${widget.title}  : ",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),)),
            Expanded(
              child: Text("${widget.detail}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18,color:Colors.black ),),
            )
        ],);
  }
}
