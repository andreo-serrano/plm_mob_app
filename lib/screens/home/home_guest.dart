import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../about_plm/about_plm_screen.dart';
import '../academic_calendar/academic_calendar_screen.dart';
import '../admissions/admissions_screen.dart';
import '../alumni/alumni_screen.dart';
import '../auth/login_screen.dart';
import '../enroll/enroll_screen.dart';
import '../grades/grades_screen.dart';
import '../map/map_screen.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';
import '../schedule/schedule_screen.dart';
import '../../services/api_service.dart';
import '../../widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/news_model.dart';
import '../../widgets/daily_announcement.dart';
import '../../widgets/horizontal_news_list.dart';
import '../../widgets/list_header.dart';
import '../announcements/announcements_screen.dart';
import '../announcements/more_news_screen.dart';

void main() => runApp(const HomeGuestPage());

class HomeGuestPage extends StatefulWidget {
  const HomeGuestPage({Key? key}) : super(key: key);

  @override
  State<HomeGuestPage>  createState() => _HomeGuestPageState();
}

class _HomeGuestPageState extends State<HomeGuestPage>{
  final List<String> images = [
    'assets/images/On1.jpg',
    'assets/images/On2.jpg',
    'assets/images/On3.jpg',
  ];

  List<News>? news;
  List<News>? whatsNew;
  String firstName = '';

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  void loadNews() async {
    APIService apiService = new APIService();
    apiService.fetchNews().then((value) {
      // TODO: Limit news on API request
      news = value;
      whatsNew = news!.isEmpty ? [] : news!.sublist(0, 3);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: Home(
                expandedHeight: 180,
                firstName: '',
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Swiper(
                      itemBuilder: (context, index) {
                        final image = images[index];
                        return Image.asset(
                          image,
                          fit: BoxFit.cover,
                        );
                      },
                      indicatorLayout: PageIndicatorLayout.COLOR,
                      autoplay: true,
                      itemCount: images.length,
                      pagination: const SwiperPagination(),
                      control: const SwiperControl(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListHeader(
                    title: "What's new?",
                    onViewMore: news == null
                        ? () {}
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoreNewsPage(
                            pageTitle: 'More Announcements',
                            loadNews: () => news!,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  HorizontalNewsList(news: whatsNew),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ButtonFill(
                      buttonText: "Login",
                      bgColor: Colors.amber,
                      onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage())),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String firstName;

  Home({
    required this.expandedHeight,
    required this.firstName,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 3 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;

    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
              elevation: 0.0,
              toolbarHeight: 80.0,
              automaticallyImplyLeading: false,
              title: Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 21.0)),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Card(
                margin: EdgeInsets.all(15.0),
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonIcon(
                            buttonName: 'Admission',
                            icon: Icons.edit_note,
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdmissionsPage()))
                            },
                          ),
                          ButtonIcon(
                            buttonName: 'Academic\nCalendar',
                            icon: Icons.calendar_month,
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AcademicCalendar()))
                            },
                          ),
                          ButtonIcon(
                            buttonName: 'Maps',
                            icon: Icons.place,
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Maps()))
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ButtonIcon(
                            buttonName: 'About PLM',
                            icon: Icons.calendar_today,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutPLM()));
                            },
                          ),
                          ButtonIcon(
                            buttonName: 'Alumni',
                            icon: Icons.school,
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AlumniScreen()))
                            },
                          ),
                          ButtonIcon(
                            buttonName: 'Library',
                            icon: Icons.menu_book_sharp,
                            onPressed: () {
                              const url = 'https://library.plm.edu.ph/';
                              launch(url.toString());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
