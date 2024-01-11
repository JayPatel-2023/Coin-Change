import 'dropdownwidget.dart';
import 'package:flutter/material.dart';

import '../services/functions/fetch_rates.dart';

class AnyToAny extends StatefulWidget {
  const AnyToAny({Key? key, required this.rates, required this.currencies})
      : super(key: key);

  final rates;
  final Map currencies;

  @override
  State<AnyToAny> createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  TextEditingController usdController = TextEditingController();
  String dropdownValue1 = 'INR';
  String dropdownValue2 = 'AUD';
  String result = 'Converted Currency';
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                'Any to Any Currency',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              key: const Key('any'),
              controller: usdController,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Enter Amount',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 20),
           
            Row(
              children: [
               
                 // first drop down
                CurrencyDropdown(
                  value: dropdownValue1,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue1 = value!;
                    });
                  },
                  items: widget.currencies.keys.cast<String>().toSet().toList(),
                ),

                SizedBox(height: 20),

               //second drop down
                CurrencyDropdown(
                  value: dropdownValue2,
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue2 = value!;
                    });
                  },
                  items: widget.currencies.keys.cast<String>().toSet().toList(),
                ),               
              ],
            ),

            //covert button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  result = usdController.text +
                      ' ' +
                      dropdownValue1 +
                      '  =  ' +
                      convertany(widget.rates, usdController.text,
                          dropdownValue1, dropdownValue2) +
                      ' ' +
                      dropdownValue2;
                });
              },
              child: Text(
                'Covert',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.black45)),
            ),

            //

            //
            const SizedBox(height: 25),
            Container(
              child:
                  Text(result, style: const TextStyle(color: Colors.black54)),
            ),
          ],
        ),
      ),
    );
  }
}
