import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget {
  final String value;
  final Function(String?) onChanged;
  final List<String> items;

  const CurrencyDropdown({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DropdownButton<String>(
        dropdownColor: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(12),
        menuMaxHeight: 240.0,
        value: value,
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
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
