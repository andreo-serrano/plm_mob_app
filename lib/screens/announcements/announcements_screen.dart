import 'package:flutter/material.dart';
import 'package:plmmobileapp_v2/widgets/daily_announcement.dart';
import '../../services/api_service.dart';

import '../../model/news_model.dart';
import '../../widgets/announcements_appbar.dart';
import '../../widgets/horizontal_news_list.dart';
import '../../widgets/list_header.dart';
import '../../widgets/news_card.dart';
import 'announcement_detail_screen.dart';
import 'more_news_screen.dart';

class AnnouncementsPage extends StatefulWidget {
  AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  List<News>? news;
  List<News>? announcements;
  List<News>? pressReleases;
  List<StudentNews>? studentNews;

  void fetchNews() async {
    APIService apiService = new APIService();
    apiService.fetchNews().then((value) {
      news = value;
      announcements =
          news!.where((element) => element.type == News.announcement).toList();
      pressReleases =
          news!.where((element) => element.type == News.pressRelease).toList();
      setState(() {});
    });
    apiService.fetchStudentNews().then((value) {
      // TODO: Limit news on API request
      studentNews = value;
      setState(() {});
    });
  }
  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnouncementsSliverAppBar(
        pageTitle: "PLM News",
        featuredArticle: news?[0],
        onReadMore: news == null
            ? () {}
            : () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailPage(news![0]),
            ),
          );
        },
        child: Column(children: [
          Column(
            children: [
              studentNews == null
                  ? const Center(
                child: Text(''),
              )
                  : Visibility(
                visible: studentNews!.isNotEmpty,
                child: DailyAnnouncement(studentNews: studentNews),
              ),

              const SizedBox(height: 20),
              ListHeader(
                title: 'Announcements',
                onViewMore: news == null
                    ? () {}
                    : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MoreNewsPage(
                        pageTitle: 'More Announcements',
                        loadNews: () => news!
                            .where((element) =>
                        element.type == News.announcement)
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              announcements == null
                  ? const Center(child: Text(''))
                  : HorizontalNewsList(news: announcements!),
              const SizedBox(height: 20),
              ListHeader(
                  title: 'Press Releases',
                  onViewMore: news == null
                      ? () {}
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoreNewsPage(
                          pageTitle: 'More Press Releases',
                          loadNews: () => news!
                              .where((element) =>
                          element.type == News.pressRelease)
                              .toList(),
                        ),
                      ),
                    );
                  }),
              const SizedBox(height: 10),
              pressReleases == null
                  ? const Center(child: Text(''))
                  : HorizontalNewsList(news: pressReleases!),
              const SizedBox(height: 40),
            ],
          ),
        ]),
      ),
    );
  }
}
