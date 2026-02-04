import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/home/components/rounded_button.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

class DebtorsChildrenPage extends StatelessWidget {
  const DebtorsChildrenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TransparentScaffold(
      selectedOption: "Hijos",
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                const CustomAppBar(
                  height: 140,
                  showDrawer: false,
                  showPageTitle: true,
                  pageTitle: "Hijos",
                  image: images.appBarShortImg,
                  titleAlignment: Alignment.centerLeft,
                ),


                Column(
                  children: [
                    const SizedBox(height: 150,),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.user_message, style: const TextStyle(fontFamily: "Comfortaa", fontSize: 16),),
                          Text(AppLocalizations.of(context)!.current_debt, style: const TextStyle(fontFamily: "Comfortaa", fontSize: 16),)
                        ],
                      ),
                    ),
                    const SizedBox(height: 50,),

                    Expanded(
                      child: Consumer<MainProvider>(
                        builder: (context, mainProvider, widget) => ListView(
                          shrinkWrap: false,
                          padding: EdgeInsets.zero,
                          children: mainProvider.debtors
                              .map(
                                (child) => Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width *
                                                    0.15,
                                                height: 50,
                                                decoration:
                                                BoxDecoration(
                                                  shape:
                                                  BoxShape.circle,
                                                  image:
                                                  DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:  mainProvider.children.where((element) => element.id==child.id).first.imageUrl.isNotEmpty
                                                        ? NetworkImage(
                                                       mainProvider.children.where((element) => element.id==child.id).first.imageUrl)
                                                        : const AssetImage(
                                                        images
                                                            .defaultProfileStudentImage)
                                                    as ImageProvider<
                                                        Object>,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${child.childName} ${child.childLastName}", style: const TextStyle(color: colors.darkBlue, fontSize: 16, fontFamily: "Comfortaa", fontWeight: FontWeight.w600), ),
                                                  Text(AppLocalizations.of(context)!.registration, style: const TextStyle(fontSize: 12, fontFamily: "Comfortaa", color: colors.darkBlue),)
                                                ],
                                              )
                                            ],
                                          ),
                                          Text("\$${child.debt}", style: const TextStyle(color: colors.darkBlue, fontSize: 25, fontFamily: "Comfortaa", fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                      const SizedBox(height: 2,),
                                      Divider(color: Colors.grey.withOpacity(0.2),),
                                      const SizedBox(height: 21,),
                                    ],
                                  ),
                                )
                          )
                              .toList(),
                        ),
                      ),
                    ),
                    Consumer<MainProvider>(
                      builder: (context, mainProvider, widget) =>
                          Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(AppLocalizations.of(context)!.total_debt, style: const TextStyle(fontFamily: "Comfortaa", fontSize: 18, ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
                          ),
                          Text("\$${mainProvider.totalDebt}", style: const TextStyle(fontFamily: "Comfortaa", fontSize: 25, ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
                          )
                        ],
                      ),
                    )),
                    Padding(padding: const EdgeInsets.all(12),
                      child: Text(
                        "* ${AppLocalizations.of(context)!.pay_debt_explanation}",
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: "Comfortaa",
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RoundedButton(
                        color: colors.tuitionGreen,
                        iconData: Icons.payments,
                        text: "Pagar",
                        verticalPadding: 14,
                        mainAxisAlignment: MainAxisAlignment.center,
                        onTap: (){
                          Navigator.of(context)
                              .pushNamed(router.topUpRoute);
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
