import 'package:flutter/material.dart';
import 'package:food_userapp/assistants/address_changer.dart';
import 'package:food_userapp/models/address.dart';
import 'package:provider/provider.dart';

class AddressDesign extends StatefulWidget {
  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? sellerUID;
  AddressDesign({
    this.addressID,
    this.currentIndex,
    this.model,
    this.sellerUID,
    this.totalAmount,
    this.value,
  });

  @override
  State<AddressDesign> createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<AddressChanger>(context, listen: false)
            .displayResults(widget.value);
      },
      child: Card(
        color: Colors.cyan.withOpacity(0.4),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: widget.value,
                  groupValue: widget.currentIndex,
                  activeColor: Colors.amber,
                  onChanged: ((val) {
                    // Provider

                    Provider.of<AddressChanger>(context, listen: false)
                        .displayResults(val);
                    print(val);
                  }),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Table(children: [
                        TableRow(children: [
                          const Text(
                            'Name: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(widget.model!.name.toString())
                        ]),
                        TableRow(children: [
                          const Text(
                            'Phone: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(widget.model!.phoneNumber.toString())
                        ]),
                        TableRow(children: [
                          const Text(
                            'Flat Number: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(widget.model!.flatNumber.toString())
                        ]),
                        TableRow(children: [
                          const Text(
                            'City: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(widget.model!.city.toString())
                        ]),
                        TableRow(children: [
                          const Text(
                            'State: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(widget.model!.state.toString())
                        ]),
                        TableRow(children: [
                          const Text(
                            'Full Address: ',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(widget.model!.fullAddress.toString())
                        ]),
                      ]),
                    ),
                  ],
                )
              ],
            ),
            ElevatedButton(
              onPressed: (() {}),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black54),
              child: const Text('Check in Maps'),
            ),

            // proceed

            widget.value == Provider.of<AddressChanger>(context).count
                ? ElevatedButton(
                    onPressed: (() {}),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Proceed'),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
