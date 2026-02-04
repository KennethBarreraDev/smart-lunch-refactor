class SuccessfulSaleArguments {
  SuccessfulSaleArguments({
    required this.total,
    required this.folio,
    required this.saleDate,
    required this.paymentType,
    required this.mercadoPagoID,
    required this.childName,
    required this.childLastName,
    required this.productsAmount,
    required this.surchargeSaleAmount,
    required this.surchargeSaleType,
    required this.surchargeSaleActivated,
    required this.scheduledDate
  });

  final double total;
  final String folio;
  final String saleDate;
  final String scheduledDate;
  final String paymentType;
  final String mercadoPagoID;
  final String childName;
  final String childLastName;
  final int productsAmount;
  final String surchargeSaleType;
  final int surchargeSaleAmount;
  final bool surchargeSaleActivated;
}