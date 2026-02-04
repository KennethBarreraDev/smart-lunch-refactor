import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/pages/preferences/coupon_list/components/coupon_card.dart';
import 'package:smart_lunch/pages/preferences/coupons_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

class CouponListPage extends StatelessWidget {
  const CouponListPage({Key? key}) : super(key: key);

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
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Todos",
                  style: TextStyle(
                    color: Color(0xff413931),
                    fontSize: 22.0,
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 32,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xff1b8dda).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(
                        50,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          isExpanded: true,
                          value: "",
                          items: const [
                            DropdownMenuItem(
                              value: "",
                              child: Text(
                                "Todos",
                                style: TextStyle(
                                  color: Color(0xff1b8dda),
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            developer.log(value.toString());
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down_outlined,
                          ),
                          dropdownColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              child: Consumer<CouponsProvider>(
                builder: (context, couponsProvider, widget) => ListView(
                  shrinkWrap: false,
                  padding: EdgeInsets.zero,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      runSpacing: 25,
                      children: couponsProvider.coupons
                          .map(
                            (coupon) => CouponCard(
                              backgroundColor: coupon.backgroundColor,
                              logoUrl: coupon.logo,
                              promotion: coupon.name,
                              companyName: coupon.companyName,
                              location: coupon.state,
                              onTap: () {
                                couponsProvider.selectCoupon(coupon);
                                Navigator.of(context)
                                    .pushNamed(router.couponDetailsRoute);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
