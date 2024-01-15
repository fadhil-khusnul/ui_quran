import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_quran/globals.dart';
import 'package:ui_quran/models/ayat.dart';
import 'package:ui_quran/models/surat.dart';

class DetailScreen extends StatelessWidget {
  final int noSurat;
  const DetailScreen({super.key, required this.noSurat});

  Future<Datum> _getDetailSurat() async {
    try {
      var response = await Dio().get("https://equran.id/api/v2/surat/$noSurat");

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data["data"];
        Datum datum = Datum.fromJson(responseData);
        return datum;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Datum>(
        future: _getDetailSurat(),
        initialData: null,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: background,
            );
          }
          Datum surah = snapshot.data!;
          return Scaffold(
            backgroundColor: background,
            appBar: _appBar(context: context, surah: surah),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: _details(surah: surah),
                )
              ],
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.separated(
                  itemBuilder: (context, index) => _ayatItem(
                      ayat: surah.ayat!
                          .elementAt(index + (noSurat == 1 ? 1 : 0))),
                  itemCount: surah.jumlahAyat + (noSurat == 1 ? -1 : 0),
                  separatorBuilder: (context, index) => Container(),
                ),
              ),
            ),
          );
        }));
  }

  Widget _ayatItem({required Ayat ayat}) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                  color: bottomBarColor.withOpacity(.2),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                        color: secondary,
                        borderRadius: BorderRadius.circular(27 / 2)),
                    child: Center(
                        child: Text(
                      '${ayat.nomorAyat}',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: background),
                    )),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.share_outlined,
                    color: secondary,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Icon(
                    Icons.play_arrow_outlined,
                    color: secondary,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Icon(
                    Icons.bookmark_outline,
                    color: secondary,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              ayat.teksArab,
              style: GoogleFonts.amiri(
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                  fontSize: 20),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              ayat.teksIndonesia,
              style: GoogleFonts.poppins(color: text, fontSize: 14),
            )
          ],
        ),
      );

  Widget _details({required Datum surah}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Stack(children: [
          Container(
            height: 257,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0,
                      1,
                    ],
                    colors: [
                      Color(0XFF427D9D),
                      Color(0XFF164863)
                    ])),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Opacity(
                  opacity: .2,
                  child: SvgPicture.asset(
                    'assets/svg/quran.svg',
                    width: 324 - 55,
                  ))),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                Text(
                  surah.namaLatin,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 26),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  surah.arti,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                Divider(
                  color: Colors.white.withOpacity(.35),
                  thickness: 2,
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      surah.tempatTurun.name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${surah.jumlahAyat} Ayat",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                SvgPicture.asset('assets/svg/bismillah.svg')
              ],
            ),
          )
        ]),
      );

  AppBar _appBar({required BuildContext context, required Datum surah}) =>
      AppBar(
        backgroundColor: background,
        // automaticallyImplyLeading: false,
        foregroundColor: secondary,
        elevation: 0,
        title: Row(
          children: [
            // IconButton(
            //     onPressed: (() => Navigator.of(context).pop()),
            //     icon: SvgPicture.asset('assets/svg/back.svg')),
            // const SizedBox(
            //   width: 24,
            // ),
            Text(
              surah.namaLatin,
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Spacer(),
            IconButton(
                onPressed: (() => {}),
                icon: SvgPicture.asset('assets/svg/search.svg')),
          ],
        ),
      );
}
