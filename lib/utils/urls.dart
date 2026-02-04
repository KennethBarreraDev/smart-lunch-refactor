
///DEV
//String baseUrl = "https://backend-dev.smartschool.mx/api";

///Production
String baseUrl = "https://backend.smartschool.mx/api";

///Demo
//String baseUrl = "http://backend-demo.smartschool.mx/api";



// Login
String loginUrl = "$baseUrl/core/token/";
String refreshTokenUrl = "$baseUrl/core/token/refresh/";


//Password
String passwordRecoveryUrl = "$baseUrl/core/user/reset_password/";

// Children
String getChildrenUrl = "$baseUrl/smartlunch/student/";
String updateSpendingLimitUrl = "$baseUrl/core/student/";

//Tutor
String getTutorInfoUrl = "$baseUrl/core/tutor/";
String getStudentInfoUrl = "$baseUrl/core/student/";
String createOpenPayCustomerUrl = "$baseUrl/smartlunch/open-pay/customer/";

// Preferences
String updateTutorUrl = "$baseUrl/core/tutor/";
String updateStudentInfo = "$baseUrl/core/student/";
String getCouponsUrl = "$baseUrl/smartschool/deal/";

String updateUser = "$baseUrl/core/user/";

// Products
String getProductsCategoriesUrl = "$baseUrl/smartlunch/category/";
String getProductsUrl = "$baseUrl/smartlunch/product/";

// Allergies
String getAllergiesUrl = "$baseUrl/smartlunch/allergy/";
String updateAllergiesPrefixUrl = "$baseUrl/smartlunch/student/";
String updateAllergiesPostfixUrl = "/allergy/";

// Product restriction
String getProductRestrictionsUrl = "$baseUrl/smartlunch/product_restriction/";
String updateProductRestrictionsPrefixUrl = "$baseUrl/smartlunch/student/";
String updateProductRestrictionsPostfixUrl = "/product_restriction/";

// Home pag
String getCafeteriaInfoUrl = "$baseUrl/smartlunch/cafeteria/";
String getFamilyBalanceUrl = "$baseUrl/core/family/";
String getFamilyDebtorsUrl = "$baseUrl/smartlunch/family/";
String topUpBalanceUrl = "$baseUrl/smartlunch/recharge/";
String confirm3dSecurePrefixUrl = "$baseUrl/smartlunch/cafeteria/";
String confirm3dSecurePostfixUrl = "/three_d_secure/";
String getCafeteriaSettingsUrl = "$baseUrl/smartlunch/settings/";

// Sale page
String sellProductsMobile = "$baseUrl/smartlunch/sale/mobile/";
String sellProducts = "$baseUrl/smartlunch/sale/immediate/";
String multisaleProducts = "$baseUrl/smartlunch/sale/multi_presale/";
String preSellProducts = "$baseUrl/smartlunch/sale/presale/";
String cancelPresale = "$baseUrl/smartlunch/sale/sale_return/";

// History page
String getProductHistoryUrl = "$baseUrl/smartlunch/sale/";
String getRechargeHistoryUrl = "$baseUrl/smartlunch/recharge/";
String payMembership = "$baseUrl/smartlunch/sale/membership/";

// OpenPay
String openPayCredentialsUrl = "$baseUrl/smartlunch/open-pay/credentials/";
String openPayTutorUrl = "$baseUrl/smartlunch/open-pay/customer/";
String openPayTutorCardsUrl = "$baseUrl/smartlunch/open-pay/customer/cards/";
String registerCardUrl = "$baseUrl/smartlunch/open-pay/customer/cards/";

//Croem
String croemCardsUrl = "$baseUrl/core/croem/";


//Recharge via MercadoPago
String rechargeUrl = "$baseUrl/smartlunch/recharge/";
String rechargeDataUrl = "$baseUrl/core/mercadopago/";



//App version
String getAppVersion = "$baseUrl/core/app_version/";