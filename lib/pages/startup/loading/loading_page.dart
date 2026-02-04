import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_lunch/utils/images.dart' as images;
// ignore: depend_on_referenced_packages
import 'package:vector_graphics/vector_graphics.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEF5360),
              Color(0xFFFFA66A),
            ],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(0, 1),
            stops: [
              0,
              1,
            ],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
                maxHeight: 100,
              ),
              child: const SvgPicture(
                AssetBytesLoader(images.whiteLogo),
                semanticsLabel: "App bar",
                // fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
