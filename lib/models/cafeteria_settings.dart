import 'dart:convert';
import 'dart:developer' as developer;

List<CafeteriaSetting> cafeteriaSettingFromJson(String str) =>
    List<CafeteriaSetting>.from(
        json.decode(str).map((x) => CafeteriaSetting.fromJson(x)));

class CafeteriaSetting {
  CafeteriaSetting({
    required this.mobileSales,
    required this.surchargeSale,
    required this.visibleMenu,
    required this.presales,
    required this.cafeHours,
    required this.comanda,
    required this.cashRecharge,
    required this.cashSales,
    required this.openpayRecharge,
    required this.chargeOpenpayRecharge,
    required this.minimunOpenPayRechargeValue,
    required this.creditLimit,
    required this.inventoryControl,
    required this.startTime,
    required this.endTime,
    required this.surchargeSaleType,
    required this.surchargeSaleAmount,
    required this.mercadoPagoEnabled,
    required this.minimumRechargeEnabled,
    required this.minimumRechargeAmount,
    required this.chargeCommissionToParents,
    required this.chargeCommissionToParentsAmount,
    required this.minimumRechargeNoCommission,
    required this.minimumRechargeNoCommissionAmount,
  });

  bool mobileSales;
  bool surchargeSale;
  bool visibleMenu;
  bool presales;
  bool cafeHours;
  bool comanda;
  bool cashRecharge;
  bool cashSales;
  bool openpayRecharge;
  bool chargeOpenpayRecharge;
  int minimunOpenPayRechargeValue;
  bool creditLimit;
  bool inventoryControl;
  String startTime;
  String endTime;
  String surchargeSaleType;
  int surchargeSaleAmount;
  bool mercadoPagoEnabled;
  bool minimumRechargeEnabled;
  int minimumRechargeAmount;
  bool chargeCommissionToParents;
  double chargeCommissionToParentsAmount;
  bool minimumRechargeNoCommission;
  int minimumRechargeNoCommissionAmount;

