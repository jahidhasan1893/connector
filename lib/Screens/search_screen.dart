import 'package:flutter/material.dart';

import '../Widgets/my_search_textfield.dart';
import 'home_screen.dart';
import 'my_text_field.dart';

class SearchScreen extends StatefulWidget{
  //UserModel user;
  //SearchScreen(this.user);
  @override
  SearchScreenState createState() =>SearchScreenState();
}

class SearchScreenState extends State<SearchScreen>{

  @override
  Widget build(BuildContext context) {
    TextEditingController SearchController= new TextEditingController();
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          leading: BackButton(
            onPressed: (){
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>HomeScreen(),
                ),
              );
            },
          ),
          title:Text("Search your friend"),
          backgroundColor: Colors.blue,

        ),
        body:Column(
            children:[
              Row(
                children:[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MySearchTextField(
                        controller: SearchController,
                        hintText: "Type username......",
                        obscureText: false,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      color: Colors.grey.shade800,
                      iconSize: 30,
                      onPressed: (){},
                      icon:Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(width:10),

                ],
              )
            ]
        )
    );
  }
}

