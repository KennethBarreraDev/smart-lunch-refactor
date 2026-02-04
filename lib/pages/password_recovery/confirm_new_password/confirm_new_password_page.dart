import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/pages/login/components/components.dart';
import 'package:smart_lunch/pages/login/login_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/widgets/login_base_page.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';

class ConfirmNewPasswordPage extends StatelessWidget {
  const ConfirmNewPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<StorageProvider>(context, listen: false);
    Provider.of<HomeProvider>(context, listen: false);

    return LoginBasePage(
      title: AppLocalizations.of(context)!.new_password,
      bodyConsumer: Consumer<LoginProvider>(
        builder: (context, loginProvider, widget) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoginInput(
              labelText: AppLocalizations.of(context)!.password,
              textInputType: TextInputType.visiblePassword,
              obscurePassword: loginProvider.obscurePassword,
              onVisibilityChange: loginProvider.changePasswordVisibility,
            ),
            const SizedBox(
              height: 48,
            ),
            LoginInput(
              labelText: AppLocalizations.of(context)!.confirm_password,
              textInputType: TextInputType.visiblePassword,
              obscurePassword: loginProvider.obscurePassword,
              onVisibilityChange: loginProvider.changePasswordVisibility,
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              color: const Color(0xffef5360).withOpacity(0.25),
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Icon(
                      Icons.shield,
                      color: Color(0xffef5360),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      AppLocalizations.of(context)!.password_not_match,
                      style: const TextStyle(
                        color: Color(0xffef5360),
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
                text: "Cambiar",
                isEnabled: !loginProvider.isLoading,
                isLoading: false,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(router.loginRoute);
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