  factory CafeteriaSetting.fromJson(List<dynamic> json) {
    // Variables temporales
    bool mobileSalesValue = false;
    bool surchargeSaleValue = false;
    bool visibleMenuValue = false;
    bool presalesValue = false;
    bool cafeHoursValue = false;
    bool comandaValue = false;
    bool cashRechargeValue = false;
    bool cashSaleValue = false;
    bool openpayValue = false;
    bool chargeOpenpayRecharge = false;
    int minimunOpenPayRecharge = 0;
    bool creditLimitValue = false;
    bool inventoryValue = false;
    String startTimeValue = '';
    String endTimeValue = '';
    String surchargeSaleTypeValue = '';
    int surchargeSaleAmountValue = 0;
    bool mercadoPagoEnabledValue = false;
    bool minimumRechargeEnabledValue = false;
    int minimumRechargeAmountValue = 0;
    bool chargeCommissionToParentsValue = false;
    double chargeCommissionToParentsAmountValue = 0.0;
    bool minimumRechargeNoCommissionValue = false;
    int minimumRechargeNoCommissionAmountValue = 0;

    for (var element in json) {
      if (element is Map<String, dynamic>) {
        final key = element['key'];
        final value = element['value'];

        switch (key) {
          case 'MOBILE_SALES':
            mobileSalesValue = value['ENABLE'] ?? false;
            break;

          case 'SURCHARGE_SALE':
            surchargeSaleValue = value['ENABLE'] ?? false;
            surchargeSaleAmountValue =
                (value['VALUE'] ?? 0).toInt(); // fuerza int
            surchargeSaleTypeValue = value['TYPE'] ?? '';
            break;

          case 'VISIBLE_MENU':
            visibleMenuValue = value['ENABLE'] ?? false;
            break;

          case 'PRESALES':
            presalesValue = value['ENABLE'] ?? false;
            break;

          case 'CAFE_HOURS':
            cafeHoursValue = value['ENABLE'] ?? false;
            startTimeValue = value['START_TIME'] ?? '';
            endTimeValue = value['END_TIME'] ?? '';
            break;

          case 'COMANDA':
            comandaValue = value['ENABLE'] ?? false;
            break;

          case 'CASH_RECHARGE':
            cashRechargeValue = value['ENABLE'] ?? false;
            break;

          case 'CASH_SALES':
            cashSaleValue = value['ENABLE'] ?? false;
            break;

          case 'OPENPAY_RECHARGE':
          print("Charge Openpay Recharge Value: ${value['CHARGE_COMMISSION'] }");
            openpayValue = value['ENABLE'] ?? false;
            minimunOpenPayRecharge =
                (value['MIN_VALUE'] ?? 0).toInt();
            chargeOpenpayRecharge = value['CHARGE_COMMISSION'] ?? false;
            break;

          case 'CREDIT_LIMIT':
            creditLimitValue = value['ENABLE'] ?? false;
            break;

          case 'INVENTORY_CONTROL':
            inventoryValue = value['ENABLE'] ?? false;
            break;

          case 'MERCADO_PAGO_SETTINGS':
            mercadoPagoEnabledValue = value['ENABLE'] ?? false;
            minimumRechargeEnabledValue =
                value['MINIMUM_RECHARGE']?['ENABLE'] ?? false;
            minimumRechargeAmountValue =
                (value['MINIMUM_RECHARGE']?['MINIMUM_RECHARGE_AMOUNT'] ?? 0)
                    .toInt();

            chargeCommissionToParentsValue =
                value['CHARGE_COMMISSION_TO_PARENTS']?['ENABLE'] ?? false;

            final commissionAmount =
                value['CHARGE_COMMISSION_TO_PARENTS']?['COMMISSION_AMOUNT'] ?? 0;
            // fuerza a double
            chargeCommissionToParentsAmountValue = (commissionAmount is int)
                ? commissionAmount.toDouble()
                : commissionAmount as double? ?? 0.0;

            minimumRechargeNoCommissionValue =
                value['MINIMUM_RECHARGE_FOR_NO_COMMISSION']?['ENABLE'] ?? false;
            minimumRechargeNoCommissionAmountValue = (value[
                        'MINIMUM_RECHARGE_FOR_NO_COMMISSION']
                    ?['MINIMUM_RECHARGE_FOR_NO_COMMISSION_AMOUNT'] ??
                0)
                .toInt();
            break;

          default:
            break;
        }
      }
    }

    return CafeteriaSetting(
      mobileSales: mobileSalesValue,
      surchargeSale: surchargeSaleValue,
      visibleMenu: visibleMenuValue,
      presales: presalesValue,
      cafeHours: cafeHoursValue,
      comanda: comandaValue,
      cashRecharge: cashRechargeValue,
      cashSales: cashSaleValue,
      openpayRecharge: openpayValue,
      chargeOpenpayRecharge: chargeOpenpayRecharge,
      minimunOpenPayRechargeValue: minimunOpenPayRecharge,
      creditLimit: creditLimitValue,
      inventoryControl: inventoryValue,
      startTime: startTimeValue,
      endTime: endTimeValue,
      surchargeSaleAmount: surchargeSaleAmountValue,
      surchargeSaleType: surchargeSaleTypeValue,
      mercadoPagoEnabled: mercadoPagoEnabledValue,
      minimumRechargeEnabled: minimumRechargeEnabledValue,
      minimumRechargeAmount: minimumRechargeAmountValue,
      chargeCommissionToParents: chargeCommissionToParentsValue,
      chargeCommissionToParentsAmount: chargeCommissionToParentsAmountValue,
      minimumRechargeNoCommission: minimumRechargeNoCommissionValue,
      minimumRechargeNoCommissionAmount: minimumRechargeNoCommissionAmountValue,
    );
  }
}
