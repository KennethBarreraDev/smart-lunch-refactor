import 'package:flutter/material.dart';
import 'package:smart_lunch/pages/cards_info/croem/card_list_croem.dart';
import 'package:smart_lunch/pages/home/panama_home.dart';
import 'package:smart_lunch/pages/panama/croem_page.dart';
import 'package:smart_lunch/pages/panama/membership_debtors/membership_debtors.dart';
import 'package:smart_lunch/pages/panama/membership_debtors/select_payment_method_membership.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_calendar.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_children_page.dart';
import 'package:smart_lunch/pages/panama/multiple_sales/multisale_pages.dart';
import 'package:smart_lunch/pages/panama/multisale_success_screen/membership_success_page.dart';
import 'package:smart_lunch/pages/panama/multisale_success_screen/multisale_success_page.dart';
import 'package:smart_lunch/pages/panama/payment_method/select_payment_method.dart';
import 'package:smart_lunch/pages/panama/static_values.dart';
import 'package:smart_lunch/pages/panama/success_top_up/success_top_up_panama.dart';
import 'package:smart_lunch/pages/panama/summary_sale/panama_summary_sale.dart';
import 'package:smart_lunch/pages/panama/top_up_panama/top_up_panama.dart';
import 'package:smart_lunch/pages/debtors_children/debtors_children_page.dart';
import 'package:smart_lunch/pages/home/components/student_identification.dart';
import 'package:smart_lunch/pages/home/independent_student_home_page.dart';
import 'package:smart_lunch/pages/login/components/privacity/privacity.dart';
import 'package:smart_lunch/pages/login/components/privacity/terms_and_conditions.dart';
import 'package:smart_lunch/pages/mercado_pago/mercado_pago_page.dart';
import 'package:smart_lunch/pages/pages.dart';
import 'package:smart_lunch/pages/panama/yappy_payment_pages/error_payment.dart';
import 'package:smart_lunch/pages/panama/yappy_payment_pages/success_payment.dart';
import 'package:smart_lunch/pages/password_recovery/restore_password/sucessful_password_recovery_page.dart';
import 'package:smart_lunch/pages/promotions/promotions_page.dart';
import 'package:smart_lunch/pages/sales/components/purchase_summary_page.dart';
import 'package:smart_lunch/pages/sales/components/select_sale_card.dart';
import 'package:smart_lunch/pages/sales/successful_sale/successful_presale_page.dart';
import 'package:smart_lunch/pages/sales/successful_sale/successful_sale_independent_student_page.dart';
import 'package:smart_lunch/pages/top_up_mercado_pago/components/top_up_mercado_pago_status_page.dart';
import 'package:smart_lunch/pages/top_up_mercado_pago/top_up_page_mercado_pago.dart';
import 'package:smart_lunch/pages/top_up_balance/top_up_open_pay_page.dart';
import 'package:smart_lunch/pages/top_up_balance/top_up_successful_page.dart';
import 'package:smart_lunch/utils/images.dart';
import 'dart:developer' as developer;

// Home
const String homeRoute = "home";
const String independentHomeRoute = "student/home";
const String panamaHome = "panama/home";
const String saleRoute = "home/sale";
const String successfulSaleRoute = "home/sale/success";
const String successfulPresaleSaleRoute = "home/presale/success";
const String successfulSaleIndependentSaleRoute =
    "home/independent_student/sale/success";
const String menuRoute = "home/menu";

const String multisaleRoute = "home/multisale";
const String multisaleCalendarRoute = "home/multisale-calendar";
const String multisalePageRoute = "home/multisale-page";

//Top up
const String topUpBalanceRoute = "home/topUp";
const String openPay3dSecureRoute = "home/topUp/confirm";
const String independentStudentIdentificationRoute =
    "home/student/identification";
const String purchaseSummary = "home/sale/purchase-summary";

const String topUpRoute = "top-up";
const String yappyTopUpStatuspStatus = "top-up-status";
const String topUpOpenpayRoute = "home/topUp/openpay";
const String topUpOpenpayStatusRoute = "openpay-recharge-status";
const String mercadoPagoStatusRoute = "mercadopago-status-page";

// Children

const String childrenRoute = "children";
const String childRoute = "children/child";
const String forbiddenProductsRoute = "children/forbidden";
const String limitedProductsRoute = "children/limited";
const String debtorsChildrenRoute = "debtors/children";

