import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/main_provider.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/roles.dart';

class BoxOverlay extends StatelessWidget {
  const BoxOverlay({
    super.key,
    required this.marginTop,
    required this.height,
    required this.firstRow,
    required this.secondRow,
    this.middleRow=const [],
    this.firstRowMainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.secondRowMainAxisAlignment = MainAxisAlignment.spaceBetween,
     this.middleRowMainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  final double marginTop;
  final double height;
  final List<Widget> firstRow;
  final List<Widget> middleRow;
  final List<Widget> secondRow;
  final MainAxisAlignment firstRowMainAxisAlignment;
    final MainAxisAlignment middleRowMainAxisAlignment;
  final MainAxisAlignment secondRowMainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: marginTop,
          ),
          width: MediaQuery.of(context).size.width * 0.92558139,
          height: height,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x1f413931),
                offset: Offset(0, 6),
                blurRadius: 18,
                spreadRadius: -5,
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: firstRowMainAxisAlignment,
                children: firstRow,
              ),
              Row(
                 mainAxisAlignment: middleRowMainAxisAlignment,
                children: middleRow
              ),
              const Divider(
                color: Colors.black12,
              ),
              const SizedBox(
                height: 9,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: secondRowMainAxisAlignment,
                  children: secondRow,
                ),
              ),
              const SizedBox(
                height: 9,
              ),

          Consumer<MainProvider>(
            builder: (context, mainProvider, widget) =>  mainProvider.userType==UserRole.tutor && mainProvider.debtors.isNotEmpty  && mainProvider.totalDebt>0 ? GestureDetector(
                onTap: () {Navigator.of(context).pushNamed(
                            router.debtorsChildrenRoute,
                          );},
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: colors.coral.withOpacity(0.2),
                      ),
                    child: const Row(
                      children: [
                        Icon(Icons.money_off, color: colors.coral, size: 17,),
                        Text("Algunos usuarios presentan deuda actualmente", style: TextStyle(fontFamily: "Comfortaa", color: colors.coral, fontSize: 9),),
                        Icon(Icons.arrow_forward_ios, color: colors.coral, size: 17,)
                      ],
                    ),
                  ),
                ),
              ):Container()
            )
            ],
          ),
        ),
      ],
    );
  }

}
