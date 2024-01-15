import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_quran/globals.dart';
import 'package:ui_quran/tabs/hijb_tab.dart';
import 'package:ui_quran/tabs/page_tab.dart';
import 'package:ui_quran/tabs/parah_tab.dart';
import 'package:ui_quran/tabs/surah_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: DefaultTabController(
        length: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: _greeting(),
              ),
              SliverAppBar(
                pinned: true,
                elevation: 0,
                backgroundColor: background,
                automaticallyImplyLeading: false,

                // shape: Border(
                //     bottom: BorderSide(
                //       width: 3,
                //   color: const Color(0XFFB2C4D1).withOpacity(0.5),
                // )),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: _tab(),
                ),
              )
            ],
            body: const TabBarView(
              children: [SurahTab(), ParahTab(), PageTab(), HijbTab()],
            ),
          ),
        ),
      ),
    );
  }

  TabBar _tab() {
    return TabBar(
        unselectedLabelColor: const Color(0XFFB2C4D1).withOpacity(0.5),
        labelColor: Colors.white,
        indicatorColor: primary,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.tab ,
        tabs: [
          _tabItems(label: "Surah"),
          _tabItems(label: "Para"),
          _tabItems(label: "Page"),
          _tabItems(label: "Hijb"),
        ]);
  }

  Tab _tabItems({required String label}) {
    return Tab(
      child: Text(label),
    );
  }

  Column _greeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 4,
        ),
        Text(
          'Assalamualaikum',
          style: GoogleFonts.poppins(
              fontSize: 12, fontWeight: FontWeight.w500, color: text),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Hamba Allah',
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        const SizedBox(
          height: 24,
        ),
        _lastRead()
      ],
    );
  }

  Stack _lastRead() {
    return Stack(
      children: [
        Container(
          height: 131,
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
            child: SvgPicture.asset('assets/svg/quran.svg')),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/svg/book.svg'),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Last Read",
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Al-Fatiha",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Ayat No: 1",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: bottomBarColor.withOpacity(0.2),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          _bottomBarItem(icon: "assets/svg/bottom1.svg", label: "Quran"),
          _bottomBarItem(icon: "assets/svg/bottom2.svg", label: "Tips"),
          _bottomBarItem(icon: "assets/svg/bottom3.svg", label: "Prayer"),
          _bottomBarItem(icon: "assets/svg/bottom4.svg", label: "Doa"),
          _bottomBarItem(icon: "assets/svg/bottom5.svg", label: "Bookmark"),
        ],
      );

  BottomNavigationBarItem _bottomBarItem(
          {required String icon, required String label}) =>
      BottomNavigationBarItem(
        icon: SvgPicture.asset(icon, color: text),
        activeIcon: SvgPicture.asset(icon, color: primary),
        label: label,
      );

  AppBar _appBar() => AppBar(
        backgroundColor: background,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
                onPressed: (() => {}),
                icon: SvgPicture.asset('assets/svg/menu.svg')),
            const SizedBox(
              width: 24,
            ),
            Text(
              'Quran App',
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
