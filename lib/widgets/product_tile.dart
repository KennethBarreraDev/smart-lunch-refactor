import 'package:flutter/material.dart';
import 'package:smart_lunch/utils/images.dart' as images;

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.productCategory,
    required this.ingredients,
    required this.trailing,
    required this.description
  });

  final String imageUrl;
  final String title;
  final String productCategory;
  final List<String> ingredients;
  final String description;
  final Widget trailing;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      dense: false,
      horizontalTitleGap: 12,
      isThreeLine: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: imageUrl.isNotEmpty ? BoxFit.cover : BoxFit.contain,
                image: imageUrl.isNotEmpty
                    ? NetworkImage(
                        imageUrl,
                      )
                    : const AssetImage(
                        images.defaultProductImage,
                      ) as ImageProvider<Object>,
              ),
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Flexible(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xff413931),
                fontWeight: FontWeight.w700,
                fontFamily: "Comfortaa",
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      subtitle: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              style: TextStyle(
                color: const Color(0xffffa66a).withOpacity(0.5),
                fontWeight: FontWeight.w600,
                fontFamily: "Comfortaa",
                // fontSize: 12,
              ),
              text: productCategory,
            ),
            TextSpan(
              style: TextStyle(
                color: const Color(0xff413931).withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontFamily: "Comfortaa",
                // fontSize: 12,
              ),
              text: "\n$description",
            ),
          ],
        ),
      ),
      trailing: trailing,
    );
  }
}
