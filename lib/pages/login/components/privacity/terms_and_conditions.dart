import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:vector_graphics/vector_graphics.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: const SvgPicture(
                    AssetBytesLoader(images.appBarShortImg),
                    semanticsLabel: "App bar",
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 110,
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 25,),
                    const Align(
                      alignment: Alignment.center,
                      child: Text("TERMINOS Y CONDICIONES", style: TextStyle(fontSize: 17, color: Colors.white, fontFamily: "Comfortaa"),),
                    )
                  ],
                )
              ],
            ),
            formatText(
                "Es requisito necesario para la adquisición de los servicios que se ofrecen en este sitio, que lea y acepte los siguientes Términos y Condiciones que a continuación se redactan. El uso de nuestros servicios implicará que usted ha leído y aceptado los Términos y Condiciones de Uso en el presente documento. Todas los servicios que son ofrecidos por nuestro sitio web pudieran ser creadas, cobradas, enviadas o presentadas por una página web tercera y en tal caso estarían sujetas a sus propios Términos y Condiciones",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "En algunos casos, para adquirir un servicio, será necesario el registro por parte del usuario, con ingreso de datos personales fidedignos y definición de una contraseña.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "El usuario puede elegir y cambiar la clave para su acceso de administración de la cuenta en cualquier momento, en caso de que se haya registrado y que sea necesario para la solicitud de alguno de nuestros servicios. smart lunch no asume la responsabilidad en caso de que entregue dicha clave a terceros.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Todas las compras y transacciones que se lleven a cabo por medio de este sitio web, están sujetas a un proceso de confirmación y verificación, el cual podría incluir la verificación y disponibilidad de producto, validación de la forma de pago, validación de la factura (en caso de existir) y el cumplimiento de las condiciones requeridas por el medio de pago seleccionado.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "En algunos casos puede que se requiera una verificación por medio de correo electrónico. Los precios de los servicios ofrecidos en este Sitio Web es válido solamente en las compras realizadas en este sitio web.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "LICENCIA",
                20,
                FontWeight.bold,
                TextAlign.center),
            formatText(
                "smart lunch a través de su sitio web concede una licencia específica por un lapso de tiempo definido para que los usuarios utilicen los servicios con el fin de lograr la acreditación de acuerdo a los Términos y Condiciones que se describen en este documento.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "PROPIEDAD",
                20,
                FontWeight.bold,
                TextAlign.center),
            formatText(
                "Usted no puede declarar propiedad intelectual o exclusiva a ninguno de nuestros productos, modificado o sin modificar. Todos los servicios son propiedad de los proveedores del contenido. En caso de que no se especifique lo contrario, nuestros servicios se proporcionan sin ningún tipo de garantía, expresa o implícita. En ningún momento esta compañía será responsable de ningún daño incluyendo, pero no limitado a, daños directos, indirectos, especiales, fortuitos o consecuentes u otras pérdidas resultantes del uso o de la imposibilidad de utilizar nuestros servicios.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "REEMBOLSO Y GARANTÍA",
                20,
                FontWeight.bold,
                TextAlign.justify),
            formatText("Una vez concluido el servicio solicitado, no realizamos reembolsos después de que se envíen los resultados, usted tiene la responsabilidad de entender antes de solicitarlo. Le pedimos que lea cuidadosamente antes de solicitarlo. Hacemos solamente excepciones con esta regla cuando la descripción no se ajusta al servicio prestado.", 14, FontWeight.normal,
                TextAlign.justify
                
                ),
            formatText(
                "PRIVACIDAD",
                20,
                FontWeight.bold,
                TextAlign.center),
            formatText(
                "smart lunch garantiza que la información personal que usted envía cuenta con la seguridad necesaria. Puede revisar más a detalle en nuestra POLÍTICA DE PRIVACIDAD",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "smart lunch utiliza Openpay como paserla de pago para realizar las transacciones dentro de la plataforma.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "smart lunch se reserva los derechos de cambiar o de modificar estos términos sin previo aviso.",
                14,
                FontWeight.normal,
                TextAlign.justify),
          ],
        ),
      ),
    );
  }

  Widget formatText(String text, double fontSize, FontWeight fontWeight,
      TextAlign textAlign) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        text,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: "Comfortaa"),
        textAlign: textAlign,
      ),
    );
  }
}
