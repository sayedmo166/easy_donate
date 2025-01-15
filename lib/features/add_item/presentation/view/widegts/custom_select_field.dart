import 'package:flutter/material.dart';

class CustomSelectField extends StatefulWidget {
  final Function(String?)? onChanged;

  const CustomSelectField({super.key, this.onChanged});

  @override
  State<CustomSelectField> createState() => _CustomSelectFieldState();
}

class _CustomSelectFieldState extends State<CustomSelectField> {
  final List<String> items = ['كتب دراسية', 'ملابس', 'اخري'];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'اختر من القائمة',
          labelStyle: const TextStyle(color: Color(0xFF6A6A6A)),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.green, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        value: selectedValue,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        dropdownColor: Colors.white,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
        ),
        iconSize: 30,
        menuMaxHeight: 200,
        isExpanded: true,
      ),
    );
  }
}
