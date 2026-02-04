import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({
    super.key,
    required this.color,
    required this.iconData,
    required this.title,
    required this.information,
    this.onTap,
  });

  final Color color;
  final IconData iconData;
  final String title;
  final String information;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(border: Border(bottom: BorderSide( color:  Colors.black12))),
            child: ListTile(
              leading:  Icon(
                iconData,
                color: color,
              ),
              title:                RichText(
                text: TextSpan(
                  children: [
                     TextSpan(
                      text: title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Comfortaa",
                        fontSize: 17.0,
                      ),
                    ),

                    (information=="" || information=="0")?
                    const TextSpan(
                      style: TextStyle(
                        color: Colors.black12,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Comfortaa",
                      ),
                      text: "",
                    ):
                    TextSpan(
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 13,
                        fontFamily: "Comfortaa",
                      ),
                      text: " ($information)",
                    )

                  ],
                ),
              ),


              trailing: const Icon(Icons.arrow_forward_ios_outlined, color:  Colors.black12 ),
            ),
          )
      ),
    );


  }
}