// History
const String historyRoute = "history";
const String baseRoute = "base";
const String checkAuthRoute = "checkAuth";

// Preferences
const String settingsRoute = "preferences";
const String accountRoute = "preferences/account";
const String changeTutorPasswordRoute = "preferences/updatePassword";
const String couponListRoute = "preferences/coupons";
const String couponDetailsRoute = "preferences/coupons/details";

// Cards
const String cardsRoute = "cards";
const String registerCardRoute = "cards/register";
const String selectCardToPaySale = "cards/sale";

//Login
const String loginRoute = "login";
const String sucessfulPasswordRecoveryRoute = "email_notification";
const String privacityPolicy = "privacity_policy";
const String termsAndCondition = "terms_and_conditions";

const String restorePasswordRoute = "restore";
const String verificationCodeRoute = "resotre/code";
const String confirmNewPasswordRoute = "restore/new";

const String initialRoute = "initial";

//Mercado libre
const String mercadoPagoPage = "mercado_pago";

//Panama
const String panamaPaymentMethod = "panama/select_payment_method";
const String panamaSummarySale = "panama/summary_sale";
const String panamaMembershipDeptors = "panama/membership_debtors";
const String payMembership = "panama/pay_membership";

//Croem
const String topUpCroemRoute = "home/topUp/croem";

//Croem cards
const String croemCardsRoute = "croem/cards";
const String createCroemCardRoute = "croem/create-card";

//Yappy
const String yappySuccess = "/yappy-success";
const String yappyError = "/yappy-error";

const String multisaleSuccessPage = "/multisale/success";
const String membershipPaymentSuccess = "/membership/success";

//Promotions
const String promotionsRoute = "promotions";

