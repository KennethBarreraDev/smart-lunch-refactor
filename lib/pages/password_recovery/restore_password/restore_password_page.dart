import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/pages/home/components/rounded_button.dart';
import 'package:smart_lunch/pages/login/components/components.dart';
import 'package:smart_lunch/pages/login/login_provider.dart';
import 'package:smart_lunch/pages/password_recovery/restore_password/restore_password_provider.dart';
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/widgets/login_base_page.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;
import 'package:smart_lunch/l10n/app_localizations.dart';


class RestorePasswordPage extends StatelessWidget {
  const RestorePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginBasePage(
      title: AppLocalizations.of(context)!.password_recover,
      bodyConsumer: Consumer<LoginProvider>(
        builder: (context, loginProvider, widget) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<RestorePasswordProvider>(
                builder: (context, restorePasswordProvider, widget) {
              return Column(
                children: [
                  LoginInput(
                    onChange: (p0) {
                      restorePasswordProvider.resetRequestValue();
                    },
                    textEditingController:
                        restorePasswordProvider.userEmailController,
                    labelText: AppLocalizations.of(context)!.email,
                    textInputType: TextInputType.emailAddress,
                  ),
                  if (!restorePasswordProvider.successRequest)
                    Container(
                      color: const Color(0xffef5360).withOpacity(0.25),
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      margin: const EdgeInsets.only(top: 24),
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
                              AppLocalizations.of(context)!.try_again_later,
                              style: const TextStyle(
                                color: Color(0xffef5360),
                                fontSize: 14,
                                fontFamily: "Comfortaa",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            }),
            const SizedBox(
              height: 40,
            ),
            Consumer<RestorePasswordProvider>(
              builder: (context, restorePasswordProvider, widget) => Column(
                children: [
                  LoginButton(
                    text: AppLocalizations.of(context)!.send_button,
                    isEnabled: !restorePasswordProvider.isLoading,
                    isLoading: restorePasswordProvider.isLoading,
                    onPressed: () {
                      restorePasswordProvider
                          .sendVerificationEmail()
                          .then((value) {
                        if (value) {
                          Navigator.of(context).pushReplacementNamed(
                              router.sucessfulPasswordRecoveryRoute);
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 245,
                    child: RoundedButton(
                      fontSize: 20,
                      color: colors.orange,
                      iconData: null,
                      text: AppLocalizations.of(context)!.go_back_button,
                      mainAxisAlignment: MainAxisAlignment.center,
                      verticalPadding: 14,
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(router.loginRoute);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
          ],
        ),
      ),
    );
  }
}
