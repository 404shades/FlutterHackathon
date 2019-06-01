import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FollowCommunity extends StatefulWidget {
  @override
  _FollowCommunityState createState() => _FollowCommunityState();
}

class _FollowCommunityState extends State<FollowCommunity> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("Communities").snapshots(),

      builder: (context, snapshot) {
        if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Text("Loading......");
              default:
                return Padding(
          padding: EdgeInsets.all(10.0),
          child: GridView.builder(
            itemCount: snapshot.data.documents.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
            ),
            itemBuilder: (context,index){
              return GestureDetector(
                child: getSingleView(index, snapshot.data),
              );
            },
          ),
          
        );
            }
      }
    );
  }
  Widget getSingleView(int index,QuerySnapshot snapshot){
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),

        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Container(
        height: 120.0,
        child : Image.network(
          snapshot.documents[index]['ImageURL'],
          alignment: Alignment.center,
          fit: BoxFit.contain,
        )
                ),
              ),
             Container(
               margin: const EdgeInsets.all(6),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Row(children: <Widget>[
                
                Expanded(
        child: Text(snapshot.documents[index]['Title']),
                ),
                SizedBox(width: 10.0,),
                IconButton(
        icon: Icon(index.isEven?FontAwesomeIcons.solidHeart:FontAwesomeIcons.heart),
        color: Colors.red,
        onPressed: ()=>null,
                )
                
              ],),
              
              Text("${snapshot.documents[index]['NumberOfFollowers']} Followers",style: TextStyle(color: Colors.black54),)
                 ],
               ),
             )
              
            ],
          ),
      ),
    );
  }
}