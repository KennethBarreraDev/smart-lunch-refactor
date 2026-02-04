import 'package:flutter/material.dart';

class SearchProductInput extends StatelessWidget {
  SearchProductInput(
      {super.key, required this.findProduct, required this.inputController});

  final void Function(String) findProduct;
  final TextEditingController inputController;

//Add validaciones de filtros
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      onChanged: (value) {
      findProduct.call(value);
      },
      decoration: InputDecoration(
        hintText: 'Buscar producto',
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
