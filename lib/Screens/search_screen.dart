import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Pages/chat_page.dart';
import 'home_screen.dart';


class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult =[];
  bool isLoading = false;
  bool userFound=false;

  void onSearch()async{
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: searchController.text)
        .limit(1)
        .get();

    if (result.docs.length == 1 ) {
      final DocumentSnapshot<Map<String, dynamic>> userDoc = result.docs.first;
      final userData = userDoc.data();
      userFound=true;
      searchResult=[];
      searchResult.add(userData!);
      print(searchResult);
      // print other user data as needed
    } else {
      userFound=false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No User Found")));
      print('User not found!');
    }

      setState(() {
        isLoading = false;
      });
    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Colors.blue,
        title: Text("Search your Friend"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "type username....",
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                        ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                    ),
                  ),
                ),
              ),
              IconButton(onPressed: (){
                onSearch();
              }, icon: Icon(Icons.search)),
              const SizedBox(width: 10),
            ],

          ),
          if(searchResult.length > 0)
            Expanded(child: ListView.builder(
                itemCount: searchResult.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl:'${FirebaseAuth.instance.currentUser?.photoURL}',
                      placeholder: (conteext,url)=>CircularProgressIndicator(),
                      errorWidget: (context,url,error)=>Icon(Icons.error,),
                      height: 40,
                    ),
                    title: Text(searchResult[index]['username']),
                    subtitle: Text(searchResult[index]['email']),
                    trailing: IconButton(onPressed: (){
                      setState(() {
                        searchController.text = "";
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
                          currentUserId: '${FirebaseAuth.instance.currentUser?.uid}'??'',
                          friendId: searchResult[index]['uid']??'',
                          friendName: searchResult[index]['username']??'',
                          friendImage: searchResult[index]['photurl']??'')));
                    }, icon: Icon(Icons.message)),
                  );
                }))
          else if(isLoading == true)
            Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)))
        ],
      ),

    );
  }
}