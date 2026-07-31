import 'package:smart_lunch/common_providers/common_providers.dart';
import 'package:smart_lunch/pages/cards_info/croem/cards_croem_info_provider.dart';
import 'package:smart_lunch/pages/cards_info/open_pay/cards_info_provider.dart';
import 'package:smart_lunch/pages/home/home_provider.dart';
import 'package:smart_lunch/utils/allowed_countries.dart';
import 'package:smart_lunch/utils/roles.dart';

/// Datos normalizados de la tarjeta no importa si el proveedor ya sea
/// [CardsCroemProvider] (Panamá) o [CardsInfoProvider] (OpenPay)

class SelectedCardData {
  const SelectedCardData({
    required this.holderName,
    required this.cardNumber,
    required this.brand,
    required this.isPanamaTutor,
  });

  final String holderName;
  final String cardNumber;
  final String brand;
  final bool isPanamaTutor;
}

/// Formatea el número de tarjeta para mostrarlo, respetando la convención
/// existente: Croem/Panamá lo muestra completo, OpenPay lo enmascara.
String formatCardNumberDisplay(String cardNumber, bool isPanamaTutor) {
  return isPanamaTutor ? " $cardNumber" : "●●●● $cardNumber";
}

/// True cuando el usuario activo debe operar sobre [CardsCroemProvider]
/// (tutores en Panamá) en lugar de [CardsInfoProvider] (OpenPay).
bool isPanamaTutorContext(MainProvider mainProvider, HomeProvider homeProvider) {
  return mainProvider.userType == UserRole.tutor &&
      (homeProvider.cafeteria?.school.country ?? "") == Contries.panama;
}

/// Actualiza la tarjeta seleccionada para pago en el proveedor que
/// corresponda según el contexto (Croem o OpenPay).
void updateSaleCardOnActiveProvider({
  required bool isPanamaTutor,
  required CardsCroemProvider cardsCroemProvider,
  required CardsInfoProvider cardsInfoProvider,
  required String cardId,
  required int internalId,
}) {
  if (isPanamaTutor) {
    cardsCroemProvider.updateSaleCard(cardId, internalId);
  } else {
    cardsInfoProvider.updateSaleCard(cardId, internalId);
  }
}

/// Datos normalizados de la tarjeta marcada como `selectedCardForTopUp` en
/// el proveedor activo (Croem u OpenPay).
SelectedCardData resolveSelectedCardForTopUp({
  required CardsCroemProvider cardsCroemProvider,
  required CardsInfoProvider cardsInfoProvider,
  required MainProvider mainProvider,
  required HomeProvider homeProvider,
}) {
  final isPanamaTutor = isPanamaTutorContext(mainProvider, homeProvider);

  if (isPanamaTutor) {
    final card = cardsCroemProvider.selectedCardForTopUp;
    return SelectedCardData(
      holderName: card?.cardHolderName ?? "",
      cardNumber: card?.cardNumber ?? "",
      brand: cardsCroemProvider.getCardBrand(card?.cardNumber ?? ""),
      isPanamaTutor: true,
    );
  }

  final card = cardsInfoProvider.selectedCardForTopUp;
  return SelectedCardData(
    holderName: card?.holderName ?? "",
    cardNumber: card?.cardNumber ?? "",
    brand: card?.brand ?? "",
    isPanamaTutor: false,
  );
}
