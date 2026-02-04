import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/pages/preferences/coupons_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

class CouponDetailsPage extends StatelessWidget {
  const CouponDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentScaffold(
      selectedOption: "Ajustes",
      body: Column(
        children: [
          const CustomAppBar(
            height: 160,
            showPageTitle: true,
            pageTitle: "Cupones",
            image: images.appBarShortImg,
            showDrawer: false,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              child: SingleChildScrollView(
                child: Consumer<CouponsProvider>(
                  builder: (context, couponsProvider, widget) => Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colors.darkBlue.withOpacity(0.05),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                couponsProvider.openCompanyUrl(
                                  couponsProvider.selectedCoupon?.companyUrl ??
                                      "",
                                );
                              },
                              child: ClipPath(
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
                                              couponsProvider
                                                      .selectedCoupon?.logo ??
                                                  "",
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
                                    couponsProvider.selectedCoupon?.name ?? "",
                                    style: const TextStyle(
                                      color: colors.darkBlue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    couponsProvider
                                            .selectedCoupon?.companyName ??
                                        "",
                                    style: const TextStyle(
                                      color: colors.darkBlue,
                                      fontSize: 24.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Dirección",
                                    style: TextStyle(
                                      color: colors.darkBlue.withOpacity(0.5),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    couponsProvider.selectedCoupon?.address ??
                                        "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    "Descripción",
                                    style: TextStyle(
                                      color: colors.darkBlue.withOpacity(0.5),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    couponsProvider
                                            .selectedCoupon?.description ??
                                        "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "* Términos y condiciones: orem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore",
                        style: TextStyle(
                          color: colors.darkBlue.withOpacity(0.25),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      if (couponsProvider.selectedCoupon?.mapUrl.isNotEmpty ??
                          false)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 13,
                                horizontal: 24,
                              ),
                              backgroundColor:
                                  colors.lightGreen.withOpacity(0.15),
                              shadowColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                            onPressed: () {
                              couponsProvider.openMap(
                                couponsProvider.selectedCoupon?.mapUrl ?? "",
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.pin_drop,
                                  color: colors.lightGreen,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Mapa",
                                  style: TextStyle(
                                    color: colors.lightGreen,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
