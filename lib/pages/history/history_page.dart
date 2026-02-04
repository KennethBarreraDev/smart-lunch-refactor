import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:smart_lunch/pages/history/components/history_tile.dart';
import 'package:smart_lunch/pages/history/history_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainProvider mainProvider = Provider.of<MainProvider>(
      context,
      listen: false,
    );

    return TransparentScaffold(
      selectedOption: "Historial",
      body: Column(
        children: [
          CustomAppBar(
            height: 160,
            showPageTitle: true,
            pageTitle: AppLocalizations.of(context)!.history,
            image: images.appBarShortImg,
          ),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  ColoredBox(
                    color: colors.white,
                    child: TabBar(
                      labelColor: colors.orange,
                      unselectedLabelColor: colors.orange.withOpacity(0.5),
                      indicatorColor: colors.orange,
                      labelPadding: EdgeInsets.zero,
                      tabs: [
                        Tab(
                          text: AppLocalizations.of(context)!.sale,
                        ),
                        Tab(
                          text: AppLocalizations.of(context)!.top_up,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          child: Consumer<HistoryProvider>(
                            builder: (context, historyProvider, widget) =>
                                RefreshIndicator(
                              onRefresh: () async {
                                await historyProvider.getProductHistory(
                                  mainProvider.accessToken,
                                  mainProvider.cafeteriaId,
                                  int.parse(mainProvider.studentId),
                                  mainProvider.userType
                                );
                              },
                              child: ListView(
                                shrinkWrap: false,
                                padding: EdgeInsets.zero,
                                children: historyProvider.productHistory
                                    .map(
                                      (record) => HistoryTile(
                                        saleTime: record.saleTime,
                                        saleType: record.saleType,
                                        saleId: record.saleId,
                                        totalAmount: mainProvider.numberFormat
                                            .format(record.saleTotal),
                                        date: record.saleDate,
                                        childName: record.childName,
                                        products: record.products,
                                        status: record.saleStatus,
                                        comments: record.cafeteriaComment,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          child: Consumer<HistoryProvider>(
                            builder: (context, historyProvider, widget) =>
                                RefreshIndicator(
                              onRefresh: () async {
                                await historyProvider.getRechargeHistory(
                                  mainProvider.accessToken,
                                  mainProvider.cafeteriaId,
                                    int.parse(mainProvider.studentId),
                                    mainProvider.userType
                                );
                              },
                              child: ListView(
                                shrinkWrap: false,
                                padding: EdgeInsets.zero,
                                children: historyProvider.rechargeHistory
                                    .map(
                                      (record) => HistoryTile(
                                        saleTime: record.rechargeTime,
                                        saleType: record.platform,
                                        saleId: record.id,
                                        totalAmount: record.total,
                                        date: record.rechargeDate,
                                        childName: record.rechargeUser,
                                        products: const [],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
