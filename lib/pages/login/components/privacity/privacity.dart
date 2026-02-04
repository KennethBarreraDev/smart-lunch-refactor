import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_lunch/utils/images.dart' as images;
import 'package:vector_graphics/vector_graphics.dart';

class PrivacityPolicy extends StatelessWidget {
  const PrivacityPolicy({super.key});

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
                      child: Text("AVISO DE PRIVACIDAD", style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: "Comfortaa"),),
                    )
                  ],
                )
              ],
            ),
            formatText(
                "MARCO NORMATIVO", 20, FontWeight.bold, TextAlign.center),
            formatText(
                "De conformidad con lo estipulado por la Ley Federal de Protección de Datos Personales en Posesión de los Particulares (en adelante la “Ley”), su Reglamento (denominado como el “Reglamento”) y los Lineamientos del Aviso de Privacidad (en lo sucesivo los “Lineamientos” y conjuntamente con la Ley y el Reglamento, como el “Marco Normativo”), la sociedad mercantil denominada IDEAPP S.A DE C.V , conocida comercialmente como “smart lunch” (denominado en el presente documento como “smart lunch” o “Responsable” indistintamente) emite el presente aviso de privacidad (el “Aviso de Privacidad”) que contiene la política, lineamientos y procedimientos bajos los cuales se recabarán y tratarán los datos personales (los “Datos Personales”) de las personas físicas y/o morales (en adelante los “Titulares”).",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText("OBJETIVO", 20, FontWeight.bold, TextAlign.center),
            formatText(
                "smart lunch realizará el tratamiento de los Datos Personales de dos diferentes tipos de Titulares, por un lado están los Comerciantes, con quien smart lunch tiene una relación contractual directa, por lo que el tratamiento de sus Datos Personales se realizará de conformidad con el Contrato de Prestación de Servicios y Procesamiento de Transacciones mediante el Sistema de Pagos; y por otro lado se encuentran los Clientes Finales, que serán aquellos que pretendan realizar pagos a favor de los Comerciantes a través del Sistema de Pagos, a cambio de bienes y/o servicios que estos les ofrezcan.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "El objetivo del presente Aviso de Privacidad es delimitar los alcances y condiciones generales del tratamiento de los Datos Personales e informarlos a los dos tipos de Titulares, a fin de que estén en posibilidad de tomar decisiones instruidas sobre el uso de sus Datos Personales y mantener el control y disposición de los mismos. De igual forma, el Aviso de Privacidad permite al Responsable transparentar dicho tratamiento y con ello fortalecer el nivel de confianza al prestar sus servicios.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "El presente Aviso de Privacidad es parte integrante de los Términos y Condiciones de smart lunch, por lo que al aceptarse éstos, los Titulares consienten expresamente las disposiciones previstas en el Aviso de Privacidad, para todos los efectos legales a que haya lugar. .",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText("IDENTIDAD Y DOMICILIO DEL RESPONSABLE", 20,
                FontWeight.bold, TextAlign.center),
            formatText(
                "La sociedad mercantil denominada IDEAPP S.A de C.V., conocida comercialmente como “smart lunch” tiene su domicilio ubicado en Av. Paseo de las Palmas 405, Colonia Lomas de Chapultepec I sección, Miguel Hidalgo, Alcaldía Cuauhtémoc, Ciudad de México, C.P. 11000.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText("TRATAMIENTO DE DATOS PERSONALES", 20, FontWeight.bold,
                TextAlign.center),
            formatText(
                "A través del Sistema de Pagos desarrollado por smart lunch se podrá solicitar los siguientes datos, dependiendo de si es un Comercio o su Cliente Final:",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "A. Comercio:Nombre completo, Razón o Denominación Social, C.U.R.P., R.F.C., identificación oficial, giro o actividad económica, Cédula de Identificación Fiscal y/o alta en Hacienda; domicilio fiscal, correo electrónico, número telefónico, información corporativa, nombres de accionistas y/o representantes legales, acta constitutiva de persona moral y asambleas de accionista, documentos notariales; estado de cuenta bancario, clabe interbancaria, datos de tarjetas de débito o crédito, BIN, actividad e historial crediticio, facturación mensual estimada; páginas web, redes sociales, catálogo de productos o servicios ofertados, temporalidad en su operación, elementos de mercadotecnia y logos.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "B. Cliente Final: Nombre completo, correo electrónico, número telefónico, clabe interbancaria, datos de tarjeta de débito o crédito y BIN (en caso de aplicar).",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "A todos los Titulares por igual se les podrá solicitar, adicionalmente su localización geográfica correspondientes a la ubicación y dirección IP del dispositivo electrónico desde donde se accede al Sistema de Pagos desarrollado por smart lunch, identificadores de dispositivos únicos y otra información identificadora similar relacionada con las comunicaciones entre aplicativos.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "A su vez, a todos los Titulares se les informa que el Sistema de Pagos desarrollado por smart lunch utiliza cookies, web beacons y otras tecnologías a través de las cuales es posible monitorear y recopilar datos relacionados con el comportamiento de los Titulares y la manera en la que interactúan en dicho Sistema de Pagos, a fin de brindarle un mejor servicio y experiencia al utilizarla. La información que se recabe a través de dichas tecnologías será utilizada para diversos fines relacionados con los servicios ofertados por smart lunch, así como para sus procesos internos, por lo que a su vez se considerarán como Datos Personales para todos los efectos legales a que haya lugar en el presente Aviso de Privacidad. La información que se obtiene de estas tecnologías de rastreo incluye: identificadores, nombres, contraseñas, idioma preferido, región en la que se encuentra, tipo de navegador, tipo de sistema operativo, fecha y hora de inicio-final de una sesión, páginas web visitadas, búsquedas realizadas, publicidad revisada, listas y hábitos de consumo en las páginas de compra, direcciones IP, entre otros similares.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Para el cumplimiento de este apartado, con fundamento en el artículo 22 de los Lineamientos, el Responsable podrá solicitar y almacenar los Datos Personales para los siguientes fines: (i) brindar a los Titulares los servicios de procesamiento de transacciones a través del Sistema de Pago; (ii) brindar a los Comerciantes los servicios de representación en procesos de contracargos y soporte; (iii) permitir a terceros entidades financieras y participantes en la Red de Medios de Disposición, entre otros actores dentro del medio financiero la obtención, utilización y tratamiento de los Datos Personales de los Titulares para el estricto cumplimiento de todas las operaciones que los Titulares realicen en el Sistema de Pagos; (iv) realizar actividades de prevención de fraude con relación a los patrones de comportamiento, utilización del Sistema de Pagos, preferencias de cobro, entre otras, cuyo fin podrá ser la transferencia de los Datos Personales de los Titulares a empresas con quienes el Responsable tenga una relación de servicios; (v) realizar actividades de análisis de mercado, campañas de promoción, mercadeo e inteligencia comercial con base a la transaccionalidad de los Titulares a efecto de proporcionarles un servicio de procesamiento de transacciones personalizado, ajustado a sus intereses, así como para desarrollar nuevos servicios; (vi) almacenamiento de información concentrada para la elaboración de una base de datos sólida que permita a smart lunch tener mayor información estadística sobre el procesamiento de pagos; (vii) cumplir con las obligaciones legales y regulatorias impuestas al Responsable sobre los servicios ofertados a sus Titulares, y (viii) apersonarse en cualquier procedimiento jurisdiccional para el ejercicio o defensa de sus derechos o los derechos de terceros con los que guarda estrecha relación.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText("PROTECCIÓN DE DATOS PERSONALES", 20, FontWeight.bold,
                TextAlign.center),
            formatText(
                "El Responsable tratará los Datos Personales con total privacidad, de manera lícita de conformidad con el Marco Normativo y con la única finalidad de prestar los servicios propios del Sistema de Pago a los Titulares. Los Datos Personales serán conservados durante todo el tiempo necesario para la prestación de los servicios correspondientes, así como para el cumplimiento de las obligaciones que el Responsable mantenga con relación a los Datos Personales de los Titulares, por tal motivo se reserva el derecho de requerir actualizaciones sobre tales datos mientras las relaciones jurídicas se encuentren vigentes. Asimismo, se hace del conocimiento expreso de los Comerciantes que la información recabada deberá ser resguardada por smart lunch durante la vigencia del Contrato de Prestación de Servicios para el Procesamiento de Transacciones de Pago suscrito y hasta por diez (10) años después de la recisión o terminación de dicho Contrato. Lo anterior en atención a las obligaciones que tiene smart lunch en su carácter de Agregador ante los Bancos Adquirentes y las autoridades del sistema de pagos mexicano, no obstante, el Comercio tiene la facultad de solicitar sus derechos ARCO conforme al numeral séptimo de este Aviso de Privacidad.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "En todo momento smart lunch se sujetará al Marco Normativo para la protección de los Datos Personales durante y después del tratamiento de los mismo conforme al numeral anterior.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Se hace del conocimiento expreso a los Titulares (especialmente los Clientes Finales) que los datos relacionados con las tarjetas de débito o crédito, así como el BIN de las mismas, los cuales serán requeridos para realizar transacciones en el Sistema de Pagos, no serán transmitidos, utilizados ni almacenados por ningún medio ni sistema de smart lunch, lo cual asegura los mayores índices de protección y seguridad a los Titulares. Adicionalmente, se hace del conocimiento que smart lunch cuenta con las certificaciones necesarias, a nivel nacional e internacional, para realizar un tratamiento lícito y seguro de dichos datos.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "El Responsable utilizará las medidas administrativas, tecnológicas, técnicas y físicas de seguridad que permitan proteger los Datos Personales contra daño, pérdida, alteración, destrucción o el uso, acceso o tratamiento no autorizado. smart lunch ha tomado precauciones para garantizar la integridad y seguridad de los Datos Personales.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "En virtud de que el Responsable utiliza mecanismos de tecnologías de la información e Internet, se hace del conocimiento de los Titulares de Datos Personales que ninguna comunicación de datos es totalmente segura, pues siempre existe la posibilidad de que sean vulnerados por agentes externos con la intención afectar su funcionamiento o seguridad. En tal virtud, se somete a su consideración el riesgo existente por lo que hace al tratamiento y almacenamiento de los Datos Personales realizados por el Responsable en términos del presente Aviso de Privacidad.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText("TRANSFERENCIAS DE DATOS PERSONALES", 20,
                FontWeight.bold, TextAlign.center),
            formatText(
                "El tratamiento que el Responsable hace de los Datos Personales puede involucrar su transferencia a diversos proveedores, subcontratistas, subsidiarias, afiliadas, comisionistas u otras personas que se encuentren relacionadas con el Responsable, con quienes tendrá celebrados acuerdos de confidencialidad y de protección de Datos Personales, dándoles a conocer el presente Aviso de Privacidad a fin de seguir el cumplimiento de lo señalado por el Marco Normativo y bajo el entendido de que solo se les permitirá el acceso a los Datos Personales para cumplir con las finalidades por las cuales se relacionan jurídicamente con el Responsable. Los Datos Personales son compartidos, transferidos o remitidos con personas físicas y morales para los siguientes fines:",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText("DESTINATARIO DE LOS DATOS PERSONALES", 14,
                FontWeight.normal, TextAlign.justify),
            formatText(
                "Empresas de prestación de servicios para la validación de identidad, prevención de fraude, análisis de antecedentes, control de riesgos, entre otros. FINALIDAD",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "La tercerización de ciertos procesos auxiliares en el Sistema de Pagos desarrollado por smart lunch permite un mayor margen de amplitud para la prevención del fraude y control de riesgos, como lo es el sistema de machine learning, entre otros aplicativos utilizados por CashBrain. También incluye la prevención, detección y solución de irregularidades y/o comportamientos fraudulentos que buscan crear un entorno digital seguro y confiable para los Clientes Finales.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Empresas, Sociedades o Entidades participantes de la Red de Medios de Disposición.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Todas las operaciones de pago de bienes y/o servicios, así como las transferencias electrónicas, implican la intervención de empresas, sociedades o entidades participantes de la Red de Medios de Disposición. Estas entidades habilitan servidores y herramientas digitales para tratar y procesar los datos financieros de los Titulares con altos estándares de seguridad, por lo que ninguno de los datos financieros ingresados por los Clientes Finales pasa, utilizan, aprovechan, ni son tratados o almacenados de forma alguna por smart lunch. BASE DE DATOS.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Para el correcto funcionamiento del Sistema de Pagos desarrollada por smart lunch, se requiere el alojamiento de los Datos Personales del Titulares. EMPRESAS DE DESARROLLO DE SOFTWARE.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "El Sistema de Pagos desarrollado por smart lunch en ocasiones requieren de terceros que implementan actualizaciones, elementos, procesos o cualquier tecnología de última generación que permitan mejorar la experiencia de los Titulares. EMPRESAS DE MERCADOTECNIA, PUBLICIDAD Y PROSPECCIÓN.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "A efecto de generar estrategias, prospecciones, estadísticas, análisis de mercado o cualquier otro estudio que habilite smart lunch para generar herramientas publicitarias o de mercadeo efectivas.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText("PROCESOS DE KYC (KNOW YOUR COSTUMER)", 14,
                FontWeight.normal, TextAlign.justify),
            formatText(
                "Derivado de las obligaciones regulatorias del Responsable en su carácter de Agregador, resulta necesario solicitar datos, documentos y demás información a los Comercios para poder otorgar el servicio de procesamiento de pagos.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Las personas, autoridades y demás entidades que se puedan ver relacionadas en la transferencia de los Datos Personales, asumen todas las obligaciones previstas en este Aviso de Privacidad.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Adicionalmente se hace del conocimiento del Titular que los terceros mencionados no tienen permitido el uso de la información personal para sus propios fines, y sólo pueden tratarlos conforme a las instrucciones que smart lunch señale a través de los mencionados convenios de confidencialidad. Como política interna, se requiere que los terceros adopten medidas de seguridad consistentes con las protecciones especificadas en este Aviso de Privacidad y conforme al Marco Normativo.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "MEDIOS Y PROCEDIMIENTO PARA EL EJERCICIO DE LOS DERECHOS DE ACCESO, RECTIFICACIÓN CANCELACIÓN U OPOSICIÓN",
                20,
                FontWeight.bold,
                TextAlign.center),
            formatText(
                "El Titular, por su propio derecho o a través de su representante legal, podrá solicitarle al Responsable en cualquier momento el acceso, rectificación, cancelación u oposición (“Derechos ARCO”) respecto a los Datos Personales que le conciernen.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "El Titular podrá realizar un primer contacto con el área de Atención al Cliente, la cual ya tiene protocolos para analizar las necesidades de los Clientes Finales de smart lunch y remitirlos, caso por caso al Departamento de Protección de Datos Personales, ya sea para que reciban asesoría o ejerzan sus Derechos ARCO. En caso de que el Titular desee ejercer sus Derechos ARCO, éste se podrá comunicar directamente con el Departamento de Protección de Datos Personales a través de correo electrónico info@smartlunch.mx para obtener los requisitos necesarios que le permitan realizar una solicitud formal.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Una vez recibido el correo electrónico del Titular, el Departamento de Protección de Datos podrá emitir la asesoría solicitada y ofrecer los requisitos de la solicitud formal; los requisitos de la solicitud formal serán siempre los siguientes:",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "a. Nombre del Titular y del usuario registrado en los sistemas de smart lunch;",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "b. Foto, escáner o copia del documento de identificación del Titular o, en su caso, tratándose del representante del Titular, además de lo anterior (identificación del Titular) los documentos que acrediten la identidad del representante, así como el instrumento público o carta poder firmada ante dos testigos, en el que consten las facultades otorgadas por el Titular;",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "c. Descripción específica de los Datos Personales respecto de los que se busca ejercer alguno de los Derechos ARCO, y",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "d. Descripción de los medios o métodos por los cuales el Responsable recopiló los Datos Personales del Titular sobre los cuales desea ejercer sus Derechos ARCO.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "En caso de que el Titular desee ejercer sus Derechos ARCO, el Departamento de Protección de Datos Personales estará obligado a asesorarlo previamente para que tenga mayores herramientas para redactar la solicitud formal y garantizar el ejercicio de sus derechos en términos de la Ley y demás disposiciones aplicables.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "El Responsable a través del Departamento de Protección de Datos Personales comunicará al Titular en un plazo máximo de veinte (20) días naturales contados desde la fecha en que se haya recibido la solicitud del Derecho ARCO que corresponda, la determinación adoptada a efecto de que, si resulta procedente, se haga efectiva la misma dentro de los quince (15) días siguientes a la fecha en que se comunique la respuesta. El plazo podrá ser ampliado por una sola vez por un periodo igual, siempre que el Departamento de Protección de Datos Personales le justifique la ampliación al Titular, lo cual deberá ser notificado dentro del mismo plazo.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "El plazo señalado en el párrafo anterior se interrumpirá en caso de que el Departamento de Protección de Datos Personales requiera información adicional al Titular, en virtud de que la información entregada originalmente sea insuficiente o errónea para atenderla, o bien, no se acompañen los documentos antes indicados. Para tal efecto, el Departamento de Protección de Datos Personales le podrá requerir al Titular, por una vez y dentro de los cinco (5) días hábiles siguientes a la recepción de la solicitud, aporte los elementos o documentos necesarios para dar trámite a la misma, contando, por su parte, el Titular con diez (10) días naturales para atender el requerimiento, contados a partir del día siguiente en que lo haya recibido. Si el Titular no diere respuesta en dicho plazo se tendrá por no presentada la solicitud correspondiente. Por el contrario, en caso de que el Titular atienda el requerimiento de información, el plazo para que el Departamento de Protección de Datos Personales dé respuesta a la solicitud, empezará a correr al día siguiente de que el Titular haya atendido el requerimiento de información adicional.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Las respuestas que el Departamento de Protección de Datos Personales les otorgue a los Titulares que hubieren ejercido sus Derechos ARCO versarán únicamente sobre los Datos Personales que específicamente se hayan indicado en la solicitud en cuestión. Cuando el Responsable niegue el ejercicio de cualquiera de los Derechos ARCO, deberá justificar su respuesta, informando al Titular el derecho que le asiste para solicitar el inicio del procedimiento ante el Instituto Nacional de Transparencia, Acceso a la Información y Protección de Datos Personales.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Las obligaciones del Responsable derivadas del ejercicio de los Derechos ARCO por parte de los Titulares se concretan y cumplen con el debido seguimiento de cada caso en particular por parte del Departamento de Protección de Datos Personales como órgano en los términos especificados en el presente documento. La resolución que se genere después del desahogo del procedimiento mencionado, puede versar sobre los siguientes derechos:",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "A. Acceso a los Datos Personales: Se otorgará al Titular la información detallada que el Responsable guarde sobre sus Datos Personales. En tal virtud, la obligación de acceso a la información se dará por cumplida cuando se pongan a disposición del Titular, los Datos Personales mediante los medios electrónicos o mediante la aplicación digital desarrollada por Hola Cash tal y como se encuentran en sus sistemas.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "B. Rectificación de los Datos Personales: La obligación de rectificación se cumplirá cuando se permita al Titular la rectificación de sus Datos Personales inexactos en los sistemas de Hola Cash.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "C. Cancelación de los Datos Personales: Cuando los Datos Personales ya no son necesarios para los fines para los que fue recopilada o cuando se tenga sospecha de que el trato de los mismos no se ajusta a la Normatividad, el Departamento de Protección de Datos Personales practicará una encriptación de datos que bloquea su uso por el periodo especificado más adelante, con la finalidad de evitar su tratamiento, durante el plazo necesario en el que se deducirán las obligaciones legales que correspondan específicamente a los Datos Personales del Titular en cuestión y posteriormente, eliminar definitivamente los Datos Personales.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "D. Oposición a los Datos Personales: El Titular puede solicitar la revocación de su consentimiento para el tratamiento de sus Datos Personales oponiéndose al presente Aviso de Privacidad, no obstante en caso de que este supuesto se actualice, el Responsable dejará de prestar automáticamente el servicio al Usuario, cancelando su cuenta y finalizando definitivamente las relaciones jurídicas.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Las obligaciones de cancelación y oposición se darán por cumplidas mediante la terminación formal de las relaciones jurídicas entre los Titulares y smart lunch, pues el uso de los Datos Personales corresponde a una condición necesaria para que el Responsable otorgue los servicios a los Titulares, especialmente a los Comercios. En ese sentido, una vez finalizadas las relaciones jurídicas se procederá al periodo de bloqueo de sus Datos Personales en términos de la Ley, por un periodo de hasta diez (10) años según el caso en concreto, bloqueo que tecnológicamente se realiza con un método de encriptación de datos para impedir su tratamiento por persona alguna.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "No obstante lo anterior, el Responsable podrá conservar los Datos Personales de los Titulares durante períodos más largos cuando dicha acción sea necesaria para cumplir con obligaciones legales o para la adecuada defensa de sus intereses primordiales o los de una tercera persona, únicamente cuando se tenga interés legítimo para hacerlo o cuando una autoridad judicial o administrativa así lo haya requerido.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText(
                "Una vez finalizado el tiempo de bloqueo mencionado, se procederá a la definitiva eliminación de todos los Datos Personales del Titular, generando una constancia que acredite tal situación, misma que se entregará por los medios electrónicos idóneos.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText("REVOCACIÓN DEL CONSENTIMIENTO", 20, FontWeight.bold,
                TextAlign.center),
            formatText(
                "El Responsable garantiza el consentimiento del Titular para el tratamiento de sus Datos Personales, respetando en todo momento el alcance del principio de consentimiento previsto en la Ley. En tal virtud, el consentimiento que el Titular otorgue al presente Aviso de Privacidad podrá ser revocado en cualquier tiempo, sin que se le atribuyan efectos retroactivos. La revocación del consentimiento que pretendiera realizar el Titular deberá hacerse conforme a los medios y procedimiento previamente consignados en el numeral anterior.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText("RESPONSABILIDAD DEL TITULAR", 20, FontWeight.bold,
                TextAlign.center),
            formatText(
                "El Titular declara y garantiza la veracidad, exactitud y vigencia de los Datos Personales aportados, asumiendo el compromiso de mantenerlos actualizados.",
                14,
                FontWeight.normal,
                TextAlign.justify),
            formatText("CAMBIOS AL AVISO DE PRIVACIDAD", 20, FontWeight.bold,
                TextAlign.center),
            formatText(
                "El Responsable tiene el derecho de efectuar en cualquier momento modificaciones o actualizaciones al presente Aviso de Privacidad, con motivo de reformas legislativas, políticas internas o nuevos requerimientos para la prestación u ofrecimiento del servicio. Estas modificaciones se harán del conocimiento de los Titulares mediante dos métodos distintos para asegurar su pleno conocimiento: (i) estará disponible en la página de internet del Responsable con la fecha de la actualización; (ii) estará disponible en el Portal del Comerciante a que se refiere los Términos y Condiciones de smart lunch. En ambos casos se emitirá una notificación visible y accesible por los Titulares.",
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
