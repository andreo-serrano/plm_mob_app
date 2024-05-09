import 'package:flutter/material.dart';

import '../model/news_model.dart';
import 'news_card.dart';

class HorizontalNewsList extends StatelessWidget {
  const HorizontalNewsList({
    super.key,
    required this.news,
  });

  final List<News>? news;

  @override
  Widget build(BuildContext context) {
    return news == null
        ? Text('')
        : Visibility(
            visible: news!.isNotEmpty,
            child: SizedBox(
              height: 350,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: news!.length,
                itemBuilder: (context, index) {
                  return NewsCard(
                    news: news![index],
                  );
                },
              ),
            ),
          );
  }
}
