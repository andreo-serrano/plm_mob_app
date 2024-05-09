import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../../model/request.dart';
import '../../utils/constants.dart';
import '../about_plm/about_plm_screen.dart';
import '../academic_calendar/academic_calendar_screen.dart';
import '../admissions/admissions_screen.dart';
import '../alumni/alumni_screen.dart';
import '../enroll/enroll_screen.dart';
import '../grades/grades_screen.dart';
import '../library/library_screen.dart';
import '../map/map_screen.dart';
import '../profile/profile_screen.dart';
import '../schedule/schedule_screen.dart';
import '../sfe/student_home.dart';
import '../../services/api_service.dart';
import '../../widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/news_model.dart';
import '../../widgets/horizontal_news_list.dart';
import '../../widgets/list_header.dart';
import '../announcements/announcements_screen.dart';
import '../announcements/more_news_screen.dart';

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  final userId;
  final userRole;

  const HomePage({this.userId, this.userRole});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  bool exit = false;
  Future<bool> exitConfirm() async {
    return await showDialog(
          barrierDismissible: exit,
          context: context,
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text('Logout'),
              content: Text('Are you sure you want to logout? '),
              actions: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: ButtonFill(
                        buttonText: 'No',
                        onPressed: () => Navigator.pop(context),
                        bgColor: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: ButtonFill(
                        buttonText: 'Yes',
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        bgColor: error,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ) ??
        false;
  }

  // bool exit = false;
  // Future<bool> exitConfirm() async {
  //   return await showDialog(
  //         barrierDismissible: exit,
  //         context: context,
  //         builder: (context) => WillPopScope(
  //           onWillPop: () async => false,
  //           child: AlertDialog(
  //             title: Text('Logout'),
  //             content: Text('Are you sure you want to logout? '),
  //             actions: <Widget>[
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: ButtonFill(
  //                       buttonText: 'No',
  //                       onPressed: () => Navigator.pop(context),
  //                       bgColor: Colors.grey.shade200,
  //                     ),
  //                   ),
  //                   SizedBox(width: 10.0),
  //                   Expanded(
  //                     child: ButtonFill(
  //                       buttonText: 'Yes',
  //                       onPressed: () {
  //                         Navigator.of(context).pop(true);
  //                       },
  //                       bgColor: error,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ) ??
  //       false;
  // }

  @override
  Widget build(BuildContext context) {
    String userId = widget.userId;
    String userRole = widget.userRole;
    return WillPopScope(
      onWillPop: exitConfirm,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home_rounded),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.newspaper),
              icon: Icon(Icons.newspaper_outlined),
              label: 'Announcements',
            ),
            /*NavigationDestination(
            selectedIcon: Icon(Icons.notifications),
            icon: Icon(Icons.notifications_none),
            label: 'Notification',
          ),*/
            NavigationDestination(
              selectedIcon: Icon(Icons.account_circle),
              icon: Icon(Icons.account_circle_outlined),
              label: 'Account',
            ),
          ],
        ),
        body: <Widget>[
          HomeContent(userId: userId, userRole: userRole),
          AnnouncementsPage(),
          // NotificationPage(),
          ProfilePage(),
        ][currentPageIndex],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final userId;
  final userRole;

  const HomeContent({this.userId, this.userRole});
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<String> images = [
    'assets/images/On1.jpg',
    'assets/images/On2.jpg',
    'assets/images/On3.jpg',
  ];

  List<News>? news;
  List<StudentNews>? studentNews;
  List<News>? whatsNew;
  String firstName = '';
  String whatsNewText = '';

  @override
  void initState() {
    super.initState();
    loadNews();
    fetchInformation();
  }

  void fetchInformation() async {
    APIService apiService = new APIService();
    apiService.user().then((value) async => {
          await UserSecureStorage.setFirstName(value.firstname),
          await UserSecureStorage.setFirstName(value.firstname),
        });
    firstName = await UserSecureStorage.getFirstName() ?? '';
    setState(() {});
  }

  void loadNews() async {
    APIService apiService = new APIService();
    apiService.fetchNews().then((value) {
      // TODO: Limit news on API request
      news = value;
      whatsNew = news!.isEmpty ? [] : news!.sublist(0, 3);
      if (news!.isEmpty) {
        whatsNewText = '';
      } else {
        whatsNewText = "What's New?";
      }
      setState(() {});
    });
    // apiService.fetchStudentNews().then((value) {
    //   // TODO: Limit news on API request
    //   studentNews = value;
    //   setState(() {});
    // });
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
                firstName: firstName,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // studentNews == null
                  //     ? const Center(
                  //         child: CircularProgressIndicator(),
                  //       )
                  //     : Visibility(
                  //         visible: studentNews!.isNotEmpty,
                  //         child: DailyAnnouncement(studentNews: studentNews),
                  //       ),
                  // studentNews == null
                  //     ? const Center(
                  //         child: CircularProgressIndicator(),
                  //       )
                  //     : Visibility(
                  //         visible: studentNews!.isNotEmpty,
                  //         child: DailyAnnouncement(studentNews: studentNews),
                  //       ),
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
                    title: whatsNewText,
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
                  // const SizedBox(height: 10),
                  HorizontalNewsList(news: whatsNew),
                  // const SizedBox(height: 10),
                  // Container(
                  //   alignment: Alignment.topLeft,
                  //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //     child: Text('More', style: Theme.of(context).textTheme.titleLarge)
                  // ),
                  // const SizedBox(height: 10),
                  // Container(
                  //   alignment: Alignment.topLeft,
                  //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //     child: Text('More', style: Theme.of(context).textTheme.titleLarge)
                  // ),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ButtonIcon(
                          buttonName: 'SFE',
                          icon: Icons.check_circle_outline,
                          onPressed: () {
                            if (widget.userRole == 'student') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SFEHomePage(userId: widget.userId)));
                            } else {
                              // TODO: Add Verification of User and Their Layouts
                            }
                          },
                        ),
                        ButtonIcon(
                          buttonName: 'Library',
                          icon: Icons.menu_book_sharp,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LibraryScreen()));
                          },
                        ),
                        ButtonIcon(
                          buttonName: 'CRS',
                          icon: Icons.account_balance,
                          onPressed: () {
                            const url = 'https://web1.plm.edu.ph/crs/';
                            launch(url.toString());
                          },
                        ),
                      ]),
                  const SizedBox(height: 50),
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
                  "Welcome, ${firstName[0].toUpperCase()}${firstName.substring(1).toLowerCase()}!",
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
                              buttonName: 'Grades',
                              icon: Icons.note_outlined,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Grades()));
                              }),
                          ButtonIcon(
                            buttonName: 'Schedule',
                            icon: Icons.calendar_today,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Schedule()));
                            },
                          ),
                          ButtonIcon(
                            buttonName: 'Enroll',
                            icon: Icons.verified,
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EnrollPage()))
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
