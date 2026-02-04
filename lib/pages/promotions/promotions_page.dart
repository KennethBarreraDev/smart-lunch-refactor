import 'package:flutter/material.dart';
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/widgets/coupon_painter/coupon_painter.dart';
import 'package:smart_lunch/widgets/custom_app_bar.dart';
import 'package:smart_lunch/widgets/transparent_scaffold.dart';

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TransparentScaffold(
      selectedOption: "Promociones",
      body: Column(
        children: [
          const CustomAppBar(
            height: 120,
            showPageTitle: true,
            pageTitle: "Promociones",
            image: images.appBarShortImg,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                  child: CustomPaint(
                    painter: CouponPainter(
                      borderColor: Colors.black12, // Color del borde
                      bgColor: Colors.white, // Color de fondo
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: ClipOval(
                            child: Image.network(
                              'https://brandemia.org/contenido/subidas/2022/10/marca-mcdonalds-logo-1200x670.png', // URL de la imagen redonda
                              width: MediaQuery.of(context).size.width * 0.17,
                              height:
                                  MediaQuery.of(context).size.width * 0.17,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.15),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "McDonalds",
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                    fontFamily: "Confortaa"),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "2X1 en hamburgesas",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "Confortaa"),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Morelia",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 13,
                                        fontFamily: "Confortaa"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.green.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Center(
                                        child: Text(
                                          "Restaurantes",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: "Confortaa",
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
