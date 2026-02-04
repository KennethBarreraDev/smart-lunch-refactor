import 'package:smart_lunch/models/product_model.dart';

class MultisaleProducts {
  DateTime saleDate;
  Map<int, int> cart;
  List<Product> cartProducts;
  double totalPrice;
  int totalProducts;
  bool selected;
  final String comment;

  MultisaleProducts({
    required this.saleDate,
    required this.cart,
    required this.cartProducts,
    this.totalPrice = 0.0,
    this.totalProducts = 0,
    this.selected = false,
    this.comment = ''
  });

  // Método para clonar el objeto
  MultisaleProducts copyWith({
    DateTime? saleDate,
    Map<int, int>? cart,
    List<Product>? cartProducts,
    double? totalPrice,
    int? totalProducts,
    bool? selected,
    String? comment,
  }) {
    return MultisaleProducts(
      saleDate: saleDate ?? this.saleDate,
      cart: cart != null ? Map.from(cart) : Map.from(this.cart),
      cartProducts: cartProducts != null ? List.from(cartProducts) : List.from(this.cartProducts),
      totalPrice: totalPrice ?? this.totalPrice,
      totalProducts: totalProducts ?? this.totalProducts,
      selected: selected ?? this.selected,
      comment: comment ?? this.comment
    );
  }
}

