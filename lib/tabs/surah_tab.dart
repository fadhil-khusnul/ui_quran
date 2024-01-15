import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  Future _getSurahList() async {
    String data = await rootBundle.loadString('assets/data/listSurah.json');

    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getSurahList(), builder: ((context, snapshot) => Container()));
  }
}