Route<MaterialPageRoute> controller(RouteSettings settings) {
  //print("Ruta params");
  //print(settings.name);

  String rechargeStatus = "rejected";
  String paymentId = "" ;
    String merchantOrderId = "" ;
    String externalReference ="";
  String yappyId = "";

  String customSettings = "";
  customSettings = settings.name!;

  YappyValues.yappyMembershipPayment = "";

 developer.log("Enter url ${settings.toString()}", name: "DEEPLINK_URL");

  developer.log("Enter url $customSettings", name: "DEEPLINK_URL");

  if (customSettings == "panama/home") {
    //customSettings = "/yappy-error/sales/12,2,23,34/";
    //customSettings = "/yappy-success/recharge/3834";
  }

  if (customSettings.contains("yappy-success") &&
      customSettings.contains("recharge")) {
    developer.log("Yappi recharge success $customSettings",
        name: "DEEPLINK_URL");
    rechargeStatus = "approved";
    customSettings = yappyTopUpStatuspStatus;
  } else if (customSettings.contains("yappy-error") &&
      customSettings.contains("recharge")) {
    developer.log("Yappi recharge error $customSettings", name: "DEEPLINK_URL");

    yappyId = customSettings.split("/").last;
    rechargeStatus = "rejected";
    customSettings = yappyTopUpStatuspStatus;
  } else if (customSettings.contains("yappy-success") &&
      customSettings.contains("sales")) {
    developer.log("Yappy sales $customSettings", name: "DEEPLINK_URL");
    YappyValues.yappyMembershipPayment = "SUCCESS";
    customSettings = panamaHome;
  } else if (customSettings.contains("yappy-error") &&
      customSettings.contains("sales")) {
    developer.log("Yappi sales error $customSettings", name: "DEEPLINK_URL");
    YappyValues.yappyMembershipPayment = "ERROR";
    customSettings = panamaHome;
  }
  else if(customSettings.contains("top-up-status")){
    customSettings=mercadoPagoStatusRoute;
    Map<String, String> queryParams = getQueryParams(settings.name!);
    rechargeStatus = queryParams["status"]?.toString() ?? "";
    paymentId = queryParams["payment_id"]?.toString() ?? "";
    merchantOrderId = queryParams["merchant_order_id"]?.toString() ?? "";
    externalReference = queryParams["external_reference"]?.toString() ?? "";
  }

  switch (customSettings) {
    case baseRoute:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
        settings: settings,
      );
    case homeRoute:
      return MaterialPageRoute(
        builder: (context) => const HomePage(),
        settings: settings,
      );
    case independentHomeRoute:
      return MaterialPageRoute(
        builder: (context) => const IndependentStudentPage(),
        settings: settings,
      );

    case panamaHome:
      return MaterialPageRoute(
        builder: (context) => const PanamaHome(),
        settings: settings,
      );
    case independentStudentIdentificationRoute:
      return MaterialPageRoute(
        builder: (context) => const StudentIdentificationPage(),
        settings: settings,
      );
    case purchaseSummary:
      return MaterialPageRoute(
        builder: (context) => const PurchaseSummaryPage(),
        settings: settings,
      );
    case menuRoute:
      return MaterialPageRoute(
        builder: (context) => const MenuPreviewPage(),
        settings: settings,
      );

    case multisaleRoute:
      return MaterialPageRoute(
        builder: (context) => const MultisaleChildrenPage(),
        settings: settings,
      );
    case multisaleCalendarRoute:
      return MaterialPageRoute(
        builder: (context) => const MultisaleCalendar(),
        settings: settings,
      );

    case multisalePageRoute:
      return MaterialPageRoute(
        builder: (context) => const MultisalePage(),
        settings: settings,
      );
    case topUpBalanceRoute:
      return MaterialPageRoute(
        builder: (context) => const TopUpBalancePage(),
        settings: settings,
      );
    case topUpOpenpayRoute:
      return MaterialPageRoute(
        builder: (context) => const TopUpOpenPayPage(),
        settings: settings,
      );
    case topUpOpenpayStatusRoute:
      return MaterialPageRoute(
        builder: (context) => const OpenpayRechargeStatus(),
        settings: settings,
      );

    case membershipPaymentSuccess:
      return MaterialPageRoute(
        builder: (context) => const MembershipSuccessPage(),
        settings: settings,
      );
    case mercadoPagoPage:
      return MaterialPageRoute(
        builder: (context) => const MercadoPagoPage(),
        settings: settings,
      );
    case openPay3dSecureRoute:
      return MaterialPageRoute(
        builder: (context) => const OpenPayConfirmationPage(),
        settings: settings,
      );
    case successfulSaleRoute:
      return MaterialPageRoute(
        builder: (context) => const SuccessfulSalePage(),
        settings: settings,
      );
    case successfulSaleIndependentSaleRoute:
      return MaterialPageRoute(
        builder: (context) => const SuccessfulIndependentStudentSalePage(),
        settings: settings,
      );
    case successfulPresaleSaleRoute:
      return MaterialPageRoute(
        builder: (context) => const SuccessfulPreSalePage(),
        settings: settings,
      );
    case childrenRoute:
      return MaterialPageRoute(
        builder: (context) => const ChildrenListPage(),
        settings: settings,
      );
    case childRoute:
      return MaterialPageRoute(
        builder: (context) => const ChildPage(),
        settings: settings,
      );
    case forbiddenProductsRoute:
      return MaterialPageRoute(
        builder: (context) => const ForbiddenProductsPage(),
        settings: settings,
      );
    case limitedProductsRoute:
      return MaterialPageRoute(
        builder: (context) => const LimitedProductsPage(),
        settings: settings,
      );
    case debtorsChildrenRoute:
      return MaterialPageRoute(
        builder: (context) => const DebtorsChildrenPage(),
        settings: settings,
      );
    case settingsRoute:
      return MaterialPageRoute(
        builder: (context) => const SettingsPage(),
        settings: settings,
      );
    case accountRoute:
      return MaterialPageRoute(
        builder: (context) => const AccountPage(),
        settings: settings,
      );
    case changeTutorPasswordRoute:
      return MaterialPageRoute(
        builder: (context) => const ChangePasswordPage(),
        settings: settings,
      );
    case initialRoute:
    case loginRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
        settings: settings,
      );
    case sucessfulPasswordRecoveryRoute:
      return MaterialPageRoute(
        builder: (context) => const SucessfulPasswordRecoveryPage(),
        settings: settings,
      );
    case historyRoute:
      return MaterialPageRoute(
        builder: (context) => const HistoryPage(),
        settings: settings,
      );

    case promotionsRoute:
      return MaterialPageRoute(
        builder: (context) => const PromotionsPage(),
        settings: settings,
      );
    case topUpRoute:
      return MaterialPageRoute(
        builder: (context) => const TopUpPage(),
        settings: settings,
      );

    case yappyTopUpStatuspStatus:
      return MaterialPageRoute(
        builder: (context) => YappyTopUpStatus(
          rechargeStatus: rechargeStatus,
          yappyId: yappyId,
        ),
        settings: settings,
      );

    case checkAuthRoute:
      return MaterialPageRoute(
        builder: (context) => const CheckAuthPage(),
        settings: settings,
      );
    case restorePasswordRoute:
      return MaterialPageRoute(
        builder: (context) => const RestorePasswordPage(),
        settings: settings,
      );
    case verificationCodeRoute:
      return MaterialPageRoute(
        builder: (context) => const VerificationCodePage(),
        settings: settings,
      );
    case confirmNewPasswordRoute:
      return MaterialPageRoute(
        builder: (context) => const ConfirmNewPasswordPage(),
        settings: settings,
      );
    case couponListRoute:
      return MaterialPageRoute(
        builder: (context) => const CouponListPage(),
        settings: settings,
      );
    case couponDetailsRoute:
      return MaterialPageRoute(
        builder: (context) => const CouponDetailsPage(),
        settings: settings,
      );
    case cardsRoute:
      return MaterialPageRoute(
        builder: (context) => const CardsListPage(),
        settings: settings,
      );

    case croemCardsRoute:
      return MaterialPageRoute(
        builder: (context) => const CroemCardsListPage(),
        settings: settings,
      );

    case yappySuccess:
      return MaterialPageRoute(
        builder: (context) => const YappyPaymentSuccess(),
        settings: settings,
      );

    case yappyError:
      return MaterialPageRoute(
        builder: (context) => const YappyPaymentError(),
        settings: settings,
      );

    case multisaleSuccessPage:
      return MaterialPageRoute(
        builder: (context) => const MultisaleSuccessPage(),
        settings: settings,
      );

    case membershipPaymentSuccess:
      return MaterialPageRoute(
        builder: (context) => const MultisaleSuccessPage(),
        settings: settings,
      );

    case selectCardToPaySale:
      return MaterialPageRoute(
        builder: (context) => const SelectCardToPaySalePage(),
        settings: settings,
      );
    case registerCardRoute:
      return MaterialPageRoute(
        builder: (context) => const RegisterCardPage(),
        settings: settings,
      );
    case saleRoute:
      return MaterialPageRoute(
        builder: (context) => const SalePage(),
        settings: settings,
      );
    case privacityPolicy:
      return MaterialPageRoute(
        builder: (context) => const PrivacityPolicy(),
        settings: settings,
      );
    case termsAndCondition:
      return MaterialPageRoute(
        builder: (context) => const TermsAndConditions(),
        settings: settings,
      );

    case createCroemCardRoute:
      return MaterialPageRoute(
        builder: (context) => const CroemPage(),
        settings: settings,
      );

    case topUpCroemRoute:
      return MaterialPageRoute(
        builder: (context) => const TopUpCroemPage(),
        settings: settings,
      );

    case panamaPaymentMethod:
      return MaterialPageRoute(
        builder: (context) => const PanamaPaymentMethod(),
        settings: settings,
      );

    case panamaSummarySale:
      return MaterialPageRoute(
        builder: (context) => const PanamaPurchaseSummaryPage(),
        settings: settings,
      );
    case panamaMembershipDeptors:
      return MaterialPageRoute(
        builder: (context) => const PanamaMembershipDebtors(),
        settings: settings,
      );

    case payMembership:
      return MaterialPageRoute(
        builder: (context) => const PanamaPaymentMethodMembership(),
        settings: settings,
      );



      case mercadoPagoStatusRoute:
      return MaterialPageRoute(
        builder: (context) =>  MercadoPagoTopUpStatusPage(rechargeStatus: rechargeStatus, mercadoPagoId: "", paymentId: paymentId , merchantOrderId:  merchantOrderId, externalReference: externalReference),
        settings: settings,
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
        settings: settings,
      );
  }
}

Map<String, String> getQueryParams(String url) {
  Uri uri = Uri.parse(url);

  // Obtiene los parámetros de la consulta como un mapa
  Map<String, String> queryParams = uri.queryParameters;

  return queryParams;
}
