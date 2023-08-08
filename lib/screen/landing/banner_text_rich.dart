import 'package:flutter/material.dart';

class BannerTextRich extends StatelessWidget {
  const BannerTextRich({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Bergabung bersama \n',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Jost',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.24,
            ),
          ),
          TextSpan(
            text: 'BOGOR CAREER CENTER',
            style: TextStyle(
              color: Color(0xFF15406A),
              fontSize: 16,
              fontFamily: 'Jost',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.24,
            ),
          ),
          TextSpan(
            text: ' \n',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Jost',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.24,
            ),
          ),
          TextSpan(
            text:
                'untuk berbagi informasi \nseputar Lowongan \nPekerjaan dan Kamu \ndapat mencari \nlowongan Pekerjaan \ndengan mudah.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Jost',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.24,
            ),
          ),
        ],
      ),
    );
  }
}
