import 'package:flutter/material.dart';

import '../services/functions/fetch_rates.dart';

class UsdToAny extends StatefulWidget {
  const UsdToAny({Key? key, required this.rates, required this.currencies})
      : super(key: key);

  final rates;
  final Map currencies;

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  TextEditingController usdController = TextEditingController();
  String dropdownValue = 'INR';
  String result = 'Converted Currency';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                'USD to Any Currency',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              key: const Key('usd'),
              controller: usdController,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Enter USD',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(12),
                    menuMaxHeight: 240.0,
                    value: dropdownValue,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.black45,
                    ),
                    iconSize: 40,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade400,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 10),

                //covert button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      result = usdController.text +
                          ' USD  =  ' +
                          convertusd(
                              widget.rates, usdController.text, dropdownValue) +
                          ' ' +
                          dropdownValue;
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
              ],
            ),
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
