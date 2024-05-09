import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../model/news_model.dart';
import '../../widgets/student_news_container.dart';

class DailyAnnouncement extends StatelessWidget {
  const DailyAnnouncement({
    super.key,
    required this.studentNews,
  });

  final List<StudentNews>? studentNews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Today's Announcements",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    studentNews!.length.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 130,
            child: Swiper(
              itemBuilder: (context, index) {
                StudentNews currStudNews = studentNews![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: StudentNewsContainer(
                    news: currStudNews,
                  ),
                );
              },
              indicatorLayout: PageIndicatorLayout.COLOR,
              itemCount: studentNews!.length,
              pagination: const SwiperPagination(),
              control: const SwiperControl(),
              loop: false,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
