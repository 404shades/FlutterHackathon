import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class FollowingCommunity extends StatefulWidget {
  @override
  _FollowingCommunityState createState() => _FollowingCommunityState();
}

class _FollowingCommunityState extends State<FollowingCommunity> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("Posts").snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Text("Error ${snapshot.error}");
        }
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Text("Loading");
          default:
            return Padding(
                padding: EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  
                  itemBuilder: (context,index){
                    return GestureDetector(
                      child: getSingleView(index,snapshot.data),
                    );
                  },
                ),
            );
        }
      },
    );
  }
  Widget getSingleView(int index,QuerySnapshot snapshot){
       return Card(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
         child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 60, top: 20, right: 10),
                      width: double.infinity,
                      height: 100,
                      color: Colors.grey[200],
                      margin: EdgeInsets.only(left: 50, top: 50),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              snapshot.documents[index]['username'],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.tight,
                                child: Text(
                                  snapshot.documents[index]['desc'],
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: Colors.indigo[200],
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Icon(
                                FontAwesomeIcons.ellipsisV,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 40, top: 30),
                        color: Colors.black,
                        child: Image.network(
                          snapshot.documents[index]['userimage'],
                          height: 60,
                          width: 60,
                          fit: BoxFit.contain,
                        )),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 50),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Image.network(
                    snapshot.documents[index]['postimage'],
                    fit: BoxFit.cover,
                  ),
                ),
                Card(
                  elevation: 1,
                  margin: EdgeInsets.only(left: 40, right: 50),
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.heart,size: 20,),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "1358",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.comment,size: 20,),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "1358",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(FontAwesomeIcons.share,size: 20,),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "1358",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,)

              ],
            ),
       );
  }
}