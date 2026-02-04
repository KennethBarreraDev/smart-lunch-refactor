class SuccessfulRecharge {
  SuccessfulRecharge({
    required this.folio,
    required this.transactionId,
    required this.rechargeStatus,
    required this.amount,
    required this.platform
  });

  final String folio;
  final String transactionId;
  final String rechargeStatus;
  final String amount;
  final String platform;
}
