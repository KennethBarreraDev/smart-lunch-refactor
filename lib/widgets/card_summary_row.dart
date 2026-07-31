import 'package:flutter/material.dart';
import 'package:smart_lunch/utils/images.dart' as images;

/// muestra el resumen de una tarjeta de pago

class CardSummaryRow extends StatelessWidget {
  const CardSummaryRow({
    super.key,
    required this.holderName,
    required this.cardNumber,
    required this.brand,
    required this.holderNameStyle,
    required this.cardNumberStyle,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
    this.holderLabel,
    this.holderNameWidth,
    this.trailing,
  });

  final String holderName;
  final String cardNumber;
  final String brand;
  final TextStyle holderNameStyle;
  final TextStyle cardNumberStyle;
  final MainAxisAlignment mainAxisAlignment;
  final String? holderLabel;
  final double? holderNameWidth;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final nameText = Text(
      holderName,
      style: holderNameStyle,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );

    final holderBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (holderLabel != null)
          Text(
            holderLabel!,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 10,
              fontFamily: "Comfortaa",
            ),
          ),
        holderNameWidth != null
            ? SizedBox(
                width: holderNameWidth,
                child: Row(children: [Expanded(child: nameText)]),
              )
            : nameText,
      ],
    );

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        holderBlock,
        const Padding(padding: EdgeInsets.only(right: 5)),
        Text(
          cardNumber,
          style: cardNumberStyle,
        ),
        Image.asset(images.cardBrandImageWithFallback(brand)),
        if (trailing != null) trailing!,
      ],
    );
  }
}
