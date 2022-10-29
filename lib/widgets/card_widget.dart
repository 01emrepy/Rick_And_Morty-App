import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/screen/location/location_details.dart';

class Carddetail extends StatelessWidget {
  final String text;
  const Carddetail({
    Key? key,
    required this.widget,
    required this.text,
  }) : super(key: key);

  final locationDetails widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GlassmorphicContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.height * 0.4,
        blur: 20,
        border: 2,
        borderRadius: 20,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFffffff).withOpacity(0.1),
              Color(0xFFFFFFFF).withOpacity(0.05),
            ],
            stops: [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFffffff).withOpacity(0.5),
            Color((0xFFFFFFFF)).withOpacity(0.5),
          ],
        ),
        child: Text(text,
            textAlign: TextAlign.center,
            style: GoogleFonts.shadowsIntoLight(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
      ),
    );
  }
}
