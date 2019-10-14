import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcglynns_food2go/CustomCard.dart';

class DeliDaily extends StatefulWidget {
  @override
  _DeliDailyState createState() => _DeliDailyState();
}

class _DeliDailyState extends State<DeliDaily> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Deli Daily'),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('Deli Daily')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return new CustomCard(
                          title: document['name'],
                        );
                      }).toList(),
                    );
                }
              },
            )),
      ),
    );
  }
}