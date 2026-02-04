import 'package:flutter/material.dart';
import 'package:smart_lunch/models/history_product.dart';
import 'package:smart_lunch/pages/history/components/history_table.dart';
import 'package:smart_lunch/widgets/custom_expansion_tile.dart';


class HistoryTile extends StatelessWidget {
  const HistoryTile({
    super.key,
    required this.childName,
    required this.date,
    required this.totalAmount,
    required this.saleId,
    required this.saleType,
    required this.saleTime,
    required this.products,
    this.status = '',
    this.comments=''
  });

  final String childName;
  final String date;
  final String totalAmount;
  final String saleId;
  final String saleType;
  final String saleTime;
  final String? status;
  final String? comments;
  final List<HistoryProduct> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      child: CustomExpansionTile(
        hasBackgroundColor: true,
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        childrenPadding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                childName,
                style: const TextStyle(
                  color: Color(0xff413931),
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
              ),
            ),
            Text(
              "\$$totalAmount",
              style: TextStyle(
                color: const Color(0xff413931).withOpacity(0.75),
                fontSize: 18.0,
                  fontFamily: "Outfit"
              ),
            ),
          ],
        ),
        subtitle: Text(
          date,
          style: TextStyle(
            color: const Color(0xff413931).withOpacity(0.5),
            fontWeight: FontWeight.w300,
              fontFamily: "Comfortaa"
          ),
        ),
        trailing: const Icon(
          Icons.expand_circle_down_outlined,
        ),
        
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [

                HistoryTable(
                  saleId: saleId,
                  saleType: saleType,
                  saleTime: saleTime,
                  products: products,
                  status: status,
                  comments: comments,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
