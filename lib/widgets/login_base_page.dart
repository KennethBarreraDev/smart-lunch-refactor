import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_lunch/utils/images.dart' as images;
// ignore: depend_on_referenced_packages
import 'package:vector_graphics/vector_graphics.dart';

class LoginBasePage extends StatelessWidget {
  const LoginBasePage({
    this.shortMargin = false,
    super.key,
    required this.title,
    required this.bodyConsumer,
  });

  final String title;
  final Widget bodyConsumer;
  final bool shortMargin;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          Colors.transparent, // Change this color to your desired color
    ));
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:  AssetImage(images.loginBackground),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      const Color(0xffF36A63).withOpacity(0.8),
                      BlendMode.srcOver,
                    ),
                  ),
                )),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      bottom: shortMargin
                          ? MediaQuery.of(context).size.height * 0.12
                          : MediaQuery.of(context).size.height * 0.15,
                      top: MediaQuery.of(context).size.height * 0.11),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.80,
                      maxHeight: 100,
                    ),
                    child:  SvgPicture(
                      AssetBytesLoader(images.whiteLogo),
                      semanticsLabel: "App bar",
                      // fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: shortMargin ? 0 : 20,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: const Color(0xffEF5360).withOpacity(0.9),
                          fontSize: 40.0,
                          fontFamily: "Comfortaa",
                        ),
                      ),
                      SizedBox(
                        height: shortMargin ? 0 : 20,
                      ),
                      bodyConsumer,
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
