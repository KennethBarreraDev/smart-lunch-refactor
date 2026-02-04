import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_lunch/pages/login/components/login_button.dart';
import 'package:smart_lunch/pages/password_recovery/restore_password/restore_password_provider.dart';
import 'package:smart_lunch/widgets/login_base_page.dart';
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:smart_lunch/routes/router.dart' as router;
import 'package:smart_lunch/l10n/app_localizations.dart';


class SucessfulPasswordRecoveryPage extends StatelessWidget {
  const SucessfulPasswordRecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginBasePage(
      shortMargin: true,
      title: "",
      bodyConsumer: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            images.emailVerification,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(context)!.check_email,
            style: TextStyle(
              color: const Color(0xffEF5360).withOpacity(0.9),
              fontSize: 33.0,
              fontFamily: "Comfortaa",
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Consumer<RestorePasswordProvider>(
              builder: (context, cardsInfoProvider, widget) {
            return Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.send_email_message,
                    style: const TextStyle(
                      fontSize: 11,
                      fontFamily: "Comfortaa",
                    ),
                  ),
                  TextSpan(
                    text: cardsInfoProvider.userEmailController.text,
                    style: const TextStyle(
                        fontSize: 11,
                        fontFamily: "Comfortaa",
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "${AppLocalizations.of(context)!.click_link}",
                    style: const TextStyle(
                      fontSize: 11,
                      fontFamily: "Comfortaa",
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(
            height: 20,
          ),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: "${AppLocalizations.of(context)!.note}",
                  style: const TextStyle(
                      fontSize: 11,
                      fontFamily: "Comfortaa",
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: AppLocalizations.of(context)!.check_spam_message,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: "Comfortaa",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Consumer<RestorePasswordProvider>(
              builder: (context, cardsInfoProvider, widget) {
            return LoginButton(
              text: AppLocalizations.of(context)!.go_back_button,
              isEnabled: true,
              isLoading: false,
              onPressed: (() {
                cardsInfoProvider.userEmailController.text="";
                Navigator.of(context).pushReplacementNamed(router.loginRoute);
              }),
            );
          }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
          ),
        ],
      ),
    );
  }
}
