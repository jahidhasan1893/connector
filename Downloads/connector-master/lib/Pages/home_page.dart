import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connector/Pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc('${FirebaseAuth.instance.currentUser?.uid}').collection('messages').snapshots(),
          builder: (context,AsyncSnapshot snapshot){
            print("Hello world");
            if(snapshot.hasData){
              if(snapshot.data.docs.length < 1){
                return Center(
                  child: Text("No Chats Available !"),
                );
              }
              print("Hello world");
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context,index){
                    print("Hello Worlds");
                    var friendId = snapshot.data.docs[index].id;
                    var lastMsg = snapshot.data.docs[index]['last_msg'];
                    return FutureBuilder(
                      future: FirebaseFirestore.instance.collection('users').doc(friendId).get(),
                      builder: (context,AsyncSnapshot asyncSnapshot){
                        print("Hello Worlds");
                        if(asyncSnapshot.hasData){
                          print("He;;p world");
                          var friend = asyncSnapshot.data.data();
                          print("Help world");
                          return Card(
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: CachedNetworkImage(
                                  imageUrl:friend['photourl']??'',
                                  placeholder: (conteext,url)=>CircularProgressIndicator(),
                                  errorWidget: (context,url,error)=>Icon(Icons.error,),
                                  height: 50,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              selectedTileColor: Colors.black87,
                              title: Text(friend['username'],style: TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Container(
                                child: Text("$lastMsg",style: TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis,),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
                                    currentUserId: '${FirebaseAuth.instance.currentUser?.uid}'??'',
                                    friendId: friend['uid']??'',
                                    friendName: friend['username']??'',
                                    friendImage: friend['photourl']??'')));
                              },
                            ),
                          );
                        }
                        return LinearProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black));
                      },

                    );
                  });
            }
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),);
          }),



    );
  }
}