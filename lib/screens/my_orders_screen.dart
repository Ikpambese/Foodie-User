import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_userapp/assistants/assistant_methods.dart';
import 'package:food_userapp/global/global.dart';
import 'package:food_userapp/widget/oder_card.dart';
import 'package:food_userapp/widget/progress_bar.dart';
import 'package:food_userapp/widget/simple_appbar.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: ''),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(sharedPreferences!.getString('uid'))
            .collection('orders')
            .where('status', isEqualTo: 'normal')
            .orderBy('orderTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('items')
                          .where('itemID',
                              whereIn: seperateOrderIDs(
                                  (snapshot.data!.docs[index].data()!
                                      as Map<String, dynamic>)['productIDs']))
                          .where('orderBy',
                              whereIn: (snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>)['uid'])
                          .orderBy('publishedDate', descending: true)
                          .get(),
                      builder: (context, snap) {
                        return snap.hasData
                            ? OrderCard(
                                itemCount: snap.data!.docs.length,
                                data: snap.data!.docs,
                                orderID: snapshot.data!.docs[index].id,
                                seperateQuantiesList:
                                    seperateORderItemQuantities((snapshot
                                            .data!.docs[index]
                                            .data()
                                        as Map<String, dynamic>)['productIDs']),
                              )
                            : Center(
                                child: circularProgress(),
                              );
                      },
                    );
                  },
                )
              : Center(
                  child: circularProgress(),
                );
        },
      ),
    );
  }
}
