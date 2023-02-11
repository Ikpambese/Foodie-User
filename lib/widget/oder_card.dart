import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_userapp/models/items.dart';

class OrderCard extends StatelessWidget {
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantiesList;
  const OrderCard(
      {this.data, this.itemCount, this.orderID, this.seperateQuantiesList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //todo
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black12,
              Colors.white54,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: itemCount,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              Items model =
                  Items.fromJson(data![index].data()! as Map<String, dynamic>);
              return placedOrderDesign(model, context, seperateQuantiesList);
            })),
      ),
    );
  }
}

// Class widget

Widget placedOrderDesign(Items model, BuildContext context, seperateQuantList) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 200,
    color: Colors.grey[200],
    child: Row(
      children: [
        Image.network(model.thumbnailUrl!, width: 120),
        const SizedBox(width: 10.0),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  model.title!,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 16, fontFamily: 'Acme'),
                )),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  '₦',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                Text(
                  model.price.toString(),
                  style: const TextStyle(fontSize: 16, color: Colors.blue),
                )
              ],
            ),
            Row(
              children: [
                const Text(
                  'X',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Expanded(
                    child: Text(
                  seperateQuantList,
                  style: const TextStyle(
                      fontSize: 30, color: Colors.black54, fontFamily: 'Acme'),
                ))
              ],
            )
          ],
        ))
      ],
    ),
  );
}
