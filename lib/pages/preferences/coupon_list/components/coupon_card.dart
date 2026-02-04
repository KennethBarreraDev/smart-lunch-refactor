import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;

class CouponCard extends StatelessWidget {
  const CouponCard({
    super.key,
    required this.backgroundColor,
    required this.logoUrl,
    required this.promotion,
    required this.companyName,
    required this.location,
    this.onTap,
  });

  final String backgroundColor;
  final String logoUrl;
  final String promotion;
  final String companyName;
  final String location;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: colors.darkBlue.withOpacity(0.05),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        width: MediaQuery.of(context).size.width * 0.43,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: PointsClipper(),
              child: Container(
                height: 120,
                color: Colors.black,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: ResizeImage(
                          NetworkImage(
                            logoUrl,
                          ),
                          width: 262,
                          height: 262,
                          allowUpscaling: true,
                          policy: ResizeImagePolicy.fit,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    promotion,
                    style: const TextStyle(
                      color: colors.darkBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    companyName,
                    style: TextStyle(
                      color: colors.darkBlue.withOpacity(0.5),
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.pin_drop,
                        color: colors.lightBlue,
                      ),
                      Text(
                        location,
                        style: const TextStyle(
                          color: colors.lightBlue,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
