import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/login/components/components.dart';
import 'package:smart_lunch/pages/login/login_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/widgets/login_base_page.dart';

class VerificationCodePage extends StatelessWidget {
  const VerificationCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return LoginBasePage(
      title: "Código de verificación",
      bodyConsumer: Consumer<LoginProvider>(
        builder: (context, loginProvider, widget) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LoginInput(
              labelText: "Código",
              textInputType: TextInputType.number,
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              color: colors.orange.withOpacity(0.25),
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Icon(
                      Icons.forward_to_inbox,
                      color: colors.orange,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "Hemos enviado un código de verificación",
                      style: TextStyle(
                        color: colors.orange,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Consumer<MainProvider>(
              builder: (context, mainProvider, widget) => LoginButton(
                text: "Validar",
                isEnabled: !loginProvider.isLoading,
                isLoading: loginProvider.isLoading,
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(router.confirmNewPasswordRoute);
                  // loginProvider
                  //     .login(mainProvider, storageProvider)
                  //     .then(
                  //   (isLoggedIn) {
                  //     developer.log(isLoggedIn.toString(),
                  //         name: "login_buttonResponse");
                  //     if (isLoggedIn) {
                  //       mainProvider
                  //           .updateLoginInfo(storageProvider)
                  //           .then((value) {
                  //         mainProvider.getChildren().then((value) {
                  //           homeProvider.loadAll(
                  //             mainProvider.accessToken,
                  //             mainProvider.selectedChild?.schoolId ??
                  //                 "",
                  //             mainProvider.selectedChild?.id
                  //                     .toString() ??
                  //                 "",
                  //           );
                  //           Navigator.of(context)
                  //               .pushReplacementNamed(
                  //                   router.homeRoute);
                  //         });
                  //       });
                  //     }
                  //   },
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
