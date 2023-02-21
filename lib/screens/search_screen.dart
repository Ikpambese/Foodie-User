import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_userapp/models/sellers.dart';
import 'package:food_userapp/widget/appbar.dart';
import 'package:food_userapp/widget/sellersdesign.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<QuerySnapshot>? restaurantDocumentList;
  String sellerNameText = '';
  initSearchingRestaurant(String textEntered) {
    restaurantDocumentList = FirebaseFirestore.instance
        .collection('sellers')
        .where('sellerName', isGreaterThanOrEqualTo: textEntered)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan,
                Colors.amber,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: TextField(
          onChanged: (textEntered) {
            setState(() {
              sellerNameText = textEntered;
            });
            initSearchingRestaurant(textEntered);
          },
          decoration: InputDecoration(
            hintText: 'Search Restaurant Here',
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {
                initSearchingRestaurant(sellerNameText);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: restaurantDocumentList,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Sellers model = Sellers.fromJson(
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>);

                      return SellersDesign(
                        context: context,
                        model: model,
                      );
                    })
                : const Center(
                    child: Text('No record found'),
                  );
          }),
    );
  }
}
