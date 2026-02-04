const String appBarLongImg = "assets/img/appBarLong.svg.vec";
const String appBarLongGreen = "assets/img/appBarLongGreen.svg";

const String appBarShortImg = "assets/img/appBarShort.svg.vec";
const String discountsImg = "assets/img/discounts.svg.vec";
const String paymentsModalImg = "assets/img/paymentModal.svg.vec";
const String cardImg = "assets/img/cardImage.svg.vec";
const String logoImg = "assets/img/logo.svg.vec";
const String loginImg = "assets/img/loginImg.svg.vec";
const String bottomWave = "assets/img/bottomWave.svg.vec";
const String whiteLogo = "assets/img/whiteLogo.svg.vec";
const String loginBackground = "assets/img/loginBackground.jpg";
const String successfulSale = "assets/img/successfulSale.vec.svg";
const String deleteCardModal = "assets/img/deleteCardModal.svg.vec";
const String confirmRechargeAmountIcon = "assets/img/confirmAmount.png";
const String pickSaleDateLogo = "assets/img/pickDateLogo.png";
const String noResultsLogo = "assets/img/noResults.png";

const String emailVerification = "assets/img/email_verification.png";

const String defaultProfileImage = "assets/img/defaultProfileImage.jpg";
const String defaultProductImage = "assets/img/defaultProductImage.png";
const String defaultProfileStudentImage = "assets/img/defaultStudentImage.png";
const String itemPlaceholderImage = "assets/img/itemPlaceholderImage.png";
const String successfulSaleImage = "assets/img/successfulSaleImage.svg.vec";


const String updateAppImage = "assets/img/update-app.png";

const String mastercardLogo = "assets/img/mastercardLogo.png";
const String americanExpressLogo = "assets/img/americanExpress.png";
const String bancoAztecaLogo = "assets/img/bancoAzteca.png";
const String bbvaLogo = "assets/img/bbva.png";
const String carnetLogo = "assets/img/carnet.png";
const String citibanamexLogo = "assets/img/citibanamex.png";
const String inbursaLogo = "assets/img/inbursa.png";
const String masterCardText = "assets/img/mastercardText.png";
const String openpayColor = "assets/img/openpayColor.png";
const String openpayWhite = "assets/img/openpayWhite.png";
const String santanderLogo = "assets/img/santander.png";
const String scotiabankLogo = "assets/img/scotiabank.png";
const String visaLogo = "assets/img/visa.png";



const String openpayLogo = "assets/img/openpay_banner.png";
const String supportLogo = "assets/img/support_banner.png";


const String croemLogo = "assets/img/croem_logo.png";
const String croemSupport = "assets/img/Croem_support.png";


const String successRecharge = "assets/img/successRecharge.svg";
const String errorRecharge = "assets/img/errorRecharge.svg";


const String dishIcon = "assets/img/dish_icon.png";
const String clockIcon = "assets/img/clock_icon.png";


const String panamaSale = "assets/img/panama_sale.png";
const String panamaPresale = "assets/img/panama_presale.png";
const String panama_multisale = "assets/img/panama_multisale.png";


const String smartLunchIcon = "assets/img/smartlunchlogo.png";

const String yappiImage = "assets/img/yappi.png";

const String supportImage = "assets/img/support_agent.png";


const String membershipDebt = "assets/img/membership_payment.png";

const String mercadoPagoLogo = "assets/img/mercado_pago.png";



String getCardBrandImage(String brand) {
  switch (brand) {
    case "mastercard":
      return mastercardLogo;
    case "visa":
      return visaLogo;
    case "american_express":
      return americanExpressLogo;
    default:
      return visaLogo;
  }
}
