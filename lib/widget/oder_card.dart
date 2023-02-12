import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_userapp/models/items.dart';
import 'package:food_userapp/screens/order_details_screen.dart';

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => OrderDeatilsScreen(orderID: orderID)));
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
        child: SizedBox(
          height: itemCount! * 125,
          child: ListView.builder(
              itemCount: itemCount,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) {
                Items model = Items.fromJson(
                    data![index].data()! as Map<String, dynamic>);
                return placedOrderDesign(
                    model, context, seperateQuantiesList.toString());
              })),
        ),
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
            const SizedBox(
              height: 20,
            ),
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
                  style: const TextStyle(fontSize: 18, color: Colors.blue),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'x',
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
