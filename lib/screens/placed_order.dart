import 'package:flutter/material.dart';

class PlacedOrderScreen extends StatefulWidget {
  String? addressID;
  double? totalAmount;
  String? sellerUID;
  PlacedOrderScreen({this.addressID, this.sellerUID, this.totalAmount});
  @override
  State<PlacedOrderScreen> createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/delivery.jpg'),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: (() {}),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(14)),
              child: const Text('Place order'),
            )
          ],
        ),
      ),
    );
  }
}
