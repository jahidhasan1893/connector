import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Widgets/message_text_field.dart';
import '../Widgets/single_message.dart';

class ChatPage extends StatelessWidget {
  final String currentUserId;
  final String friendId;
  final String friendName;
  final String friendImage;

  ChatPage({
    required this.currentUserId,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child:  CachedNetworkImage(
                imageUrl:friendImage,
                placeholder: (conteext,url)=>CircularProgressIndicator(),
                errorWidget: (context,url,error)=>Icon(Icons.error,),
                height: 40,
              ),
            ),
            SizedBox(width: 5,),
            Text(friendName,style: TextStyle(fontSize: 20),)
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)
                )
            ),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users").doc(currentUserId).collection('messages').doc(friendId).collection('chats').orderBy("date",descending: true).snapshots(),
                builder: (context,AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data.docs.length < 1){
                      return Center(
                        child: Text("Say Hi"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index){
                          bool isMe = snapshot.data.docs[index]['senderId'] == currentUserId;
                          return SingleMessage(message: snapshot.data.docs[index]['message'], isMe: isMe);
                        });
                  }
                  return Center(
                      child: CircularProgressIndicator()
                  );
                }),
          )),
          MessageTextField(currentUserId, friendId),
        ],
      ),

    );
  }
}